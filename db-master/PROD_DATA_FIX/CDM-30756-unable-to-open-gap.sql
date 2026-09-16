/*
   Issue Description: CDM-30756
   Category/ Module  : Removal end date Unable to reopen gap
   Root cause: User requested to update the end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    intakeservreqchildremoval
set
    exitdate = '2023-03-09 00:00:00.000',
    updatedby = 'CDM-30756',
    updatedon = now()
where
    intakeservreqchildremovalid = '203f416a-462a-4d91-980c-8615e999ab7f';

update
    tb_client_eligibility
set
    end_dt = '2022-03-09 00:00:00.000',
    update_user_id = 'CDM-30756',
    update_ts = now()
where
    removal_id = '250946';

update 
    personprogramarea 
set 
    enddate = '2022-03-09 00:00:00.000', 
    updatedby = 'CDM-30756', 
    updatedon = now() 
where 
    personprogramid = 'aa20f857-5688-4e51-af28-408ab4c8425b' and programkey = 'OOH';
