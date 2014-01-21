# -*- coding: UTF-8 -*-
from pyramid.response import FileResponse, Response
from pyramid.renderers import render_to_response
from pyramid.httpexceptions import HTTPForbidden, HTTPBadRequest
from pyramid.view import view_config


from datetime import datetime, time
import httplib, urllib2
import pkg_resources
from geojson import Feature, FeatureCollection, dumps, loads as gloads
from simplejson import loads as sloads,dumps as sdumps
from geoalchemy import *
from PIL import Image

from crdppf.models import *
from crdppf.util.pdf_functions import get_translations, get_feature_info, get_print_format, get_XML
from crdppf.util.pdf_classes import PDFConfig, Extract
from crdppf.util.get_feature_functions import get_features_function

from PyPDF2 import PdfFileMerger,PdfFileReader,PdfFileWriter

@view_config(route_name='create_extract')
def create_extract(request):
    """The function collects alle the necessary data from the subfunctions and classes
       and then writes the pdf file of the extract."""

    # Start a session
    session = request.session

    # Create an instance of an extract
    extract = Extract(request)

    # Define the extract type if not set in the request parameters
    # defaults to 'standard': no certification, with pdf attachements
    # other values :
    # certified : with certification and with all pdf attachements
    # reduced : no certification, no pdf attachements
    # reducedcertified : with certification, without pdf attachments

    extract.reportInfo = {}
    defaulttype = 'standard'

    if request.params.get('type') :
        extract.reportInfo['type'] = str(request.params.get('type').lower())
    else : 
        extract.reportInfo['type'] = defaulttype

    # Define language to get multilingual labels for the selected language
    # defaults to 'fr': french - this may be changed in the appconfig
    if 'lang' not in session:
        lang = request.registry.settings['default_language'].lower()
    else : 
        lang = session['lang'].lower()
    extract.translations = get_translations(lang)

    # GET the application configuration parameters such as base paths,
    # working directory and other default parameters
    extract.load_app_config()
    
    # GET the PDF Configuration parameters such as the page layout, margins
    # and text styles
    extract.set_pdf_config()

    # promote often used variables to facilitate coding
    pdfconfig = extract.pdfconfig
    translations = extract.translations

    # to get vars defined in the buildout  use : request.registry.settings['key']
    pdfconfig.sld_url = extract.sld_url


