# -*- coding: UTF-8 -*-
from crdppf.models.models import PrimaryLandUseZones, SecondaryLandUseZones
from crdppf.models.models import ComplementaryLandUsePerimeters, LandUseLinearConstraints
from crdppf.models.models import LandUsePointConstraints, PollutedSites
from crdppf.models.models import CHHighwaysProjectZones, CHHighwaysConstructionLimits
from crdppf.models.models import CHRailwaysProjectZones, CHRailwaysConstructionLimits
from crdppf.models.models import CHAirportSecurityZones, CHAirportSecurityZonesPDF
from crdppf.models.models import CHAirportProjectZones, CHAirportProjectZonesPDF
from crdppf.models.models import CHAirportConstructionLimits, CHAirportConstructionLimitsPDF
from crdppf.models.models import CHPollutedSitesCivilAirports, CHPollutedSitesCivilAirportsPDF
from crdppf.models.models import CHPollutedSitesPublicTransports, CHPollutedSitesPublicTransportsPDF
from crdppf.models.models import ContaminatedMilitarySites
from crdppf.models.models import WaterProtectionZones, WaterProtectionPerimeters
from crdppf.models.models import RoadNoise, ForestLimits, ForestDistances
from crdppfportal.models import ZonesReservees
from crdppfportal.models import InventoriesArchaeologicalPaleontologicalSites

# Matching dictionnary model-table name
table2model_match = {
    'r73_affectations_primaires': PrimaryLandUseZones,
    'r73_zones_superposees': SecondaryLandUseZones,
    'r73_perimetres_superposes': ComplementaryLandUsePerimeters,
    'r73_contenus_lineaires': LandUseLinearConstraints,
    'r73_contenus_ponctuels': LandUsePointConstraints,
    'r73_contenus_ponctuels': LandUsePointConstraints,
    'r76_zones_reservees': ZonesReservees,
    'r12_ju_inventaire_sites_archeo_paleonto': InventoriesArchaeologicalPaleontologicalSites,
    'r87_astra_projektierungszonen_nationalstrassen': CHHighwaysProjectZones,
    'r88_astra_baulinien_nationalstrassen': CHHighwaysConstructionLimits,
    'r97_bav_baulinien_eisenbahnanlagen': CHRailwaysConstructionLimits,
    'r96_bav_projektierungszonen_eisenbahnanlagen': CHRailwaysProjectZones,
    'r103_bazl_projektierungszonen_flughafenanlagen': CHAirportProjectZones,
    'r103_bazl_projektierungszonen_flughafenanlagen_pdf': CHAirportProjectZonesPDF,
    'r104_bazl_baulinien_flughafenanlagen': CHAirportConstructionLimits,
    'r104_bazl_baulinien_flughafenanlagen_pdf': CHAirportConstructionLimitsPDF,
    'r108_bazl_sicherheitszonenplan': CHAirportSecurityZones,
    'r108_bazl_sicherheitszonenplan_pdf': CHAirportSecurityZonesPDF,
    'r116_sites_pollues': PollutedSites,
    'r117_vbs_belastete_standorte_militaer': ContaminatedMilitarySites,
    'r118_bazl_belastete_standorte_zivilflugplaetze': CHPollutedSitesCivilAirports,
    'r118_bazl_belastete_standorte_zivilflugplaetze_pdf': CHPollutedSitesCivilAirportsPDF,
    'r119_bav_belastete_standorte_oev': CHPollutedSitesPublicTransports,
    'r119_bav_belastete_standorte_oev_pdf': CHPollutedSitesPublicTransportsPDF,
    'r131_zone_prot_eau': WaterProtectionZones,
    'r132_perimetre_prot_eau': WaterProtectionPerimeters,
    'r145_sens_bruit': RoadNoise,
    'r157_lim_foret': ForestLimits,
    'r159_dist_foret': ForestDistances
}