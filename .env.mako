DOCKER_BASE=${docker_base}
DOCKER_TAG=${docker_tag}
PORT=${docker_port}
extend_mapfile=${extend_mapfile}
instanceid=${instanceid}
VISIBLE_ENTRY_POINT=${visible_entry_point}
host=${host}
srid=${srid}
dbuser=${dbuser}
dbpassword=${dbpassword}
dbhost=${dbhost}
dbport=${dbport}
db=${db}
db_pyramid_oereb=${db_pyramid_oereb}
DOCKER_PDF_ARCHIVE_PATH=${docker_pdf_archive_path}
CATALINA_OPTS=-Xmx1024m
PGOPTIONS=-c statement_timeout=30000
GUNICORN_PARAMS=--bind=:8080 --access-logfile=- --log-level=info --worker-class=gthread --threads=10 --workers=1 --timeout=60 --max-requests=1000 --max-requests-jitter=100
C2C_LOG_VIEW_ENABLED=TRUE
C2C_SQL_PROFILER_ENABLED=TRUE
C2C_DEBUG_VIEW_ENABLED=TRUE
C2C_REQUESTS_DEFAULT_TIMEOUT=120
C2C_SECRET=xah9soH7
