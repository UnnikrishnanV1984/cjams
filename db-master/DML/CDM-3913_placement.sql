update cjams.placement set activeflag = 0, updatedby = 'CDM-3913' , updatedon = now() where placementid in ('d0d978e7-59cd-4f5d-9bca-4363a977c931','e83d94dd-c462-4326-ac1b-08136fbb5c2c');

update cjams.placementrevision set activeflag = 0, updatedby = 'CDM-3913' , updatedon = now() where placementid in ('d0d978e7-59cd-4f5d-9bca-4363a977c931','e83d94dd-c462-4326-ac1b-08136fbb5c2c');
