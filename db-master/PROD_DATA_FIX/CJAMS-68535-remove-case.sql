/*
 Issue Description: CJAMS-68535
 Category/ Module:delete intake and case
 Root cause:  case is in review and user needs both Intake and case to be deleted
            Case-261023818411
            Intake-I261014095651
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/


select * from CW_transactions_dataclenup('INTKE','I261014095651','CJAMS-68535');

update intakeservicerequest 
set activeflag = 0, updatedby = 'CJAMS-68535', updatedon = now() 
where servicerequestnumber='261023818411' and activeflag = 1;


update caseassignment 
set activeflag=0, updatedby = 'CJAMS-68535', updatedon = now() 
where caseassignmentid = '4ab87bbd-d7b0-46f4-a4e9-1fc707f83e3e' and activeflag = 1;


update investigation
set activeflag = 0, updatedby = 'CJAMS-68535', updatedon = now() 
where intakeserviceid ='152c8128-0982-4e95-848e-31fcc443d6d4'  and activeflag = 1;

update intakeservicerequestsdm
set activeflag = 0, updatedby = 'CJAMS-68535', updatedon = now() 
where intakeserviceid ='152c8128-0982-4e95-848e-31fcc443d6d4'  and activeflag = 1;

update intakeservicerequestdispositioncode
set activeflag = 0, updatedby = 'CJAMS-68535', updatedon = now() 
where intakeserviceid ='152c8128-0982-4e95-848e-31fcc443d6d4'  and activeflag = 1;


update actor
set activeflag = 0, updatedby = 'CJAMS-68535', updatedon = now() 
where intakeserviceid ='152c8128-0982-4e95-848e-31fcc443d6d4'  and activeflag = 1;

update intakeservicerequestactor
set activeflag = 0, updatedby = 'CJAMS-68535', updatedon = now() 
where intakeserviceid ='152c8128-0982-4e95-848e-31fcc443d6d4'  and activeflag = 1;

update personrole
set activeflag = 0, updatedby = 'CJAMS-68535', updatedon = now() 
where intakeserviceid ='152c8128-0982-4e95-848e-31fcc443d6d4'  and activeflag = 1;

update personroletype
set activeflag = 0, updatedby = 'CJAMS-68535', updatedon = now() 
WHERE personroleid IN ('7ed53b68-3501-4d2d-8934-19f6ba8b1e98'::uuid,'b47dfe5f-7319-4727-81e0-3ffd86d46310'::uuid) and activeflag = 1;


update actorrelationship
set activeflag = 0, updatedby = 'CJAMS-68535', updatedon = now() 
where intakeserviceid ='152c8128-0982-4e95-848e-31fcc443d6d4'  and activeflag = 1;


update personprogramarea
set activeflag = 0, updatedby = 'CJAMS-68535', updatedon = now() 
where entityid = '261023818411' and activeflag = 1
