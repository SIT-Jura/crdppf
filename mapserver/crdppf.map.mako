MAP
NAME CRDPPF
STATUS ON
SIZE 400 300
UNITS METERS
TRANSPARENT on
MAXSIZE 4096
SYMBOLSET "crdppf.sym"
FONTSET fonts.txt

#CONFIG "MS_ERRORFILE" "/tmp/ms.log"
DEBUG 5
EXTENT ${extend_mapfile}

WEB
    IMAGEPATH "/tmp"
    METADATA
        "ows_title" "CRDPPF OWS server"
        "ows_enable_request" "*"
        "wfs_encoding" "utf-8"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
        "wms_srs" "ESG:${srid}"
    END
END

IMAGETYPE png24
IMAGECOLOR 255 255 255
TRANSPARENT OFF

RESOLUTION 100
DEFRESOLUTION 100

OUTPUTFORMAT
    NAME png24
    DRIVER "AGG/PNG"
    MIMETYPE "image/png"
    IMAGEMODE "RGB"
    EXTENSION "png"
END

OUTPUTFORMAT
    NAME jpeg
    DRIVER "AGG/JPEG"
    MIMETYPE "image/jpeg"
    EXTENSION "jpeg"
    FORMATOPTION QUALITY=88
END

PROJECTION
  "init=epsg:${srid}"   ##required
END

LEGEND
    STATUS ON        # Draw legend in the map
    KEYSIZE 17 10      # Define the size of the legend icon.
    LABEL            # Used only for embedded legend (in the map)
        TYPE TRUETYPE
        FONT "verdana"
        COLOR 0 0 0
        SIZE 8
        ANTIALIAS TRUE
    END
END


# A scalebar object is defined one level below the map object.  This object
# controls how a scalebar is drawn by MapServer.  Scalebars can be embedded
# in the map itself or can be created as a separate image.  It has an
# associated MapServer CGI variable called "scalebar" (or [scalebar] when
# used in the HTML template).
SCALEBAR
    IMAGECOLOR 255 255 255
    LABEL
        COLOR 0 0 0
        SIZE SMALL
    END
    STYLE 0
    SIZE 300 10
    COLOR 0 0 0
    UNITS METERS
    INTERVALS 5
    TRANSPARENT FALSE
    STATUS OFF
END # Scalebar object ends

LAYER
    NAME "parcelles"
    TYPE POLYGON
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.cad_bien_fonds using unique objectid using srid=${srid}"
    STATUS ON
    TEMPLATE "foo"
    CLASS
        NAME "name1"
        STYLE
            OUTLINECOLOR 120 120 0
        END
    END
    METADATA
        "ows_title" "parcelles"
        "wms_srs" "epsg:${srid}"
        "wfs_enable_request" "*"
        "gml_types" "auto"
        "gml_include_items" "all"
    END
    PROJECTION
        "init=epsg:${srid}"   ##required
    END
END

######################
# RESTRICTIONS CRDPPF - début
######################
LAYER
    NAME "r73_contenus_ponctuels"
    TYPE POINT
    METADATA
        "ows_title" "r73_contenus_ponctuels"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r73_contenus_ponctuels using unique idobj using srid=${srid}"
    STATUS ON
    CLASSITEM "trie"
    OPACITY 60
    TEMPLATE "ttt"
    CLASS
        NAME "Bâtiment inscrit au RBC"
        EXPRESSION "Bâtiment inscrit au RBC"
        STYLE
            SYMBOL "carre"
            SIZE 16
            WIDTH 3
            COLOR 255 0 0
        END
    END
    CLASS
        NAME "Bâtiment protégé"
        EXPRESSION "Bâtiment protégé"
        STYLE
            SYMBOL "carre_croix"
            SIZE 16
            WIDTH 3
            COLOR 255 0 0
        END
    END
    CLASS
        NAME "Grenier"
        EXPRESSION "Grenier"
        STYLE
            SYMBOL "losange"
            SIZE 16
            WIDTH 3
            COLOR 255 0 0
        END
    END
    CLASS
        NAME "Fontaine"
        EXPRESSION "Fontaine"
        STYLE
            SYMBOL "triangle_vide"
            SIZE 16
            WIDTH 3
            COLOR 255 0 0
        END
    END
    CLASS
        NAME "Croix"
        EXPRESSION "Croix"
        STYLE
            SYMBOL "croix_chretienne"
            SIZE 8
            WIDTH 3
            COLOR 255 0 0
        END
        STYLE
            SYMBOL "cercle_plein"
            SIZE 8
            COLOR 255 0 0
        END
    END
    CLASS
        NAME "Borne"
        EXPRESSION "Borne"
        STYLE
            SYMBOL "carre"
            SIZE 14
            WIDTH 3
            COLOR 255 0 0
        END
        STYLE
            SYMBOL "cercle_plein"
            SIZE 3
            COLOR 255 0 0
        END
    END
    CLASS
        NAME "Objet local"
        EXPRESSION "Objet local"
        STYLE
            SYMBOL "etoile_vide"
            SIZE 18
            WIDTH 3
            COLOR 255 0 0
        END
    END
    CLASS
        NAME "Site d'exploitation du fer"
        EXPRESSION "Site d'exploitation du fer"
        STYLE
            SYMBOL "etoile"
            SIZE 18
            COLOR 255 0 0
        END
    END
    CLASS
        NAME "Site archéologique"
        EXPRESSION "Site archéologique"
        STYLE
            SYMBOL "cercle_plein"
            SIZE 16
            COLOR 255 0 0
        END
    END
    CLASS
        NAME "Arbre"
        EXPRESSION "Arbre"
        STYLE
            SYMBOL "cercle_plein"
            SIZE 9
            COLOR 168 255 0
            OUTLINECOLOR 168 255 0
        END
    END
    CLASS
        NAME "Grotte"
        EXPRESSION "Grotte"
        STYLE
            SYMBOL "cercle_plein"
            SIZE 16
            COLOR 255 0 0
        END
        STYLE
            SYMBOL "etoile"
            SIZE 15
            COLOR 255 255 255
        END
    END
    CLASS
        NAME "Elément hors légende-type"
        EXPRESSION "Elément hors légende-type"
        STYLE
            SYMBOL "cercle_plein"
            SIZE 12
            COLOR 140 0 255
        END
    END
    TOLERANCE 8
    TOLERANCEUNITS pixels
END

LAYER
    NAME "r73_contenus_lineaires"
    TYPE LINE
     METADATA
        "ows_title" "r73_contenus_lineaires"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r73_contenus_lineaires using unique idobj using srid=${srid}"
    STATUS ON
    CLASSITEM "trie"
    OPACITY 60
    TEMPLATE "ttt"
    CLASS
        NAME "Bosquet, haie"
        EXPRESSION "Bosquet, haie"
        STYLE
            WIDTH 6
            OUTLINECOLOR 168 255 0
        END
    END
    CLASS
        NAME "Cours d'eau et plan d'eau"
        EXPRESSION "Cours d'eau et plan d'eau"
        STYLE
            WIDTH 4
            OUTLINECOLOR 0 214 255
        END
    END
    CLASS
        NAME "Allée d'arbres"
        EXPRESSION "Allée d'arbres"
        STYLE
            SYMBOL 'cercle_plein'
            SIZE 8
            COLOR 168 255 0
            OUTLINECOLOR 0 0 0
            WIDTH 2
            GAP 25
        END
    END
    CLASS
        NAME "Mur de pierres sèches"
        EXPRESSION "Mur de pierres sèches"
        STYLE
            SYMBOL ligne_noir
            SIZE 10
            COLOR 0 0 0
        END
    END
    CLASS
        NAME "Chemin IVS"
        EXPRESSION "Chemin IVS"
        STYLE
            SYMBOL cercle_vide
            SIZE 8
            WIDTH 2
            COLOR 255 0 0
            GAP 10
        END
    END
    CLASS
        NAME "Elément hors légende-type"
        EXPRESSION "Elément hors légende-type"
        STYLE
            OUTLINECOLOR 140 0 255
            WIDTH 2
        END
    END
