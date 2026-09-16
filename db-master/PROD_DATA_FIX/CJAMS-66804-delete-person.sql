/*
   Issue Description: CJAMS-66804
   Category/ Module: Person
   Root cause: User requested to delete the person(#3547704) from case (#3252063)
   Fix Provided : Deleted the person(#3547704) from case (#3252063)
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/


update actor
set activeflag=0, updatedby='CJAMS-66804', updatedon=now()
where personid ='be44acb4-f543-423d-a0a0-faf921f4fa00' and actorid ='1b41e7e5-5da2-43d8-b1bb-67d6624e8c26' and activeflag=1;

update intakeservicerequestactor
set activeflag=0, updatedby='CJAMS-66804', updatedon=now()
where intakeservicerequestactorid='660346b0-1983-4da6-9886-dd6cffb52d16' and activeflag=1;

update personprogramarea 
set activeflag =0, updatedby='CJAMS-66804', updatedon=now()
where personid ='be44acb4-f543-423d-a0a0-faf921f4fa00';

update actorrelationship 
set activeflag =0, updatedby='CJAMS-66804', updatedon=now()
where intakeservicerequestactorid='660346b0-1983-4da6-9886-dd6cffb52d16' and activeflag=1;

update personrole 
set activeflag =0, updatedby='CJAMS-66804', updatedon=now()
where personid ='be44acb4-f543-423d-a0a0-faf921f4fa00';