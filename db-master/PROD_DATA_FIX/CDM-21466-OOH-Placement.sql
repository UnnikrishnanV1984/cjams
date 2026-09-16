
	/*
   Issue Description: CDM-21466
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to change end date removal and placement 
   Pull request# for code fix: 5135
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update placement set enddatetime = '2022-01-15 09:00:00', updatedby = 'CDM-21466', updatedon = now() 
where placementid = 'd2c0ebf6-4809-449f-8413-78d1621f9fff';
update livingarrangement set livingenddate = '2022-01-15 09:00:00', updatedby = 'CDM-21466', updatedon = now() 
where placementid = 'd2c0ebf6-4809-449f-8413-78d1621f9fff';

update personprogramarea set enddate = '2022-01-15 09:00:00', updatedby = 'CDM-21466', updatedon = now() 
where personprogramid = '4a63ce1a-1352-4c42-9ff5-269ee3ea1052';

update placementrevision set exitdate ='2022-01-15 09:00:00', updatedby = 'CDM-21466', updatedon = now()
where placementid = 'd2c0ebf6-4809-449f-8413-78d1621f9fff' and exitdate = '2022-01-19';