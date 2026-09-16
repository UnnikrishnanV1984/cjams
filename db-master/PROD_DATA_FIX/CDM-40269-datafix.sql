/*
   Issue Description: CDM-40269
   Category/ Module  : Child removal
   Root cause: user requested to remove the child from child removal tab
   Pull request# for code fix: 5028
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update cjams.intakeservreqchildremoval
set activeflag =0,
updatedby='CDM-40269',
updatedon=now()
where removalid = 316838
	and activeflag = 1;

update cjams.personprogramarea
set activeflag =0,
updatedby='CDM-40269',
updatedon=now() 
where personprogramid  = '884b905b-f1e4-4cf2-848a-da265f9c623d' and activeflag = 1;

update placement 
set intakeservreqchildremovalid = null,
updatedby='CDM-40269',
updatedon=now() 
where intakeservreqchildremovalid = '57099cd5-8459-4a1d-8485-81fe5d74e144' and activeflag = 1 ;

update routing 
set activeflag = 0,  
updatedby='CDM-40269',
updatedon=now() 
where objectid =  '57099cd5-8459-4a1d-8485-81fe5d74e144' and activeflag = 1 ;
