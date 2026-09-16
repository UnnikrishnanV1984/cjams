/*
 Issue: Can't start GAP Subsidy
 Category/Module: PermanencyPlans/GAP
 Root cause: The worker cannot complete the closing check list as the agreement start date is missing
 Fix provided: Datafix has been done accordingly to add the agreement start date
 Data/Code fix ticket#: CDM-43169
 Regression Impacts: N/A
 Is Code fix Required?: No
 Code fix ticket#: N/A
 Reason why no related code fix: NA
 Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
 Backup before update/ delete:Query:
 */
UPDATE
    cjams.gapagreement
SET
    startdate = '2024-11-21 00:00:00.000',
    updatedon = now(),
    updatedby = 'CDM-43169'
WHERE
    gapagreementid = '7ac5e137-2ba9-493b-9c5e-f2669cf6f59f';