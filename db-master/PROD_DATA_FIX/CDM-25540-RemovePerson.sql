/* 
    Issue Description: CDM-25540
   Category/ Module  : persons tab
   Root cause: user wants to delete person not related to case
   Pull request# for code fix: 6595
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update cjams.intakeservicerequestactor i 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-25540'
where intakeservicerequestactorid = 'f20ef25a-9434-4817-a5ff-a18e4fe7e59d';

update cjams.personrole p  
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-25540'
where personroleid in ('48b29983-6673-42dd-acd0-67c942251d52','848c1023-8570-42f7-acc9-105577b2b091');

update cjams.actorrelationship a2 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-25540'
where intakeservicerequestactorid  = 'f20ef25a-9434-4817-a5ff-a18e4fe7e59d';

update personprogramarea 
set activeflag = 0 ,
    updatedon = now(),
    updatedby = 'CDM-25540'
where personprogramid = '0cfa43ba-480b-44c1-b825-917d1ae76a63';