/*
Issue Description:CJAMS-69260-Remove Persons Involved
Category/Module: persons tab
Root cause: user has requested to remove the person CJAMS PID# 204999007 (Elizabeth Carry Willingham) from the inactive Persons Involved of Intake # I261014128223. Ms. Willingham is not connected to this case.
Fix provided: Data fix has been done to remove the person CJAMS PID# 204999007 (Elizabeth Carry Willingham) from Intake # I261014128223. IDs are scoped to this intake only
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:
*/

update actor
set
    activeflag = 0,
    updatedby = 'CJAMS-69260',
    updatedon = now ()
where
    actorid = 'ce079d93-c939-4193-83cf-c10e286a1e00'
    and personid = '723c168b-76ae-44a0-b6f5-8f3ee26ab255'
    and activeflag = 1;

update intakeservicerequestactor
set
    activeflag = 0,
    updatedby = 'CJAMS-69260',
    updatedon = now ()
where
    intakeservicerequestactorid = 'd4c0ed47-2046-4a94-8a00-0046670b97fd'
    and actorid = 'ce079d93-c939-4193-83cf-c10e286a1e00'
    and activeflag = 1;

update personrole
set
    activeflag = 0,
    updatedby = 'CJAMS-69260',
    updatedon = now ()
where
    personroleid = '18b44e08-c05c-499e-aa14-c8886ea6c603'
    and personid = '723c168b-76ae-44a0-b6f5-8f3ee26ab255'
    and activeflag = 1;

update personroletype
set
    activeflag = 0,
    updatedby = 'CJAMS-69260',
    updatedon = now ()
where
    personroleid = '18b44e08-c05c-499e-aa14-c8886ea6c603'
    and personroletypeid = '8d49c18a-a1bb-4148-a467-c82f0edff6fe'
    and activeflag = 1;

update actorrelationship
set
    activeflag = 0,
    updatedby = 'CJAMS-69260',
    updatedon = now ()
where
    intakeservicerequestactorid = 'd4c0ed47-2046-4a94-8a00-0046670b97fd'
    and activeflag = 1;