END

LAYER
    NAME "r73_perimetres_superposes_polygon"
    GROUP "r73_perimetres_superposes"
    TYPE POLYGON
    METADATA
        "ows_title" "r73_perimetres_superposes"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r73_perimetres_superposes using unique idobj using srid=${srid}"
    STATUS ON
    CLASSITEM "trie"
    OPACITY 90
    TEMPLATE "ttt"
    LABELITEM 'abreviation'
#    LABELMINSCALEDENOM 100
    LABELMAXSCALEDENOM 7500
    CLASS
        NAME "Secteur avec plan spécial en vigueur"
        EXPRESSION "Secteur avec plan spécial en vigueur"
        STYLE
            WIDTH 4
            OUTLINECOLOR 255 0 0
        END
    END
    CLASS
        NAME "Secteur à développer par plan spécial"
        EXPRESSION "Secteur à développer par plan spécial"
        STYLE
            WIDTH 4
            OUTLINECOLOR 255 0 0
            PATTERN 16 8 16 8 END
        END
    END
    CLASS
        NAME "Périmètre de protection archéologique"
        EXPRESSION "Périmètre de protection archéologique"
        STYLE
            WIDTH 1
            OUTLINECOLOR 255 0 0
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 9
            ANTIALIAS TRUE
            COLOR 255 0 0
            OUTLINECOLOR 255 255 255
        END
    END
    CLASS
        NAME "Périmètre de protection des vergers"
        EXPRESSION "Périmètre de protection des vergers"
        STYLE
            SYMBOL "trame_verte"
        END
        STYLE
            OUTLINECOLOR 0 230 0
            WIDTH 1
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 9
            ANTIALIAS TRUE
            COLOR 0 230 0
            OUTLINECOLOR 255 255 255
        END
    END
    CLASS
        NAME "Périmètre de protection du paysage"
        EXPRESSION "Périmètre de protection du paysage"
        STYLE
            COLOR 255 0 0
            SYMBOL "hatchsymbol"
            SIZE 16
            WIDTH 3
            ANGLE 0
        END
        STYLE
            OUTLINECOLOR 255 0 0
            WIDTH 1
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 9
            ANTIALIAS TRUE
            COLOR 255 0 0
            OUTLINECOLOR 255 255 255
        END
    END
    CLASS
        NAME "Périmètre de protection de la nature"
        EXPRESSION "Périmètre de protection de la nature"
        STYLE
            COLOR 255 0 0
            SYMBOL "hatchsymbol"
            SIZE 16
            WIDTH 3
            ANGLE 45
        END
        STYLE
            OUTLINECOLOR 255 0 0
            WIDTH 1
        END
            LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 9
            ANTIALIAS TRUE
            COLOR 255 0 0
            OUTLINECOLOR 255 255 255
        END
    END
    CLASS
        NAME "Périmètre de protection de la nature renforcé"
        EXPRESSION "Périmètre de protection de la nature renforcé"
        STYLE
            COLOR 255 0 0
            SYMBOL "hatchsymbol"
            SIZE 8
            WIDTH 3
            ANGLE 45
        END
        STYLE
            OUTLINECOLOR 255 0 0
            WIDTH 1
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 9
            ANTIALIAS TRUE
            COLOR 255 0 0
            OUTLINECOLOR 255 255 255
        END
    END
    CLASS
        NAME "Périmètre de territoire à habitat traditionnellement dispersé"
        EXPRESSION "Périmètre de territoire à habitat traditionnellement dispersé"
        STYLE
            OUTLINECOLOR 170 100 0
            WIDTH 4
            PATTERN 20 8 END
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 9
            ANTIALIAS TRUE
            COLOR 170 100 0
            OUTLINECOLOR 255 255 255
        END
    END
    CLASS
        NAME "Périmètre de danger naturel"
        EXPRESSION "Périmètre de danger naturel"
        STYLE
            WIDTH 1
            OUTLINECOLOR 255 0 0
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 9
            ANTIALIAS TRUE
            COLOR 255 0 0
            OUTLINECOLOR 255 255 255
        END
    END
    CLASS
        NAME "Périmètre réservé aux eaux"
        EXPRESSION "Périmètre réservé aux eaux"
        STYLE
            COLOR 0 0 255
            SYMBOL "hatchsymbol"
            SIZE 16
            WIDTH 3
            ANGLE -45
        END
        STYLE
            OUTLINECOLOR 0 0 255
            WIDTH 1
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 9
            ANTIALIAS TRUE
            COLOR 0 0 255
            OUTLINECOLOR 255 255 255
        END
    END
    CLASS
        NAME "Doline"
        EXPRESSION "Doline"
        STYLE
            OUTLINECOLOR 0 0 0
            WIDTH 2
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 9
            ANTIALIAS TRUE
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
        END
    END
    CLASS
        NAME "Bosquet, haie"
        EXPRESSION "Bosquet, haie"
        STYLE
            COLOR 168 255 0
        END
    END
    CLASS
        NAME "Cours d'eau et plan d'eau"
        EXPRESSION "Cours d'eau et plan d'eau"
        STYLE
            COLOR 0 214 255
            OUTLINECOLOR 0 214 255
            WIDTH 2
        END
    END
    CLASS
        NAME "Marais, zone humide"
        EXPRESSION "Marais, zone humide"
        STYLE
            SYMBOL "trame_bleu"
        END
        STYLE
            OUTLINECOLOR 0 214 255
            WIDTH 1
        END
    END
    CLASS
        NAME "Elément hors légende-type"
        EXPRESSION "Elément hors légende-type"
        STYLE
            COLOR 140 0 255
            SYMBOL "hatchsymbol"
            SIZE 8
            WIDTH 2
            ANGLE -45
        END
        STYLE
            OUTLINECOLOR 140 0 255
            WIDTH 1
        END
    END
END

LAYER
    NAME "r73_perimetres_superposes_Ligne"
    GROUP "r73_perimetres_superposes"
    TYPE line
    STATUS ON
    METADATA
        "ows_title" "r73_perimetres_superposes"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    PROJECTION
        "init=epsg:${srid}"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r73_perimetres_superposes using unique idobj using srid=${srid}"
    CLASSITEM "teneur"
#    MINSCALEDENOM 7500
    MAXSCALEDENOM 25000
    CLASS
        NAME "Périmètre de protection archéologique"
        EXPRESSION "Périmètre de protection archéologique"
        STYLE
            SYMBOL "cercle_plein"
            SIZE 10
            COLOR 255 0 0
            GAP 10
        END
    END
    CLASS
        NAME "Périmètre de danger naturel"
        EXPRESSION "Périmètre de danger naturel"
        STYLE
            COLOR 255 0 0
            WIDTH 1
        END
        STYLE
            SYMBOL "triangle_2"
            SIZE 10
            COLOR 255 0 0
            ANGLE 90
            GAP -20
        END
    END
    CLASS
        NAME "Doline"
        EXPRESSION "Doline"
        STYLE
            COLOR 0 0 0
            WIDTH 1
        END
        STYLE
            SYMBOL "triangle_2"
            SIZE 4
            COLOR 0 0 0
            ANGLE 90
            GAP -20
        END
    END
END

