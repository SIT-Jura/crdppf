
INSTANCE_ID = crdppf_rw

# Host of the application
host = geo.jura.ch

VENV_BIN ?= .build/venv/bin
CONST_REQUIREMENT_FILE ?= CONST_requirements.txt

DEVELOPMENT = TRUE

VARS_FILE = vars_sitj_pdf_test.yaml
PRINT_OUTPUT ?= /srv/tomcat/tomcat1/webapps

#Variables tomcat
TOMCAT_START_COMMAND = sudo /etc/init.d/tomcat-tomcat1 start 
TOMCAT_STOP_COMMAND = sudo /etc/init.d/tomcat-tomcat1 stop 

include crdppf_core/CONST_Makefile
