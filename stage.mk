INSTANCE_ID = crdppf

export DOCKER_PDF_ARCHIVE_PATH = /var/sig/sitj/_crdppf_prov

# Host of the application
host = geo-test.jura.ch

VENV_BIN ?= .build/venv/bin

DEVELOPMENT = TRUE

VARS_FILE = vars_sitj_pdf.yaml

include Makefile