# *************************
# MAIN PROGRAM PART
#=========================

    # 1) If the ID of the parcel is set get the basic attributs of the property
    # else get the ID (idemai) of the selected parcel first using X/Y coordinates of the center 
    #----------------------------------------------------------------------------------------------------
    extract.featureInfo = get_feature_info(request,translations) # '1_14127' # test parcel or '1_11340'
    featureInfo = extract.featureInfo

    # complete the dictionnary for the parcel - to be put in the appconfig
    extract.featureInfo['operator'] = translations['defaultoperatortext']
    
    extract.featureid = featureInfo['featureid']
    extract.set_filename()

    # the get_print_format function which would define the ideal paper format and orientation for the
    # extract. It is not needed any longer as the paper size has been fixed to A4 portrait by the cantons
    # BUT there could be a change of opinion after the start phase, so we keep this code part for now
    extract.printformat = get_print_format(featureInfo['BBOX'],pdfconfig.fitratio)

    # 2) Get the parameters for the paper format and the map based on the feature's geometry
    #---------------------------------------------------------------------------------------------------
    extract.get_map_format()
    # again we promote the variables one level
    printformat = extract.printformat

    # 3) Get the list of all the restrictions by topicorder set in a column
    #-------------------------------------------
    extract.topics = DBSession.query(Topics).order_by(Topics.topicorder).all()

    # Get the community name and escape special chars to place the logo in the header of the title page
    municipality = featureInfo['nomcom'].strip()

    # AS does the german language, the french contains a few accents we have to replace to fetch the banner which has no accents in its pathname...
    conversion = [
        [u'â', 'a'],
        [u'ä' ,'a'],
        [u'à', 'a'],
        [u'ô', 'o'],
        [u'ö', 'o'],
        [u'ò', 'o'],
        [u'û', 'u'],
        [u'ü', 'u'],
        [u'ù', 'u'],
        [u'î', 'i'],
        [u'ï', 'i'],
        [u'ì', 'i'],
        [u'ê', 'e'],
        [u'ë', 'e'],
        [u'è', 'e'],
        [u'é', 'e'],
        [u' ', ''],
        [u'-','_'],
        [u'(NE)', ''],
        [u' (NE)', '']
    ]

    municipality_escaped = municipality.strip()

    for char in conversion:
        municipality_escaped = municipality_escaped.replace(char[0], char[1])

    extract.municipalitylogopath = extract.appconfig.municipalitylogodir + municipality_escaped + '.png'
    extract.municipality = municipality # to clean up once code modified

    # Get the data for the federal data layers using the map extend
    #~ for topic in extract.topics:
        #~ if topic.topicid in extract.appconfig.ch_topics:
            #~ xml_layers = []
            #~ for xml_layer in topic.layers:
                #~ xml_layers.append(xml_layer.layername)
            #~ get_XML(extract.featureInfo['geom'],topic.topicid)

    # 4) Create the title page for the pdf extract
    #--------------------------------------------------
    extract.get_site_map()

    # 5) Create the pages of the extract for each topic in the list
    #---------------------------------------------------
    # Thematic pages
    
    for topic in extract.topics:
        extract.add_topic(topic)
        # to print the topics in ther right order - this could probably be done in a more elegant way
        extract.topicorder[topic.topicorder] = topic.topicid

    # Write pdf file to disc
    extract.get_title_page()
    
    # Create the table of content
    #--------------------------------------------------
    extract.get_toc()
    
    # Create the list of appendices
    #--------------------------------------------------
    extract.Appendices()

    for topic in extract.topicorder.values():
        extract.write_thematic_page(topic)

    j = 1
    # If report type is not 'reduced': Add a title page in front of every attached pdf
    if extract.reportInfo['type'] != 'reduced' and extract.reportInfo['type'] != 'reducedcertified':
        for appendix in extract.appendix_entries:
            extract.add_page()
            extract.set_margins(*pdfconfig.pdfmargins)
            extract.set_y(55)
            extract.set_link(str(j))
            extract.set_font(*pdfconfig.textstyles['title3'])
            extract.cell(15, 10, str('Annexe '+str(j)), 0, 1, 'L')
            extract.cell(100, 10, str(appendix['title']), 0, 1, 'L')
            j = j+1

    # Set the page number once all the pages are printed
    for key in extract.pages.keys():
        extract.pages[key] = extract.pages[key].replace('{no_pg}', str(' ')+str(key))

    extract.output(pdfconfig.pdfpath+pdfconfig.pdfname+'.pdf','F')

    # TO DO
    # Add all the appendices requested using pyPDF2
    #path = extract.appconfig.legaldocsdir+str('exemple.pdf')
    path = 'C:/Mapfish/crdppf/crdppf/static/public/reglements/exemple.pdf'
    input1 = PdfFileReader(file(path,'rb'))
    #~ input2 = PdfFileReader(file("C:\\GEHEIM2.pdf", "rb"))
    
    #~ filenames = [path]
    #~ merger = PdfFileMerger()
    #~ for filename in filenames:
        #~ merger.append(PdfFileReader(file(filename, 'rb')))

    for page in range(input1.getNumPages()):
        #~ output.addPage(input1.getPage(page))
        extract.addPage(input1.getPage(page))
        print 'Added page %s from first file'%page

    #~ for page in range(input2.getNumPages()):
        #~ output.addPage(input2.getPage(page))
        #~ print 'Added page %s from second file'%page
        
    #~ outputStream = file("c:\\temp\document-output.pdf", "wb")
    #~ output.write(outputStream)
    #~ outputStream.close()

    response = FileResponse(
        pdfconfig.pdfpath + pdfconfig.pdfname + '.pdf',
        request,
        None,
        'application/pdf'
    )
    response. content_disposition='attachment; filename='+ pdfconfig.pdfname +'.pdf'
    return response
