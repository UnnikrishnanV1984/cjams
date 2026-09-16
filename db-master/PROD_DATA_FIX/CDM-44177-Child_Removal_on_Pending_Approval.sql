/*
   Issue Description: CDM-30453
   Category/ Module  : Dashboard
   Root cause: user requested to remove pending approval from dashboard
   Pull request# for code fix: 
   Reason why no related code fix:     
*/

update routing 
set activeflag = 0,
    updatedby = 'CDM-44177',
    updatedon = now() 
where objectid ='45715f69-3844-4fea-abbc-6f9c26e404d9';

update intakeservreqchildremoval_history
set activeflag = 0,
	updatedby = 'CDM-44177', 
	updatedon = now() 
where intakeservreqchildremovalid = '45715f69-3844-4fea-abbc-6f9c26e404d9'
and activeflag = 1;