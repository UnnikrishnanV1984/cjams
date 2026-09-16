/*
Issue Description:CJAMS-66876-added a person to wrong case
Category/Module: persons tab
Root cause: user has requested to remove the wrong person( Norman Moore / PID# 200310605) added in case by error
Fix provided: Data fix has been done to remove the person from case  (Norman Moore / PID# 200310605)
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/




update actor
set
    activeflag = 0,
    updatedby = 'CJAMS-66876',
    updatedon = now ()
where
    actorid = '36217f41-331a-4ee4-9636-2126c6018967'
    and personid = 'ce32633d-d283-4c37-b4ed-7117b1daeb9d'
    and activeflag = 1;

update intakeservicerequestactor
set
    activeflag = 0,
    updatedby = 'CJAMS-66876',
    updatedon = now ()
where
    intakeservicerequestactorid = '4139c8fd-fc71-4fd7-85c3-870b1e8d5624'
    and actorid = '36217f41-331a-4ee4-9636-2126c6018967'
    and activeflag = 1;

update personrole
set
    activeflag = 0,
    updatedby = 'CJAMS-66876',
    updatedon = now ()
where
    personroleid = '413ae460-041d-4cb9-ac5c-a3bc52d1cbab'
    and personid = 'ce32633d-d283-4c37-b4ed-7117b1daeb9d'
    and activeflag = 1;
   

update personroletype
set
    activeflag = 0,
    updatedby = 'CJAMS-66876',
    updatedon = now ()
where
    personroleid = '413ae460-041d-4cb9-ac5c-a3bc52d1cbab'
    and personroletypeid = '78545d3b-5b7f-46c8-a22f-532463ddb87e'
    and activeflag = 1;

update actorrelationship
set
    activeflag = 0,
    updatedby = 'CJAMS-66876',
    updatedon = now ()
where
    intakeservicerequestactorid = '4139c8fd-fc71-4fd7-85c3-870b1e8d5624'
    and activeflag = 1;

update personprogramarea
set
    activeflag = 0,
    updatedby = 'CJAMS-66876',
    updatedon = now ()
where
    personid = 'ce32633d-d283-4c37-b4ed-7117b1daeb9d'
    and personprogramid = '5d1c5b43-2034-4b71-ad52-690e627fcd64'
    and activeflag = 1;
   
  
    
 