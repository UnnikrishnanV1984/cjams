-- CDM-8881 - CHange provider exit time in Placement History

update placementrevision set exitdate = '2020-12-15 00:00:00', updatedby = 'CDM-8881', updatedon = now() where  placementrevisionid ='d754d102-50c7-484b-924a-8e80a718fb61';