LAYER
    NAME "r73_zones_superposees_2"
    GROUP "r73_zones_superposees"
    TYPE POLYGON
    METADATA
        "ows_title" "r73_zones_superposees"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r73_zones_superposees using unique idobj using srid=${srid}"
    STATUS ON
    CLASSITEM "teneur"
    OPACITY 60
    TEMPLATE "ttt"
    CLASS
        NAME "Secteur de danger élevé"
        EXPRESSION "Secteur de danger élevé"
        STYLE
            WIDTH 1
            COLOR 255 0 0
        END
    END
    CLASS
        NAME "Secteur de danger moyen"
        EXPRESSION "Secteur de danger moyen"
        STYLE
            WIDTH 1
            COLOR 0 169 230
        END
    END
    CLASS
        NAME "Secteur de danger faible"
        EXPRESSION "Secteur de danger faible"
        STYLE
            WIDTH 1
            COLOR 230 230 0
        END
    END
    CLASS
        NAME "Secteur de danger résiduel"
        EXPRESSION "Secteur de danger résiduel"
        STYLE
            COLOR 230 230 0
            SYMBOL "hatchsymbol"
            SIZE 16
            WIDTH 10
            ANGLE 45
        END
        STYLE
            OUTLINECOLOR 230 230 0
            WIDTH 1
        END
    END
    CLASS
        NAME "Secteur d'indication de dangers"
        EXPRESSION "Secteur d'indication de dangers"
        STYLE
            COLOR 255 190 232
        END
    END
END

LAYER
    NAME "r73_zones_superposees_1"
    GROUP "r73_zones_superposees"
    TYPE POLYGON
    METADATA
        "ows_title" "r73_zones_superposees"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r73_zones_superposees using unique idobj using srid=${srid}"
    STATUS ON
    CLASSITEM "teneur"
    OPACITY 60
    TEMPLATE "ttt"
    CLASS
        NAME "Danger d'effondrement"
        EXPRESSION "Danger d'effondrement"
        STYLE
            COLOR 255 107 235
            SYMBOL "hatchsymbol"
            SIZE 8
            WIDTH 2
            ANGLE -45
        END
        STYLE
            OUTLINECOLOR 255 107 235
            WIDTH 1
        END
    END
END

LAYER
    NAME "r73_affectations_primaires"
    TYPE POLYGON
    METADATA
        "ows_title" "r73_affectations_primaires"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r73_affectations_primaires using unique idobj using srid=${srid}"
    STATUS ON
    CLASSITEM "trie"
    OPACITY 50
    TEMPLATE "ttt"
    LABELITEM 'abreviation'
    LABELMAXSCALE 12000
    CLASS
        NAME "Zone centre"
        EXPRESSION "Zone centre"
        STYLE
            COLOR 255 214 168
            OUTLINECOLOR 255 214 168
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 11
            ANTIALIAS TRUE
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
            MINFEATURESIZE 70
        END
    END
    CLASS
        NAME "Zone mixte"
        EXPRESSION "Zone mixte"
        STYLE
            COLOR 255 127 0
            OUTLINECOLOR 255 127 0
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 11
            ANTIALIAS TRUE
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
            MINFEATURESIZE 70
        END
    END
    CLASS
        NAME "Zone d'habitation"
        EXPRESSION "Zone d'habitation"
        STYLE
            COLOR 255 255 0
            OUTLINECOLOR 255 255 0
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 11
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
            MINFEATURESIZE 70
        END
    END
    CLASS
        NAME "Zone d'activités"
        EXPRESSION "Zone d'activités"
        STYLE
            COLOR 214 0 255
            OUTLINECOLOR 214 0 255
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 11
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
            MINFEATURESIZE 70
        END
    END
    CLASS
        NAME "Zone d'utilité publique"
        EXPRESSION "Zone d'utilité publique"
        STYLE
            COLOR 192 192 192
            OUTLINECOLOR 192 192 192
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 11
            ANTIALIAS TRUE
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
            MINFEATURESIZE 70
        END
    END
    CLASS
        NAME "Zone de sport et de loisirs"
        EXPRESSION "Zone de sport et de loisirs"
        STYLE
            COLOR 255 168 235
            OUTLINECOLOR 255 168 235
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 11
            ANTIALIAS TRUE
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
            MINFEATURESIZE 70
        END
    END
    CLASS
        NAME "Zone de fermes"
        EXPRESSION "Zone de fermes"
        STYLE
            COLOR 255 127 0
            OUTLINECOLOR 255 127 0
            SYMBOL "hatchsymbol"
            SIZE 10
            WIDTH 5
            ANGLE 45
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 11
            ANTIALIAS TRUE
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
            MINFEATURESIZE 70
        END
    END
    CLASS
        NAME "Zone de maisons de vacances"
        EXPRESSION "Zone de maisons de vacances"
        STYLE
            COLOR 255 255 0
            OUTLINECOLOR 255 255 0
            SYMBOL "hatchsymbol"
            SIZE 10
            WIDTH 5
            ANGLE 45
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 11
            ANTIALIAS TRUE
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
            MINFEATURESIZE 70
        END
    END
    CLASS
        NAME "Zone de camping"
        EXPRESSION "Zone de camping"
        STYLE
            COLOR 255 168 235
            OUTLINECOLOR 255 168 235
            SYMBOL "hatchsymbol"
            SIZE 10
            WIDTH 5
            ANGLE 45
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 11
            ANTIALIAS TRUE
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
            MINFEATURESIZE 70
        END
    END
    CLASS
        NAME "Zone verte"
        EXPRESSION "Zone verte"
        STYLE
            COLOR 0 255 0
            OUTLINECOLOR 0 255 0
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 11
            ANTIALIAS TRUE
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
            MINFEATURESIZE 70
        END
    END
    CLASS
        NAME "Zone d'extraction de matériaux"
        EXPRESSION "Zone d'extraction de matériaux"
        STYLE
            COLOR 214 0 255
            OUTLINECOLOR 214 0 255
            SYMBOL "hatchsymbol"
            SIZE 10
            WIDTH 5
            ANGLE 45
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 11
            ANTIALIAS TRUE
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
            MINFEATURESIZE 70
        END
    END
    CLASS
        NAME "Zone de décharge"
        EXPRESSION "Zone de décharge"
        STYLE
            COLOR 192 192 192
            OUTLINECOLOR 192 192 192
            SYMBOL "hatchsymbol"
            SIZE 10
            WIDTH 5
            ANGLE 45
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 11
            ANTIALIAS TRUE
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
            MINFEATURESIZE 70
        END
    END
    CLASS
        NAME "Zone agricole"
        EXPRESSION "Zone agricole"
        STYLE
            WIDTH 5
            OUTLINECOLOR 0 0 0
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 11
            ANTIALIAS TRUE
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
            MINFEATURESIZE 70
        END
    END
    CLASS
        NAME "Zone de transport"
        EXPRESSION "Zone de transport"
        STYLE
            COLOR 130 130 130
            OUTLINECOLOR 130 130 130
        END
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 11
            ANTIALIAS TRUE
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
            MINFEATURESIZE 70
        END
    END
    CLASS
        NAME "En attente d'une décision de justice"
        EXPRESSION "Recours"
        STYLE
            COLOR 75 75 75
        END
        LABEL
            TEXT "Ce secteur est\actuellement en\attente d'une\décision de justice"
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 8
            ANTIALIAS TRUE
            COLOR 255 0 0
            OUTLINECOLOR 255 255 255
            wrap "\n"
        END
    END
END

LAYER
    NAME "r87_astra_projektierungszonen_nationalstrassen"
    STATUS ON
    METADATA
        "ows_title" "r87_astra_projektierungszonen_nationalstrassen"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r87_astra_projektierungszonen_nationalstrassen using unique idobj using srid=${srid}"
    TYPE POLYGON
    TEMPLATE "ttt"
    OPACITY 60
    CLASS
        NAME "Zones réservées des routes nationales"
        STYLE
            COLOR 0 220 220
            OUTLINECOLOR 0 180 180
        END
    END
