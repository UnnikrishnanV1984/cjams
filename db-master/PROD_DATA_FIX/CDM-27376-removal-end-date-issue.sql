/*
   Issue Description: CDM-27376
   Category/ Module  : Removal end date
   Root cause: User requested to update the end date
   Pull request# for code fix: 4404
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    intakeservreqchildremoval
set
    exitdate = '2022-08-30 00:00:00.000',
    updatedby = 'CDM-27376',
    updatedon = now()
where
    intakeservreqchildremovalid in (
        'd337febf-ce9f-449e-8276-248fb2d538c0',
        'c3465470-531f-4200-98b0-8f63bfac4d02'
    );

update
    tb_client_eligibility
set
    end_dt = '2022-08-30 00:00:00.000',
    update_user_id = 'CDM-27376',
    update_ts = now()
where
    removal_id in ('254426', '254425');