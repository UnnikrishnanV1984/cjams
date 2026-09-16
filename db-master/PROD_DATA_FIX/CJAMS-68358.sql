/*
Issue Description:CJAMS-68358-Remove person
Category/Module: persons tab
Root cause: user has requested to remove the person CJAMS PID# 204972062 Rachel Not This Archambault from case
Fix provided: Data fix has been done to remove the person from case  CJAMS PID# 204972062 Rachel Not This Archambault
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update actor
set
    activeflag = 0,
    updatedby = 'CJAMS-68358',
    updatedon = now ()
where
    actorid = '578ca254-5166-4cdd-95b1-59d18a532b84'
    and personid = '2dd2d0dc-cdd6-4788-bf01-d451caaa0ad3'
    and activeflag = 1;

update intakeservicerequestactor
set
    activeflag = 0,
    updatedby = 'CJAMS-68358',
    updatedon = now ()
where
    intakeservicerequestactorid = '3bc3f00b-f8e3-457d-bc7e-5135a0cbc492'
    and actorid = '7107b745-e9ee-4430-bb74-75c238e42cde'
    and activeflag = 1;

update personrole
set
    activeflag = 0,
    updatedby = 'CJAMS-68358',
    updatedon = now ()
where
    personroleid = '0af0d9f1-7983-4c49-8a4c-b4a6dd014bed'
    and personid = '2dd2d0dc-cdd6-4788-bf01-d451caaa0ad3'
    and activeflag = 1;
   

update personroletype
set
    activeflag = 0,
    updatedby = 'CJAMS-68358',
    updatedon = now ()
where
    personroleid = '0af0d9f1-7983-4c49-8a4c-b4a6dd014bed'
    and personroletypeid = '646b707f-0845-4975-aeee-de9f2ae402cb'
    and activeflag = 1;

update actorrelationship
set
    activeflag = 0,
    updatedby = 'CJAMS-68358',
    updatedon = now ()
where
    intakeservicerequestactorid = '3bc3f00b-f8e3-457d-bc7e-5135a0cbc492'
    and activeflag = 1;

update personprogramarea
set
    activeflag = 0,
    updatedby = 'CJAMS-68358',
    updatedon = now ()
where
    personid = '2dd2d0dc-cdd6-4788-bf01-d451caaa0ad3'
    and personprogramid = '24f1f45c-906d-4f60-886d-85d7094a4b0f'
    and activeflag = 1;