END

LAYER
    NAME "r96_bav_projektierungszonen_eisenbahnanlagen"
    STATUS ON
    METADATA
        "ows_title" "r96_bav_projektierungszonen_eisenbahnanlage"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r96_bav_projektierungszonen_eisenbahnanlagen using unique idobj using srid=${srid}"
    TYPE POLYGON
    TEMPLATE "ttt"
    OPACITY 60
    CLASS
#        NAME "Zones réservées des inst. ferroviaires"
        STYLE
            COLOR 220 220 0
            OUTLINECOLOR 180 180 0
        END
    END
END

LAYER
    NAME "r97_bav_baulinien_eisenbahnanlagen"
    STATUS ON
    METADATA
        "ows_title" "r97_bav_baulinien_eisenbahnanlage"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r97_bav_baulinien_eisenbahnanlagen using unique idobj using srid=${srid}"
    TYPE LINE
    TEMPLATE "ttt"
    OPACITY 60
    CLASS
#        NAME "Alignements des inst. ferroviairess"
        STYLE
            COLOR 220 220 0
            WIDTH 2
        END
    END
END

LAYER
    NAME "r103_bazl_projektierungszonen_flughafenanlagen"
    STATUS ON
    METADATA
        "ows_title" "r103_bazl_projektierungszonen_flughafenanlagen"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r103_bazl_projektierungszonen_flughafenanlagen using unique idobj using srid=${srid}"
    TYPE POLYGON
    TEMPLATE "ttt"
    CLASS
#        NAME "Zones réservées des inst. aéroportuaires"
#        STYLE
#            COLOR 255 170 0
#            OPACITY 70
#        END
#        STYLE
#            OUTLINECOLOR 255 170 0
#        END
    END
END

LAYER
    NAME "r104_bazl_baulinien_flughafenanlagen"
    STATUS ON
    METADATA
        "ows_title" "r104_bazl_baulinien_flughafenanlagen"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r104_bazl_baulinien_flughafenanlagen using unique idobj using srid=${srid}"
    TYPE LINE
    TEMPLATE "ttt"
    OPACITY 60
    CLASS
#        NAME "Alignements des install. aéroportuaire"
#        STYLE
#            COLOR 0 0 180
#            WIDTH 2
#        END
    END
END

LAYER
    NAME "r108_bazl_sicherheitszonenplan"
    STATUS ON
    METADATA
        "ows_title" "r108_bazl_sicherheitszonenplan"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r108_bazl_sicherheitszonenplan using unique idobj using srid=${srid}"
    TYPE POLYGON
    TEMPLATE "ttt"
    CLASS
        NAME "Plan de la zone de sécurité"
        STYLE
            COLOR 192 0 192
            OPACITY 45
        END
        STYLE
            OUTLINECOLOR 192 0 192
        END
    END
END

LAYER
    STATUS ON
    NAME "r116_sites_pollues"
    METADATA
        "ows_title" "r116_sites_pollues"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r116_sites_pollues using unique idobj using srid=${srid}"
    TYPE POLYGON
    CLASSITEM "codegenre"
    TEMPLATE "ttt"
    OPACITY 60
    CLASS
        NAME "Pollué, pas d'atteinte nuisible ou incommodante à attendre"
        EXPRESSION "r116_Pollue_pas_atteinte_a_attendre"
        COLOR 255 255 0
        OUTLINECOLOR 0 0 0
    END
    CLASS
        NAME "Pollué, investigation nécessaire"
        EXPRESSION "r116_Pollue_investigation_necessaire"
        COLOR 0 0 255
        OUTLINECOLOR 0 0 0
    END
    CLASS
        NAME "Pollué, ne nécessite ni surveillance ni assainissement"
        EXPRESSION "r116_Pollue_ni_surveillance_ni_assainissement"
        COLOR 255 204 0
        OUTLINECOLOR 0 0 0
    END
    CLASS
        NAME "Pollué, nécessite une surveillance"
        EXPRESSION "r116_Pollue_necessite_surveillance"
        COLOR 255 102 5
        OUTLINECOLOR 0 0 0
    END
    CLASS
        NAME "Pollué, nécessite un assainissement"
        EXPRESSION "r116_Pollue_necessite_assainissement"
        COLOR 255 0 0
        OUTLINECOLOR 0 0 0
    END
    CLASS
        NAME "Pollué, nécessitée d'une investigation non encore évaluée"
        EXPRESSION "r116_Pollue_investigation_non_evaluee"
        COLOR 95 95 95
        OUTLINECOLOR 0 0 0
    END
END

LAYER
    NAME "r118_bazl_belastete_standorte_zivilflugplaetze_pts"
    GROUP "r118_bazl_belastete_standorte_zivilflugplaetze"
    TYPE POINT
    METADATA
        "ows_title" "r118_bazl_belastete_standorte_zivilflugplaetze_pts"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r118_bazl_belastete_standorte_zivilflugplaetze_points using unique idobj using srid=${srid}"
    STATUS ON
    CLASSITEM "codegenre"
    OPACITY 60
    TEMPLATE "ttt"
    CLASS
##########        NAME "Bâtiment inscrit au RBC"
##########        EXPRESSION "r118_Pollue_pas_atteinte_a_attendre"
##########        STYLE
##########            SYMBOL "carre"
##########            SIZE 16
##########            WIDTH 3
##########            COLOR 255 0 0
##########        END
##########    END
    CLASS
        NAME "Pollué, nécessitée d'une investigation non encore évaluée"
        EXPRESSION "r118_Pollue_pas_atteinte_a_attendre"
        STYLE
            SYMBOL "circle"
            COLOR 95 95 95
            OUTLINECOLOR 0 0 0
            SIZE 7
        END
    END
    CLASS
        NAME "Pollué, nécessitée d'une investigation non encore évaluée"
        EXPRESSION "r118_Pollue_pas_atteinte_a_attendre"
        STYLE
            SYMBOL "circle"
             COLOR 95 95 95
            OUTLINECOLOR 0 0 0
            SIZE 7
        END
    END
    CLASS
        NAME "Pollué, investigation nécessaire"
        EXPRESSION "r118_Pollue_investigation_necessaire"
        STYLE
            SYMBOL "circle"
            COLOR 0 0 255
            OUTLINECOLOR 0 0 0
            SIZE 7
        END
    END
    CLASS
        NAME "Pollué, ne nécessite ni surveillance ni assainissement"
        EXPRESSION "r118_Pollue_ni_surveillance_ni_assainissement"
        STYLE
            SYMBOL "circle"
            COLOR 255 204 0
            OUTLINECOLOR 0 0 0
            SIZE 7
        END
    END
    CLASS
        NAME "Pollué, nécessite une surveillance"
        EXPRESSION "r118_Pollue_necessite_surveillance"
        STYLE
            SYMBOL "circle"
            COLOR 255 102 5
            OUTLINECOLOR 0 0 0
            SIZE 7
        END
    END
    CLASS
        NAME "Pollué, nécessite un assainissement"
        EXPRESSION "r118_Pollue_necessite_assainissement"
        STYLE
            SYMBOL "circle"
            COLOR 255 0 0
            OUTLINECOLOR 0 0 0
            SIZE 7
        END
    END
    CLASS
        NAME "Pollué, pas d'atteinte nuisible ou incommodante à attendre"
        EXPRESSION "r118_Pollue_investigation_non_evaluee"
        STYLE
            SYMBOL "circle"
            COLOR 255 255 0
            OUTLINECOLOR 0 0 0
            SIZE 7
        END
    END
