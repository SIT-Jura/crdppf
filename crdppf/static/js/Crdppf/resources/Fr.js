Ext.namespace('Crdppf');

// Themes structure and content definition
Crdppf.layerListFr = {
    "type": "ThemesCollection",
        'themes' :[  
                        {'id':'73','image':'amenagement.gif','name':'Zones Affectation', 'layers':{'at14_zones_communales':'Zones communales','at08_zones_cantonales':'Zones cantonales','at39_itineraires_pedestres':'Itin�raires p�destres'}},
                        {'id':'108','image':'aeroports.gif','name':'A�roports', 'layers':{'clo_couloirs':'Couloirs d\'obstacles a�riens','clo_cotes_altitude_surfaces':'Cotes d\'altitude des surfaces'}},
                        {'id':'116','image':'sites_pollues.gif','name':'Cadastre des sites pollu�s','layers':{'en07_canepo_accidents':'Sites pollu�es : accidents','en07_canepo_decharges':'Sites pollu�s : d�charges','en07_canepo_decharges_points':'Sites pollu�s : d�charges (points)','en07_canepo_decharges_polygones':'Sites pollu�s : d�charges (polygones)', 'en07_canepo_entreprises':'Sites pollu�s : entreprises', 'en07_canepo_entreprises_points':'Sites pollu�s : entreprises (points)', 'en07_canepo_entreprises_polygones':'Sites pollu�s : entreprises (polygones)'}},
                        {'id':'999','image':'foret.gif','name':'For�ts','layers':{'at39_itineraires_pedestres':'Itin�raires p�destres'}},
                        {'id':'998','image':'routes_nationales.gif','name':'Routes nationales','layers':{'at39_itineraires_pedestres':'Itin�raires p�destres'}},                        
                        {'id':'997','image':'protection_eaux.gif','name':'Protection des eaux','layers':{'at39_itineraires_pedestres':'Itin�raires p�destres'}},
                        {'id':'996','image':'bruit.gif','name':'Bruit','layers':{'at39_itineraires_pedestres':'Itin�raires p�destres'}}
        ]
    };
    
// Application labels text values for french  
Crdppf.labelsFr  ={
    'navPanelLabel':'Navigation',
    'searchBoxTxt':'Rechercher...',
    'themeSelectorLabel':'S�lection des th�mes',
    'mapContainerTab':'Carte',
    'legalBasisTab':'Bases l�gales',
    'layerTreeTitle':'Arbre des couches',
    'selectAllLayerLabel':'S�lectionner toutes les couches',
    'lawTabLabel':'Dispositions l�gales',
    'additionnalInfoTab':'Informations et renvois suppl�mentaires',
    'infoTabLabel':'Informations',
    'legendPanelTitle':'L�gende',
    'searchBoxEmptyTxt':'Rechercher...',
    'olCoordinates':'Coordonn�es',
    'restrictionPanelTitle':'Restrictions',
    'restrictionPanelTxt':'Restrictions affectant la parcelle n� ',
    'noActiveLayertxt':'Aucune couche active',
    'restrictionFoundTxt':'Restriction n� ',
    'disclaimerTxt':'Mise en garde : Le canton de Neuch�tel n\'engage pas sa responsabilit� sur l\'exactitude ou la fiabilit� des documents l�gislatifs dans leur version �lectronique. Ces documents ne cr�ent aucun autre droit ou obligation que ceux qui d�coulent des textes l�galement adopt�s et publi�s, qui font seuls foi.',
    'mapBottomTxt':'<b>Informations d�pourvues de foi publique, <a style="color:#660000;" href="http://sitn.ne.ch/web/conditions_utilisation/contrat_SITN_MO.htm" target="_new">&copy; SITN</a></b>',
    'maxTitleOverviewMap':'Afficher la carte de situation',
    'minTitleOverviewMap':'Masquer la carte de situation'
    };