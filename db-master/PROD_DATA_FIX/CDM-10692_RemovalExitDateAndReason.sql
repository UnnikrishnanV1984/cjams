-- CDM-10692 - End date child removal with reason

update intakeservreqchildremoval set exitdate ='2020-07-09 00:00:00',removalexitreason ='REUNIF', updatedby ='CDM-10692', updatedon = now() where intakeservreqchildremovalid ='a2f01418-7658-4877-a0a0-98101c9dd8da';