END

LAYER
    STATUS ON
    NAME "r118_bazl_belastete_standorte_zivilflugplaetze_poly"
    GROUP "r118_bazl_belastete_standorte_zivilflugplaetze"
    METADATA
        "ows_title" "r118_bazl_belastete_standorte_zivilflugplaetze_poly"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r118_bazl_belastete_standorte_zivilflugplaetze using unique idobj using srid=${srid}"
    TYPE POLYGON
    TEMPLATE "ttt"
    CLASSITEM "codegenre"
    OPACITY 60
    MAXSCALEDENOM 100000
    CLASS
        NAME "Pollué, pas d'atteinte nuisible ou incommodante à attendre"
        EXPRESSION "r118_Pollue_pas_atteinte_a_attendre"
        COLOR 255 255 0
        OUTLINECOLOR 0 0 0
    END
    CLASS
        NAME "Pollué, investigation nécessaire"
        EXPRESSION "r118_Pollue_investigation_necessaire"
        COLOR 0 0 255
        OUTLINECOLOR 0 0 0
    END
    CLASS
        NAME "Pollué, ne nécessite ni surveillance ni assainissement"
        EXPRESSION "r118_Pollue_ni_surveillance_ni_assainissement"
        COLOR 255 204 0
        OUTLINECOLOR 0 0 0
    END
    CLASS
        NAME "Pollué, nécessite une surveillance"
        EXPRESSION "r118_Pollue_necessite_surveillance"
        COLOR 255 102 5
        OUTLINECOLOR 0 0 0
    END
    CLASS
        NAME "Pollué, nécessite un assainissement"
        EXPRESSION "r118_Pollue_necessite_assainissement"
        COLOR 255 0 0
        OUTLINECOLOR 0 0 0
    END
    CLASS
        NAME "Pollué, nécessitée d'une investigation non encore évaluée"
        EXPRESSION "r118_Pollue_investigation_non_evaluee"
        COLOR 95 95 95
        OUTLINECOLOR 0 0 0
    END
END

LAYER
    STATUS ON
    NAME "r119_bav_belastete_standorte_oev"
    METADATA
        "ows_title" "r119_bav_belastete_standorte_oev"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r119_bav_belastete_standorte_oev using unique idobj using srid=${srid}"
    TYPE POLYGON
    TEMPLATE "ttt"
    CLASSITEM "teneur"
    OPACITY 60
    CLASS
        NAME "Pollué, pas d'atteinte nuisible ou incommodante à attendre"
        EXPRESSION "Pollué, pas d'atteinte nuisible ou incommodante à attendre"
        COLOR 255 255 0
        OUTLINECOLOR 0 0 0
    END
    CLASS
        NAME "Pollué, investigation nécessaire"
        EXPRESSION "Pollué, investigation nécessaire"
        COLOR 0 0 255
        OUTLINECOLOR 0 0 0
    END
    CLASS
        NAME "Pollué, ne nécessite ni surveillance ni assainissement"
        EXPRESSION "Pollué, ne nécessite ni surveillance ni assainissement"
        COLOR 255 204 0
        OUTLINECOLOR 0 0 0
    END
    CLASS
        NAME "Pollué, nécessite une surveillance"
        EXPRESSION "Pollué, nécessite une surveillance"
        COLOR 255 102 5
        OUTLINECOLOR 0 0 0
    END
    CLASS
        NAME "Pollué, nécessite un assainissement"
        EXPRESSION "Pollué, nécessite un assainissement"
        COLOR 255 0 0
        OUTLINECOLOR 0 0 0
    END
    CLASS
        NAME "Pollué, nécessitée d'une investigation non encore évaluée"
        EXPRESSION "Pollué, nécessitée d'une investigation non encore évaluée"
        COLOR 95 95 95
        OUTLINECOLOR 0 0 0
    END
END

LAYER
    NAME "r131_zone_prot_eau"
    STATUS ON
    METADATA
        "ows_title" "r131_zone_prot_eau"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r131_zone_prot_eau using unique idobj using srid=${srid}"
    TYPE POLYGON
    TEMPLATE "ttt"
    OPACITY 60
    CLASSITEM "teneur"
    CLASS
        NAME "Zones de captage S1"
        EXPRESSION "S1"
        STYLE
            COLOR 0 59 179
            OUTLINECOLOR 0 0 128
        END
    END
    CLASS
        NAME "Zones rapprochées S2"
        EXPRESSION "S2"
        STYLE
            COLOR 51 136 255
            OUTLINECOLOR 0 0 128
        END
    END
    CLASS
        NAME "Zones éloignées S3"
        EXPRESSION "S3"
        STYLE
            COLOR 179 210 255
            OUTLINECOLOR 0 0 128
        END
    END
END

LAYER
    NAME "r132_perimetre_prot_eau"
    STATUS ON
    METADATA
        "ows_title" "r132_perimetre_prot_eau"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r132_perimetre_prot_eau using unique idobj using srid=${srid}"
    TYPE POLYGON
    TEMPLATE "ttt"
    OPACITY 60
    CLASSITEM "teneur"
    CLASS
        NAME "Périmètres de protection des eaux souterraines"
        EXPRESSION "Périmètre"
        STYLE
            WIDTH 1
            OUTLINECOLOR 0 74 89
            COLOR 157 228 242
        END
        STYLE
            COLOR 0 74 89
            SYMBOL "hatchsymbol"
            SIZE 10
            WIDTH 3
            ANGLE 90
        END
    END
END

LAYER
    NAME "r145_sens_bruit"
    TYPE POLYGON
    METADATA
        "ows_title" "r145_sens_bruit"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r145_sens_bruit using unique idobj using srid=${srid}"
    STATUS ON
    CLASSITEM "teneur"
    OPACITY 50
    TEMPLATE "ttt"
    CLASS
        NAME "Degré de sensibilité au bruit I"
        EXPRESSION "Degré de sensibilité au bruit I"
        STYLE
            COLOR 255 242 0
        END
    END
    CLASS
        NAME "Degré de sensibilité au bruit II"
        EXPRESSION "Degré de sensibilité au bruit II"
        STYLE
            COLOR 255 166 0
        END
    END
    CLASS
        NAME "Degré de sensibilité au bruit III"
        EXPRESSION "Degré de sensibilité au bruit III"
        STYLE
            COLOR 255 77 0
        END
    END
    CLASS
        NAME "Degré de sensibilité au bruit IV"
        EXPRESSION "Degré de sensibilité au bruit IV"
        STYLE
            COLOR 230 0 0
        END
    END
    CLASS
        NAME "DS à déterminé de cas en cas"
        EXPRESSION "DS à déterminé de cas en cas"
        STYLE
            WIDTH 3
            OUTLINECOLOR 0 0 0
        END
    END
END

LAYER
    NAME "r157_lim_foret"
    TYPE LINE
    METADATA
        "ows_title" "r157_lim_foret"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r157_lim_foret using unique idobj using srid=${srid}"
    STATUS ON
    TEMPLATE "ttt"
    CLASSITEM "teneur"
    CLASS
        NAME "Limite forestière statique"
        STYLE
            WIDTH 2
            OUTLINECOLOR 230 0 0
        END
    END
    TOLERANCE 5
    TOLERANCEUNITS pixels
END

LAYER
    NAME "r159_dist_foret"
    TYPE LINE
    METADATA
        "ows_title" "r157_lim_foret"
        "wms_srs" "epsg:${srid}"
        "wms_title" "${instanceid} WMS Server"
        "wms_onlineresource" "http://${host}/${instanceid}/wmscrdppf"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from crdppf.r159_dist_foret using unique idobj using srid=${srid}"
    STATUS ON
    TEMPLATE "ttt"
    CLASS
