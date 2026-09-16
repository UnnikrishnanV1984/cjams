
/*
Issue:251023143622:Child added to incorrect casePlease delete Melissa Giselle Ramirez CIS ID 409042545 from this case
Root Cause:User requested to  delete  the incorrect clienct from case .
Fix Provided (Data Fix Only):Updated into actor table.
Data/Code fix ticket#: CJAMS-62919
Regression Impacts:None 
Is Code fix Required?:no
Code fix ticket#: n/a
Reason why no related code fix:User error
Backup before update/delete:
*/

update actor
set activeflag = 0,updatedby ='CJAMS-62919',updatedon =now()
where actorid = '910d74c4-9463-4804-90ac-0c6151afbdbc' and activeflag = 1;

update intakeservicerequestactor
set activeflag = 0,updatedby ='CJAMS-62919',updatedon =now()
where intakeservicerequestactorid in ('b6f8d36b-6fcf-416f-9d0b-221b7171cfbf', '9336e409-4a19-4426-a32d-61e98918cc50') and activeflag = 1;

update actorrelationship
set activeflag = 0,updatedby ='CJAMS-62919',updatedon =now()
where actorrelationshipid in ('6d9c71b9-989e-454d-88f4-e02ca862aef3', '683a0b55-39cc-464f-9cc7-23ed8024bbeb') and activeflag = 1;

update personprogramarea
set activeflag = 0,updatedby ='CJAMS-62919',updatedon =now()
where personprogramid = 'dec1358f-bd81-4139-9002-bb22b30f2cee' and activeflag = 1;

update personrole 
set activeflag = 0,updatedby ='CJAMS-62919',updatedon =now()
where personroleid  = '09f7c7bc-20c8-4222-8825-dd79a5993717' and activeflag = 1 ;


update  personroletype  
set activeflag = 0,updatedby ='CJAMS-62919',updatedon =now()
where personroletypeid  = 'f7a75bfa-c71f-42ea-b9c6-b9a7e50c634a' and activeflag = 1 ;
