update placement 
set enddatetime ='2020-09-08'::date, endtime ='09:00', updatedon =now(), updatedby ='CDM-7188'
where placementid ='bb3e6fb0-3572-4094-88b4-29e181eccf0e';

update intakeservreqchildremoval
set exitdate ='2020-09-08 09:00:00', removalexitreason ='TON', updatedon =now(), updatedby ='CDM-7188'
where intakeservreqchildremovalid = '1276dd8e-92c9-4968-8ae9-b27942dd14c8';

update personprogramarea
set enddate ='2020-09-08 09:00:00', updatedon =now(), updatedby ='CDM-7188'
where personprogramid ='e968701d-e99e-459f-9608-0d10e1bcf2b0';

update legalcustody 
set enddate ='2020-09-08 09:00:00', todate ='2020-09-08 09:00:00', updatedon =now(), updatedby ='CDM-7188'
where legalcustodyid = '4b4310c8-a4b0-41bb-bb5f-b7cebb9dcbc8';