#        NAME "Distance par rapport à la forêt"
        STYLE
            PATTERN 8 4 1 4 END
            WIDTH 2
            COLOR 0 255 0
        END
    END
    TOLERANCE 5
    TOLERANCEUNITS pixels
END

#####################
# RESTRICTIONS CRDPPF - fin
#####################
LAYER
    NAME "la3_limites_communales"
    TYPE POLYGON
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
    DATA "geom from general.la3_limites_communales using unique numcom using srid=${srid}"
    STATUS ON
    CLASS
        NAME "Limites communales"
        STYLE
            OUTLINECOLOR 90 90 90
        END
    END
    METADATA
        "ows_title" "la3_limites_communales"
        "wms_srs" "epsg:${srid}"
    END
    PROJECTION
        "init=epsg:${srid}"   ##required
    END
END

################################################
################################################
################################################
#### Mensuration
################################################
################################################
################################################

#########################################
#### Objets divers                   ####
#########################################
LAYER
    NAME "cadastre_objets_divers_lignes"
    GROUP "plan_cadastral"
    TYPE LINE
    STATUS ON
    METADATA
        "ows_title" "cadastre_objets_divers_lignes"
        "wms_srs" "epsg:${srid}"
        #"gml_include_items" "all"
        "gml_types" "auto"
        #"wfs_enable_request" "*"
        "gml_geometries" "geom"
        "gml_geom_type" "line"
    END
    PROJECTION
        "init=epsg:${srid}"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
#    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db_donnees} host=${dbhost} port=${dbport}"
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
#    DATA "geom from cadastre.cad_objets_divers_lignes using unique objectid using srid=${srid}"
    DATA "geom from crdppf.cad_objets_divers_lignes using unique objectid using srid=${srid}"
    CLASSITEM 'genre'
    CLASS
        NAME ""
        EXPRESSION /mur|escalier_important|pont_passerelle|quai|fontaine|reservoir|silo_tour_gazometre|monument|mat_antenne|ouvrage_de_protection_des_rives|seuil|socle_massif|ru|statue_crucifix|point_de_reference|cheminee|debarcadere|source|ruine_objet_archeologique/
        STYLE
            WIDTH 1
            COLOR 0 0 0
        END
    END
    CLASS
        NAME ""
        EXPRESSION /tunnel_passage_inferieur_galerie|pilier|eau_canalisee_souterraine|batiment_souterrain|autre/
        STYLE
            WIDTH 1
            COLOR 0 0 0
            PATTERN 3 2 3 2 END
        END
    END
    CLASS
        NAME ""
        EXPRESSION /couvert_independant|autre_corps_de_batiment/
        STYLE
            WIDTH 1
            COLOR 0 0 0
            PATTERN 4 3 4 3 END
        END
    END
    CLASS
        NAME ""
        EXPRESSION /axe|sentier|cordon_boise/
        STYLE
            WIDTH 1
            COLOR 0 0 0
            PATTERN 5 3 5 3 END
        END
    END
    CLASS
        NAME ""
        EXPRESSION "ligne_aerienne_a_haute_tension"
        STYLE
            WIDTH 1
            COLOR 0 0 0
            PATTERN 15 3 5 3 5 3 END
        END
    END
    CLASS
        NAME ""
        EXPRESSION "voie_ferre"
        STYLE
            WIDTH 1
            COLOR 0 0 0
            PATTERN 15 3 5 3 END
        END
    END
#   MINSCALEDENOM 50
    MAXSCALEDENOM 2100
END

LAYER
    NAME "cadastre_objets_divers_surface"
    GROUP "plan_cadastral"
    TYPE POLYGON
    METADATA
        "ows_title" "cadastre_objets_divers_surface"
        "wms_srs" "epsg:${srid}"
        #"gml_include_items" "all"
        "gml_types" "auto"
        #"wfs_enable_request" "*"
        "gml_geometries" "geom"
        "gml_geom_type" "polygon"
    END
    PROJECTION
        "init=epsg:${srid}"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
#    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db_donnees} host=${dbhost} port=${dbport}"
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
#    DATA "geom from cadastre.cad_objets_divers_surface using unique objectid using srid=${srid}"
    DATA "geom from crdppf.cad_objets_divers_surface using unique objectid using srid=${srid}"
    CLASSITEM 'genre'
    CLASS
        NAME ""
        EXPRESSION /mur|escalier_important|pont_passerelle|quai|fontaine|reservoir|silo_tour_gazometre|monument|mat_antenne|ouvrage_de_protection_des_rives|seuil|socle_massif|ru|statue_crucifix|point_de_reference|cheminee|debarcadere|source|ruine_objet_archeologique/
        STYLE
            WIDTH 1
            OUTLINECOLOR 0 0 0
        END
    END
    CLASS
        NAME ""
        EXPRESSION /tunnel_passage_inferieur_galerie|pilier|eau_canalisee_souterraine|batiment_souterrain|autre/
        STYLE
            WIDTH 1
            OUTLINECOLOR 0 0 0
            PATTERN 3 2 3 2 END
        END
    END
    CLASS
        NAME ""
        EXPRESSION /couvert_independant|autre_corps_de_batiment/
        STYLE
            WIDTH 1
            OUTLINECOLOR 0 0 0
            PATTERN 4 3 4 3 END
        END
    END
    CLASS
        NAME ""
        EXPRESSION /axe|sentier|cordon_boise/
        STYLE
            WIDTH 1
            OUTLINECOLOR 0 0 0
            PATTERN 5 3 5 3 END
        END
    END
    CLASS
        NAME ""
        EXPRESSION "ligne_aerienne_a_haute_tension"
        STYLE
            WIDTH 1
            OUTLINECOLOR 0 0 0
            PATTERN 15 3 5 3 5 3 END
        END
    END
#   MINSCALEDENOM 50
    MAXSCALEDENOM 2100
END

#########################################
#### Couverture du sol noir-blanc    ####
#########################################
LAYER
    NAME "cadastre_couverture_du_sol_nb"
    GROUP "plan_cadastral"
    TYPE POLYGON
    STATUS ON
    METADATA
        "ows_title" "cadastre_couverture_du_sol_nb"
        "wms_srs" "epsg:${srid}"
        "gml_include_items" "genre_type"
        "gml_types" "auto"
        "wfs_enable_request" "*"
        "gml_geometries" "geom"
        "gml_geom_type" "polygon"
    END
    PROJECTION
        "init=epsg:${srid}"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
#    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db_donnees} host=${dbhost} port=${dbport}"
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
#    DATA "geom from cadastre.cad_couverture_du_sol using unique objectid using srid=${srid}"
    DATA "geom from crdppf.cad_couverture_du_sol using unique objectid using srid=${srid}"
    TEMPLATE "ttt"
    CLASSITEM 'genre'
    CLASS
        #NAME ""
        EXPRESSION /batiment|trottoir|ilot|bassin|eau_stagnante|cours_eau/
        STYLE
            WIDTH 1
            OUTLINECOLOR 0 0 0
        END
    END
    CLASS
        #NAME ""
        EXPRESSION /./
        STYLE
            WIDTH 1
            OUTLINECOLOR 0 0 0
            PATTERN 5 6 5 6 END
        END
    END
#   MINSCALEDENOM 50
    MAXSCALEDENOM 5990
END

#########################################
#### Bâtiments                       ####
#########################################
LAYER
    NAME "cadastre_batiment_cs"
    GROUP "plan_cadastral"
    TYPE POLYGON
    STATUS ON
    METADATA
        "ows_title" "Batiment"
        "wms_srs" "epsg:${srid}"
        "gml_include_items" "genre_type,regbl_egid"
        "gml_types" "auto"
        "wfs_enable_request" "*"
        "gml_geometries" "geom"
        "gml_geom_type" "polygon"
        "gml_featureid" "regbl_egid"
    END
    PROJECTION
        "init=epsg:${srid}"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
