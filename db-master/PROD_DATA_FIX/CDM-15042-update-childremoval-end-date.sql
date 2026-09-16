-- CDM-15042 - Change child removal exit date

update intakeservreqchildremoval set exitdate = '2021-05-25 12:00:00', removalexitreason = 'TTONDA', updatedby = 'CDM-15042', updatedon = now() where intakeservreqchildremovalid = '6f6286ff-e872-4b04-8443-4ec98abbc7e6';
