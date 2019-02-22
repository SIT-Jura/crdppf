INSTANCE_ID = crdppf

export DOCKER_PDF_ARCHIVE_PATH = /var/sig/sitj/PDF

# Host of the application
host = geo.jura.ch

VENV_BIN ?= .build/venv/bin

DEVELOPMENT = TRUE

VARS_FILE = vars_sitj_pdf.yaml

include Makefile
