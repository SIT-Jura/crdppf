from sqlalchemy import(
    Column, 
    Sequence, 
    Integer, 
    Text,
    String, 
    Boolean, 
    ForeignKey, 
    Float)
    
from sqlalchemy.orm import relationship, backref, deferred

from zope.sqlalchemy import ZopeTransactionExtension

import sqlahelper

DBSession = sqlahelper.get_session()

from papyrus.geo_interface import GeoInterface
from geoalchemy import (
    GeometryColumn, 
    Geometry, 
    Polygon,
    WKTSpatialElement,
    GeometryDDL#,
#    WKBSpatialElement
    )

from crdppf import db_config

Base = sqlahelper.get_base()

# Models for the configuration of the application
class AppConfig(Base):
    __tablename__ = 'appconfig'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    
# START models used for static extraction and general models
class Topics(Base):
    __tablename__ = 'topic'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    layers = relationship("Layers", backref=backref("layers"),lazy="joined")
    authorityfk = Column(Integer, ForeignKey('crdppf.authority.authorityid'))
    authority = relationship("Authority", backref=backref("authority"),lazy="joined")
    legalbases = relationship("LegalBases", backref=backref("legalbases"),lazy="joined")
    legalprovisions = relationship("LegalProvisions", backref=backref("legalprovisions"),lazy="joined")
    temporaryprovisions = relationship("TemporaryProvisions", backref=backref("temporaryprovisions"),lazy="joined")
    references = relationship("References", backref=backref("references"),lazy="joined")
    
class Layers(Base):
    __tablename__ = 'layers'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    topicfk = Column(String(10), ForeignKey('crdppf.topic.topicid'))
    topic = relationship("Topics", backref=backref("topic"),lazy="joined")

class Documents(Base):
    __tablename__ = 'documents_saisies'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    
class Authority(Base):
    __tablename__ = 'authority'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}

class LegalBases(Base):
    __tablename__ = 'legalbases'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    topicfk = Column(String(10), ForeignKey('crdppf.topic.topicid'))

class LegalProvisions(Base):
    __tablename__ = 'legalprovisions'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    topicfk = Column(String(10), ForeignKey('crdppf.topic.topicid')) 

class TemporaryProvisions(Base):
    __tablename__ = 'temporaryprovisions'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    topicfk = Column(String(10), ForeignKey('crdppf.topic.topicid'))

class References(Base):
    __tablename__ = 'references'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    topicfk = Column(String(10), ForeignKey('crdppf.topic.topicid'))

class PaperFormats(Base):
    __tablename__ = 'paperformats'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}

class Translations(Base):
    __tablename__ = 'translations'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    
class Themes(Base):
    __tablename__ = 'themes'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}


# DATA SECTION

if db_config['tables']['cadastre']['exists']:
    class Cadastre(GeoInterface,Base):
        __tablename__ = db_config['tables']['cadastre']['tablename']
        __table_args__ = {'schema': db_config['tables']['cadastre']['schema'], 'autoload': True}
        idobj = Column(Integer, primary_key=True)
        geom =GeometryColumn(Geometry(2,srid=21781))
else:
    class Cadastre():
        pass

if db_config['tables']['property']['exists']:
    class ImmeublesCanton(GeoInterface,Base):
        __tablename__ = db_config['tables']['property']['tablename']
        __table_args__ = {'schema': db_config['tables']['property']['schema'], 'autoload': True}
        noobj = Column(Integer, primary_key=True)
        geom =GeometryColumn(Geometry(2,srid=21781))
else:
    class ImmeublesCanton():
        pass

if db_config['tables']['local_names']['exists']:
    class NomLocalLieuDit(GeoInterface,Base):
        __tablename__ = db_config['tables']['local_names']['tablename']
        __table_args__ = {'schema': db_config['tables']['local_names']['schema'], 'autoload': True}
        idcnlo = Column(String(30), primary_key=True)
        geom =GeometryColumn(Geometry(2,srid=21781))
else:
    class NomLocalLieuDit():
        pass
    
# STOP models used for static extraction and general models

# START models used for GetFeature queries

# models for theme: allocation plan

class PrimaryLandUseZones(GeoInterface,Base):
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    __tablename__ = 'r73_affectations_primaires'
    idobj = Column(Integer, primary_key=True)
    geom =GeometryColumn(Geometry(2,srid=21781))