#    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db_donnees} host=${dbhost} port=${dbport}"
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
#    DATA "geom from cadastre.cad_couverture_du_sol_batiments using unique objectid using srid=${srid}"
    DATA "geom from crdppf.cad_couverture_du_sol_batiments using unique objectid using srid=${srid}"
    TEMPLATE "ttt"
    CLASS
        NAME "Bâtiment"
        STYLE
#            COLOR 200 200 200
            OUTLINECOLOR 130 130 130
        END
    END
    MINSCALEDENOM 50
    MAXSCALEDENOM 20500
END

LAYER
    NAME "cadastre_numero_batiment"
    GROUP "plan_cadastral"
#    TYPE ANNOTATION
    TYPE POINT
    STATUS ON
    METADATA
        "ows_title" "Numero de batiment"
        "wms_srs" "epsg:${srid}"
        #"gml_include_items" "all"
        "gml_types" "auto"
        #"wfs_enable_request" "*"
        "gml_geometries" "geom"
        "gml_geom_type" "point"
    END
    PROJECTION
        "init=epsg:${srid}"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
#    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db_donnees} host=${dbhost} port=${dbport}"
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
#    DATA "geom from cadastre.cad_couverture_du_sol_numero_batiment using unique objectid using srid=${srid}"
    DATA "geom from crdppf.cad_couverture_du_sol_numero_batiment using unique objectid using srid=${srid}"
    CLASSITEM 'numero'
    LABELITEM 'numero'
    LABELMINSCALE 0
    LABELMAXSCALE 3500
    CLASS
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 6
            ANGLE AUTO
            ANTIALIAS TRUE
            COLOR 30 30 30
            OUTLINECOLOR 255 255 255
        END
    END
    MINSCALEDENOM 50
    MAXSCALEDENOM 3500
END

#########################################
#### Bien fond et DDP                ####
#########################################
LAYER
    NAME "cadastre_bienfond"
    GROUP "plan_cadastral"
    TYPE POLYGON
    STATUS ON
    METADATA
        "ows_title" "cadastre_bienfond"
        "wms_srs" "epsg:${srid}"
        "gml_include_items" "all"
        "gml_types" "auto"
        "wfs_enable_request" "*"
        "gml_geometries" "geom"
        "gml_geom_type" "polygon"
        "gml_featureid" "nolocalite_noparcelle"
    END
    PROJECTION
        "init=epsg:${srid}"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
#    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db_donnees} host=${dbhost} port=${dbport}"
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
#    DATA "geom from cadastre.cad_bien_fonds using unique objectid using srid=${srid}"
    DATA "geom from crdppf.cad_bien_fonds using unique objectid using srid=${srid}"
    TRANSPARENCY 80
    TEMPLATE "ttt"
    CLASSITEM "genre"
    CLASS
        NAME "Biens-fonds"
        EXPRESSION "bien_fonds"
        STYLE
            WIDTH 2
            OUTLINECOLOR 0 0 0
        END
    END
    MINSCALEDENOM 50
    MAXSCALEDENOM 55500
    #en cas de changement d'échelle, il faut également
    #changer l'échelle dans NAME "parcelles", afin d'avoir le pourtour en rouge qui s'affiche
    #RW, 18.03.2015
END

LAYER
    NAME "cadastre_ddp"
    GROUP "plan_cadastral"
    TYPE POLYGON
    STATUS ON
    METADATA
        "ows_title" "cadastre_ddp"
        "wms_srs" "epsg:${srid}"
        "gml_include_items" "commune,localite,numero,url_rf,date_cadastre,geometre_conservateur,,egris_egrid"
        "gml_types" "auto"
        "wfs_enable_request" "*"
        "gml_geometries" "geom"
        "gml_geom_type" "polygon"
    END
    PROJECTION
        "init=epsg:${srid}"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
#    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db_donnees} host=${dbhost} port=${dbport}"
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
#    DATA "geom from cadastre.cad_ddp using unique objectid using srid=${srid}"
    DATA "geom from crdppf.cad_bien_fonds using unique objectid using srid=${srid}"
    TEMPLATE "ttt"
#   LABELITEM 'numero'
#   LABELMAXSCALE 5500
    CLASSITEM "genre"
    CLASS
        NAME "DDP"
        EXPRESSION "superficie"
        STYLE
            WIDTH 4
            OUTLINECOLOR 255 255 255
        END
        STYLE
            WIDTH 2
            OUTLINECOLOR 0 0 0
            PATTERN 16 8 16 8 END
        END
    END
    MINSCALEDENOM 50
    MAXSCALEDENOM 55500
END

#########################################
#### Numéro des parcelles            ####
#########################################
LAYER
    NAME "PosImmeuble_Ligne_auxiliaire"
    GROUP "plan_cadastral"
    TYPE LINE
    STATUS ON
    METADATA
        "ows_title" "PosImmeuble_Ligne_auxiliaire"
        "wms_srs" "epsg:${srid}"
        #"gml_include_items" "all"
        "gml_types" "auto"
        #"wfs_enable_request" "*"
        "gml_geometries" "geom"
        "gml_geom_type" "line"
    END
    PROJECTION
        "init=epsg:${srid}"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
#    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db_donnees} host=${dbhost} port=${dbport}"
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
#    DATA "geom from cadastre.cad_pos_immeuble_ligne_auxiliaire using unique objectid using srid=${srid}"
    DATA "geom from crdppf.cad_pos_immeuble_ligne_auxiliaire using unique objectid using srid=${srid}"
    CLASS
        STYLE
            WIDTH 1
            OUTLINECOLOR 0 0 0
        END
    END
#   MINSCALEDENOM 50
    MAXSCALEDENOM 2600
END

LAYER
    NAME "cadastre_pos_immeuble_1"
    GROUP "plan_cadastral"
#    TYPE ANNOTATION
    TYPE POINT
    STATUS ON
    METADATA
        "ows_title" "cadastre_pos_immeuble"
        "wms_srs" "epsg:${srid}"
        #"gml_include_items" "commune,localite,numero,superficie,surface_rev_dur,surface_verte,surface_eau,surface_boise,surface_sans_veg,url_n_comp,url_rf,date_cadastre,geometre_conservateur"
        "gml_types" "auto"
        #"wfs_enable_request" "*"
        "gml_geometries" "geom"
        "gml_geom_type" "annotation"
    END
    PROJECTION
        "init=epsg:${srid}"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
#    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db_donnees} host=${dbhost} port=${dbport}"
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
#    DATA "geom from cadastre.cad_pos_immeuble using unique objectid using srid=${srid}"
    DATA "geom from crdppf.cad_pos_immeuble using unique objectid using srid=${srid}"
    LABELITEM 'numero'
    LABELMINSCALE 0
    LABELMAXSCALE 3650
    CLASS
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 8
            ANGLE AUTO
            ANTIALIAS TRUE
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
        END
    END
#   MINSCALEDENOM 50
    MAXSCALEDENOM 3650
END

LAYER
    NAME "cadastre_pos_immeuble_2"
    GROUP "plan_cadastral"
#    TYPE ANNOTATION
    TYPE POINT
    STATUS ON
    METADATA
        "ows_title" "cadastre_pos_immeuble"
        "wms_srs" "epsg:${srid}"
        #"gml_include_items" "commune,localite,numero,superficie,surface_rev_dur,surface_verte,surface_eau,surface_boise,surface_sans_veg,url_n_comp,url_rf,date_cadastre,geometre_conservateur"
        "gml_types" "auto"
        #"wfs_enable_request" "*"
        "gml_geometries" "geom"
        "gml_geom_type" "annotation"
    END
    PROJECTION
        "init=epsg:${srid}"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
