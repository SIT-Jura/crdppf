INSTANCE_ID = crdppf_rw
DOCKER_PORT = 9020
DOCKER_TAG = ${INSTANCE_ID}

export DOCKER_PDF_ARCHIVE_PATH = /var/sig/sitj/_crdppf_prov

# Host of the application
host = geo-test.jura.ch

VENV_BIN ?= .build/venv/bin

DEVELOPMENT = TRUE

VARS_FILE = vars_sitj_pdf.yaml

include Makefile

# Render engine to use for the pdf extract: crdppf_mfp or pyramid_oereb_mfp
#pdf_renderer = crdppf_mfp
#Adapter le fichier config_pdf.yaml.tmpl directement