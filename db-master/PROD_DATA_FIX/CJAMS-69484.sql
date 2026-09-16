/*
Issue Description: Error removal needs deleted. 
Category/Module: Child Removal
Case ID: 261030713142
Root cause: Dyumani Thompson, CJAMS PID 204957729 The removal record was entered in error, as the child was never removed or sheltered by the agency.
Fix provided: Deactivated the erroneous child removal and its related history, routing, OOH program, and eligibility records, and removed the removal reference from the associated placement record.
Data/Code fix ticket#: CJAMS-69484
Regression Impacts: N/A - scoped to a single removal (removalid 396104) for one client.
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error.  The child was never sheltered by the agency, and the removal record was entered in error.                                           
*/

--1. Deactivating the child removal
update intakeservreqchildremoval
set activeflag = 0,
    updatedby = 'CJAMS-69484',
    updatedon = now()
where intakeservreqchildremovalid = '2ca8825a-761d-4dd6-88fb-ac4e8b1896e9'
    and removalid = 396104
    and activeflag = 1;



--2. Deactivating the child removal history
update intakeservreqchildremoval_history
set activeflag = 0,
    updatedby = 'CJAMS-69484',
    updatedon = now()
where intakeservreqchildremovalid = '2ca8825a-761d-4dd6-88fb-ac4e8b1896e9'
    and activeflag = 1;

--3. Deactivating the child removal routing record
update routing
set activeflag = 0,
    updatedby = 'CJAMS-69484',
    updatedon = now()
where objectid = '2ca8825a-761d-4dd6-88fb-ac4e8b1896e9'
    and eventcode = 'CHRR'
    and activeflag = 1;

--4. Deactivating the OOH program area created by the removal
update personprogramarea
set activeflag = 0,
    updatedby = 'CJAMS-69484',
    updatedon = now()
where personprogramid = '5cba4550-db2b-46cf-9a8f-1ab0c8db2c61'
    and personid = 'dcf3b695-e392-4a1c-91ef-5d54f8ddf079'
    and programkey = 'OOH'
    and activeflag = 1;

--5. Deactivating the Living Arrangement placement linked to the removal
update placement 
set intakeservreqchildremovalid = null, 
updatedby = 'CJAMS-69484', updatedon = now()
    where intakeservreqchildremovalid = '2ca8825a-761d-4dd6-88fb-ac4e8b1896e9'
    and activeflag = 1 ;

update tb_client_eligibility
set delete_sw = 'Y',
    update_user_id = 'CJAMS-69484',
    update_ts = now()
where  removal_id = '396104' 
    and delete_sw  = 'N' ;