class SecondaryLandUseZones(GeoInterface,Base):
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    __tablename__ = 'r73_zones_superposees'
    idobj = Column(Integer, primary_key=True)
    geom =GeometryColumn(Geometry(2,srid=21781))

class ComplementaryLandUsePerimeters(GeoInterface,Base):
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    __tablename__ = 'r73_perimetres_superposes'
    idobj = Column(Integer, primary_key=True)
    geom =GeometryColumn(Geometry(2,srid=21781))

class LandUseLinearConstraints(GeoInterface,Base):
    __tablename__ = 'r73_contenus_lineaires'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    idobj = Column(Integer, primary_key=True)
    geom =GeometryColumn(Geometry(2,srid=21781))

class LandUsePointConstraints(GeoInterface,Base):
    __tablename__ = 'r73_contenus_ponctuels'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    idobj = Column(Integer, primary_key=True)
    geom =GeometryColumn(Geometry(2,srid=21781))

# models for the topic national roads

# None yet

# models for the national railways

# None yet

# models for airports

class CHAirportSecurityZones(GeoInterface,Base):
    __tablename__ = 'r108_bazl_sicherheitszonenplan'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    idobj = Column(Integer, primary_key=True)
    geom = GeometryColumn(Geometry(2,srid=21781))
    # ch.bazl.sicherheitszonenplan.oereb

GeometryDDL(CHAirportSecurityZones.__table__)

class CHAirportProjectZones(GeoInterface,Base):
    __tablename__ = 'r103_bazl_projektierungszonen_flughafenanlagen'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    idobj = Column(Integer, primary_key=True)
    geom = GeometryColumn(Geometry(2,srid=21781))
    # ch.bazl.projektierungszonen-flughafenanlagen.oereb

GeometryDDL(CHAirportProjectZones.__table__)

#~ class Corridors(GeoInterface,Base):
    #~ __tablename__ = 'clo_couloirs'
    #~ __table_args__ = {'schema': 'amenagement', 'autoload': True}
    #~ idobj = Column(Integer, primary_key=True)
    #~ geom =GeometryColumn(Geometry(2,srid=21781))
    
#~ class AltitudeRatings(GeoInterface,Base):
    #~ __tablename__ = 'clo_cotes_altitude_surfaces'
    #~ __table_args__ = {'schema': 'amenagement', 'autoload': True}
    #~ idobj = Column(Integer, primary_key=True)
    #~ geom =GeometryColumn(Geometry(2,srid=21781))

# models for theme: register of polluted sites

class PollutedSites(GeoInterface,Base):
    __tablename__ = 'r116_sites_pollues'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    idobj = Column(Integer, primary_key=True)
    geom =GeometryColumn(Geometry(2,srid=21781))
    
class CHPollutedSitesPublicTransports(GeoInterface,Base):
    __tablename__ = 'r119_bav_belastete_standorte_oev'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    idobj = Column(Integer, primary_key=True)
    geom =GeometryColumn(Geometry(2,srid=21781))

GeometryDDL(CHPollutedSitesPublicTransports.__table__)
# ch.bav.kataster-belasteter-standorte-oev.oereb

# models for the topic noise

class RoadNoise(GeoInterface,Base):
    __tablename__ = 'r145_sens_bruit'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    idobj = Column(Integer, primary_key=True)
    geom =GeometryColumn(Geometry(2,srid=21781))

# models for water protection

class Zoneprotection(GeoInterface,Base):
    __tablename__ = 'r131_zone_prot_eau'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    idobj = Column(String(40), primary_key=True)
    geom = GeometryColumn(Geometry(srid=21781))
    
class WaterProtectionPerimeters(GeoInterface,Base):
    __tablename__ = 'r132_perimetre_prot_eau'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    idobj = Column(String(40), primary_key=True)
    geom = GeometryColumn(Geometry(srid=21781))

# models for the topic Forest
class ForestLimits(GeoInterface,Base):
    __tablename__ = 'r157_lim_foret'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    idobj = Column(Integer, primary_key=True)
    geom =GeometryColumn(Geometry(2,srid=21781))
    
class ForestDistances(GeoInterface,Base):
    __tablename__ = 'r159_dist_foret'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    idobj = Column(Integer, primary_key=True)
    geom =GeometryColumn(Geometry(2,srid=21781))

# STOP models used for GetFeature queries