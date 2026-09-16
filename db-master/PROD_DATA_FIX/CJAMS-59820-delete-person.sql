/*
Issue Description: 3277818:Hello! In-Home Supervisor, Ronda Lewis (ronda.lewis@maryland.gov) and assigned In-Home Case Worker, Colleen Ruark (colleen.ruark@maryland.gov), would like for the person card with Joshua M. Goddard (DOB: 12/12/1993; CJAMS PID: 1063129) to be removed from the S. Mansfield McNeese case #3277818 completely if possible. This person was not mentioned in the original intake but was entered by the intake worker when entering the referral for unknown reasons. The family does not want this person to be associated with the current case at all due to past legal issues involving this person. Please remove this person if possible and reach out to me if additional info. is needed.
Category/Module: person Removal 
Root cause: This person was not mentioned in the original intake but was entered by the intake worker when entering the referral for unknown reasons
Fix provided: Data fix has been done to delete the person card Joshua M. Goddard (DOB: 12/12/1993; CJAMS PID: 1063129)
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

-- select * from person where personid = 'ff9a8939-60f7-4f37-bb09-a1b7345a771f' and activeflag = 1;

--Deactivating client from intakeservicerequestactor

-- select * from intakeservicerequestactor i where personid ='ff9a8939-60f7-4f37-bb09-a1b7345a771f' and intakeservicerequestactorid ='4c2b6753-2c9a-4a4e-8bf7-34dafad3a93c' and activeflag =1;

update intakeservicerequestactor
set activeflag = 0, updatedby = 'CJAMS-59820', updatedon = now()
where intakeservicerequestactorid = '4c2b6753-2c9a-4a4e-8bf7-34dafad3a93c' and activeflag = 1;

--Deactivating client from actor

-- select * from actor where personid = 'ff9a8939-60f7-4f37-bb09-a1b7345a771f' and actorid = 'bd3576b0-c8b2-44d2-b75b-3852d95e289c' and activeflag = 1;

update actor
set activeflag = 0, updatedby = 'CJAMS-59820', updatedon = now()
where actorid = 'bd3576b0-c8b2-44d2-b75b-3852d95e289c' and activeflag = 1;

--Deactivating client from actorrelationship

-- select intakenumber ,intakeservicerequestactorid,* from actorrelationship where intakeservicerequestactorid = '4c2b6753-2c9a-4a4e-8bf7-34dafad3a93c' and activeflag = 1;

--Deactivating client from personrole

-- select * from personrole where personid = 'ff9a8939-60f7-4f37-bb09-a1b7345a771f' and intakenumber ='3277818' and activeflag = 1;

update personrole
set activeflag = 0, updatedby = 'CJAMS-59820', updatedon = now()
where personroleid = '980b2d6e-ad0a-466a-af8e-035d7f5213ce' and activeflag = 1;

-- select * from actorrelationship where intakeservicerequestactorid ='4c2b6753-2c9a-4a4e-8bf7-34dafad3a93c';

-- select * from personroletype p where personroleid ='980b2d6e-ad0a-466a-af8e-035d7f5213ce';

update personroletype 
set activeflag =0, updatedby ='CJAMS-59820', updatedon =now()
where personroleid ='980b2d6e-ad0a-466a-af8e-035d7f5213ce' and activeflag =1;

update personprogramarea 
set activeflag =0, updatedby ='CJAMS-59820', updatedon =now()
where personprogramid ='67f630d2-e5f8-4e55-abdb-4742b71b3174' and activeflag =1;