#    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db_donnees} host=${dbhost} port=${dbport}"
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
#    DATA "geom from cadastre.cad_pos_immeuble using unique objectid using srid=${srid}"
    DATA "geom from crdppf.cad_pos_immeuble using unique objectid using srid=${srid}"
    LABELITEM 'numero'
    LABELMINSCALE 3650
    LABELMAXSCALE 20500
    CLASS
        LABEL
            TYPE TRUETYPE
            FONT cadastra_bold
            SIZE 7
            ANGLE AUTO
            ANTIALIAS TRUE
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
        END
    END
    MINSCALEDENOM 3650
    MAXSCALEDENOM 20500
END

#########################################
#### Objets divers ponctuels         ####
#########################################
LAYER
    NAME "cadastre_objets_divers_ponctuels"
    GROUP "plan_cadastral"
    TYPE point
    STATUS ON
    METADATA
        "ows_title" "cadastre_objets_divers_ponctuels"
        "wms_srs" "epsg:${srid}"
        #"gml_include_items" "all"
        "gml_types" "auto"
        #"wfs_enable_request" "*"
        "gml_geometries" "geom"
        "gml_geom_type" "point"
    END
    PROJECTION
        "init=epsg:${srid}"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
#    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db_donnees} host=${dbhost} port=${dbport}"
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
#    DATA "geom from cadastre.cad_objets_divers_ponctuel using unique objectid using srid=${srid}"
    DATA "geom from crdppf.cad_objets_divers_ponctuel using unique objectid using srid=${srid}"
    CLASSITEM 'genre'
    CLASS
        NAME "arbre_isole_important"
        EXPRESSION "arbre_isole_important"
        SYMBOL "OD_Arbre"
        SIZE 18
    END
    CLASS
        NAME "grotte_entree_de_caverne"
        EXPRESSION "grotte_entree_de_caverne"
        SYMBOL "OD_Grotte"
        SIZE 16
    END
    CLASS
        NAME "mat_antenne"
        EXPRESSION "mat_antenne"
        SYMBOL "OD_Mat_antenne"
        SIZE 22
    END
    CLASS
        NAME "monument"
        EXPRESSION "monument"
        SYMBOL "OD_Monument"
        SIZE 22
    END
    CLASS
        NAME "source"
        EXPRESSION "source"
        SYMBOL "OD_Source"
        SIZE 24
    END
    CLASS
        NAME "statue_crucifix"
        EXPRESSION "statue_crucifix"
        SYMBOL "OD_Statue_Crucifix"
        SIZE 22
    END
    MINSCALEDENOM 50
    MAXSCALEDENOM 2100
END

#########################################
#### Points limites                  ####
#########################################
LAYER
    NAME "cadastre_points_limites"
    GROUP "plan_cadastral"
    TYPE POINT
    STATUS ON
    METADATA
        "ows_title" "cadastre_points_limites"
        "wms_srs" "epsg:${srid}"
        "gml_include_items" "signe,x,y"
        "gml_types" "auto"
        "wfs_enable_request" "*"
        "gml_geometries" "geom"
        "gml_geom_type" "point"
    END
    PROJECTION
        "init=epsg:${srid}"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
#    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db_donnees} host=${dbhost} port=${dbport}"
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
#    DATA "geom from cadastre.cad_points_limites using unique objectid using srid=${srid}"
    DATA "geom from crdppf.cad_points_limites using unique objectid using srid=${srid}"
    TEMPLATE "ttt"
    CLASSITEM 'signe'
    CLASS
        NAME "Borne"
        EXPRESSION "borne"
        STYLE
            SYMBOL "cercle_plein"
            SIZE 7
            COLOR 255 255 255
            OUTLINECOLOR 0 0 0
        END
    END
    CLASS
        NAME "Cheville"
        EXPRESSION "cheville"
        STYLE
            SYMBOL "cercle_plein"
            SIZE 5
            COLOR 255 255 255
            OUTLINECOLOR 0 0 0
        END
    END
    CLASS
        NAME "Croix"
        EXPRESSION "croix"
        STYLE
            SYMBOL "pt_limite_croix"
            SIZE 12
        END
    END
    CLASS
        NAME "Pieu, tuyau"
        EXPRESSION "pieux-tuyau"
        STYLE
            SYMBOL "cercle_plein"
            SIZE 5
            COLOR 255 255 255
            OUTLINECOLOR 0 0 0
        END
    END
    CLASS
        NAME "Non matérialisé"
        EXPRESSION "non materialisé"
        STYLE
            SYMBOL "cercle_plein"
            SIZE 7
            COLOR 255 255 255
        END
        STYLE
            SYMBOL "cercle_plein"
            SIZE 4
            COLOR 0 0 0
        END
    END
    MINSCALEDENOM 0
    MAXSCALEDENOM 1750
END

#########################################
#### Nomenclature                    ####
#########################################
LAYER
    NAME "cadastre_nomenclature"
    GROUP "plan_cadastral"
    TYPE POINT
    STATUS ON
    METADATA
        "ows_title" "cadastre_nomenclature_nom_local"
        "wms_srs" "EPSG:${srid}"
        "gml_types" "auto"
        "gml_geometries" "geom"
        "gml_geom_type" "point"
    END
    PROJECTION
        "init=epsg:${srid}"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
#    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db_donnees} host=${dbhost} port=${dbport}"
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
#    DATA "geom from cadastre.cad_nomenclature_noms_posnom using unique objectid using srid=${srid}"
    DATA "geom from crdppf.cad_nomenclature_noms_posnom using unique objectid using srid=${srid}"
    CLASSITEM 'categorie'
    LABELITEM 'nom'
    LABELMAXSCALE 3600
    CLASS
        EXPRESSION "Nom local"
        LABEL
            TYPE TRUETYPE
            FONT cadastra_italic
            SIZE 9
            ANGLE AUTO
            ANTIALIAS TRUE
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
            POSITION cr
        END
    END
    MINSCALEDENOM 50
    MAXSCALEDENOM 3600
END

#########################################
#### Tronçon rue                     ####
#########################################
LAYER
    NAME "cadastre_troncon_rue"
    GROUP "plan_cadastral"
    TYPE LINE
    STATUS ON
    METADATA
        "ows_title" "cadastre_troncon_rue"
        "wms_srs" "epsg:${srid}"
        #"gml_include_items" "all"
        "gml_types" "auto"
        #"wfs_enable_request" "*"
        "gml_geometries" "geom"
        "gml_geom_type" "line"
    END
    PROJECTION
        "init=epsg:${srid}"
    END
    CONNECTIONTYPE POSTGIS
    EXTENT ${extend_mapfile}
#    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db_donnees} host=${dbhost} port=${dbport}"
    CONNECTION "user=${dbuser} password=${dbpassword} dbname=${db} host=${dbhost} port=${dbport}"
    PROCESSING "CLOSE_CONNECTION=DEFER"
#    DATA "geom from cadastre.cad_adr_troncon_rue using unique objectid using srid=${srid}"
    DATA "geom from crdppf.cad_adr_troncon_rue using unique objectid using srid=${srid}"
    LABELITEM 'texte'
    TEMPLATE "ttt"
    MINSCALEDENOM 50
    MAXSCALEDENOM 3600
    CLASS
        LABEL
            TYPE TRUETYPE
            FONT cadastra_italic
            PARTIALS FALSE
            MINDISTANCE 150
            SIZE 7
            ANGLE FOLLOW
            COLOR 0 0 0
            OUTLINECOLOR 255 255 255
        END
    END
END


END

