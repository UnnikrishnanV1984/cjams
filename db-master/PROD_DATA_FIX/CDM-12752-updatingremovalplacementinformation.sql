update intakeservreqchildremoval i set exitdate = '2020-07-28 11:30:00', updatedon = now(),updatedby = 'CDM-12752'
where removalid = '193368';


update personprogramarea set enddate = '2020-07-28 11:30:00', updatedon = now()
where personprogramid = '9f7d69ba-bd74-4b07-bdd0-2926d4e74bdc';


update placement set enddatetime = '2020-07-28 00:00:00', endtime = '11:30', updatedon = now(),updatedby = 'CDM-12752'
where placementid = '7d261d40-91b3-4266-8a94-1349089a81d9';

update livingarrangement l set livingenddate = '2020-07-28 11:30:00', updatedon = now(),updatedby = 'CDM-12752' where placementid = '7d261d40-91b3-4266-8a94-1349089a81d9'
