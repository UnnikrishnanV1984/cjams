-- CDM-15041 - Change child removal exit date

update intakeservreqchildremoval set exitdate = '2020-10-23 12:00:00', removalexitreason = 'EMANIND', updatedby = 'CDM-15041', updatedon = now() where intakeservreqchildremovalid = '7defead1-4d3c-414a-9638-01ede19d5d78';
