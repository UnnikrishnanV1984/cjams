/*
 Issue Description: CDM-41553
    Category/ Module: Permanency Payments
    Root cause: User entered wrong date 08/01/2024 instead of 07/31/2024
    Pull request# for code fix: 
    Reason why no related code fix: 
    Status of the code fix if already submitted and expected prod fix date: 
 */
update
    gapagreementrate
set
    startdate = '2024-08-01 00:00:00',
    enddate = '2025-07-31 00:00:00',
    updatedby = 'CDM-41553',
    updatedon = now()
where
    gapagreementrateid = '957f56e4-0183-456a-8b6e-ed757331db9a'
    and activeflag = 1;

update
    gapratesrevision
set
    ratestartdate = '2024-08-01 00:00:00',
    rateenddate = '2025-07-31 00:00:00',
    approvaldate = now(),
    -- Critical for Finance batch
    updatedby = 'CDM-41553',
    updatedon = now()
where
    gaprateid = '957f56e4-0183-456a-8b6e-ed757331db9a'
    and activeflag = 1;