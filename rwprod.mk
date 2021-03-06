INSTANCE_ID = crdppf_rw
DOCKER_PORT=9020
DOCKER_TAG = ${INSTANCE_ID}

export DOCKER_PDF_ARCHIVE_PATH = /var/sig/sitj/_crdppf_prov

# Host of the application
host = geo.jura.ch

VENV_BIN ?= .build/venv/bin

DEVELOPMENT = TRUE

VARS_FILE = vars_sitj_pdf.yaml

include Makefile
