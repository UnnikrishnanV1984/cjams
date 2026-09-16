update cjams.placementrevision
set approvedby='dd3ac302-59b9-4e32-ac55-94a0d551ee4f', 
	approveddate='2021-03-29 00:00:00',
	updatedon =now(),
	updatedby ='CDM-11746'
where placementrevisionid ='49170623-9aee-4c21-932a-af2565358396';

update placement 
set enddatetime ='2021-03-29 00:00:00.000',
	exitreasontypekey ='CIPS',
	updatedon =now(),
	updatedby ='CDM-11746'
where placementid ='93f6453a-f5f9-4789-8da9-c65c82a5c8c7';

delete from placementrevision 
where placementrevisionid ='4732616f-25fa-42d2-846a-7d0f2b8526ec';
