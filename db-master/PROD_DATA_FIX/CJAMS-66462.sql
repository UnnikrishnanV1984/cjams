/*
Issue Description:CJAMS-66462-Remove person
Category/Module: persons tab
Root cause: user has requested to remove the person CJAMS PID# 200977235 (Ranaiya Brinay Miller) from the CPS IR # 261023669798 from case
Fix provided: Data fix has been done to remove the person from case  CJAMS PID# 200977235 (Ranaiya Brinay Miller) from the CPS IR # 261023669798
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/

update actor
set
    activeflag = 0,
    updatedby = 'CJAMS-66462',
    updatedon = now ()
where
    actorid = 'e18fe5a9-0baa-4c01-b099-9875a8f6f851'
    and personid = 'f85625fb-a02d-4c93-80c2-61224e09487c'
    and activeflag = 1;

update intakeservicerequestactor
set
    activeflag = 0,
    updatedby = 'CJAMS-66462',
    updatedon = now ()
where
    intakeservicerequestactorid in ('0f886b8d-fd1f-4bff-b62d-9b1e9cec5649','21178a27-2160-4bfe-8d7c-6853e0614e9f')
    and actorid = 'e18fe5a9-0baa-4c01-b099-9875a8f6f851'
    and activeflag = 1;

update personrole
set
    activeflag = 0,
    updatedby = 'CJAMS-66462',
    updatedon = now ()
where
    personroleid = 'd34c4afa-9407-48a1-af9b-7660c1b010df'
    and personid = 'f85625fb-a02d-4c93-80c2-61224e09487c'
    and activeflag = 1;
   

update personroletype
set
    activeflag = 0,
    updatedby = 'CJAMS-66462',
    updatedon = now ()
where
    personroleid = 'd34c4afa-9407-48a1-af9b-7660c1b010df'
    and personroletypeid in ('48a05d50-59da-4353-bf92-46ba794e42ed','aba9eebc-f530-45df-a694-fa44c1f3c94b')
    and activeflag = 1;

update actorrelationship
set
    activeflag = 0,
    updatedby = 'CJAMS-66462',
    updatedon = now ()
where
    intakeservicerequestactorid in ('0f886b8d-fd1f-4bff-b62d-9b1e9cec5649','21178a27-2160-4bfe-8d7c-6853e0614e9f')
    and activeflag = 1;

update personprogramarea
set
    activeflag = 0,
    updatedby = 'CJAMS-66462',
    updatedon = now ()
where
    personid = 'f85625fb-a02d-4c93-80c2-61224e09487c'
    and personprogramid = '36e2a916-b26b-407b-aaca-994dc6585567'
    and activeflag = 1;