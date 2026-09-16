-- CDM-10732 - Add removal end date and end reason for child removal

update intakeservreqchildremoval set removalexitreason = 'EMI', exitdate = '2020-07-01 00:00:00', updatedby ='CDM-10732', updatedon = now() where intakeservreqchildremovalid ='002e2e75-bede-41e5-95d2-a17f37cdc07e';
