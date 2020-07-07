# -*- coding: utf-8 -*-

from sqlalchemy import(
    Column, 
    Sequence, 
    Integer, 
    Text,
    String,
    Float)

from sqlalchemy.orm import relationship, backref,deferred
    
from papyrus.geo_interface import GeoInterface
from geoalchemy2 import Geometry

from crdppf import db_config
srid_ = db_config['srid']

from crdppf.models import Base

# Specific model definition here
class ZonesReservees(GeoInterface, Base):
    __tablename__ = 'r76_zones_reservees'
    __table_args__ = {'schema': db_config['schema'], 'autoload': True}
    idobj = Column(Integer, primary_key=True)
geom = Column(Geometry("POLYGONE", srid=srid_))