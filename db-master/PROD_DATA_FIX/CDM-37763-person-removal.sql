/*
   Issue Description: CDM-37763
   Category/ Module  :Need a Person removed
   Root cause: User requested to remove Need to remove the child Nathan Sell (CJAMS PID# 202823514 from Person tab for CPS AR # 241021916350 .
   Fix Privided: Did data fix to remove the hild Nathan Sell from persons for CPS AR # 241021916350.
*/
update cjams.actor 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-37763'
where actorid ='94853751-bcab-45c2-9abe-7388cb3738eb'
and intakeserviceid='72ad1607-68c0-4206-a15a-865193a6251b';

update cjams.intakeservicerequestactor  
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-37763'
where intakeservicerequestactorid = '6c8997b8-3186-42b5-aa48-47aba618e397';

update cjams.personrole   
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-37763'
where personroleid  = '22937021-e4c5-43aa-9476-a75ad64c53ca';

update cjams.actorrelationship 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-37763'
where actorrelationshipid = '017d6012-ba67-4439-9a0c-96593ef53b29';


update personprogramarea 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-37763' 
where personprogramid = 'e5599b6c-3638-492d-8727-a2d5e4865927';

update personroletype 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-37763' 
where personroletypeid = 'f0103db7-17c6-4a4a-ab9d-52cf6c39580d';