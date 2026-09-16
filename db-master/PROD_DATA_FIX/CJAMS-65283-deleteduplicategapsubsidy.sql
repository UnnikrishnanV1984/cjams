/*
Issue: CJAMS-65283 GAP Annual Review Entered Two times, so now I am unable to enter the rate renewal for approval
Category/Module: Gap / Subsidy rate
Root cause: User entered GAP subsidy rate by mistake and data fix needed to delete the incorrect GAP rate records
Fix provided:  Data fix has been done to delete the duplicate GAP subsidy rate records and trigger the payments batch.
Data/Code fix ticket#: CJAMS-65283
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User data entry error
*/

update gapagreementrate
set activeflag = 0,
    updatedby='CJAMS-65283',
    updatedon = now()
where gapagreementrateid in ('46b58264-f4ef-4c70-85cf-4e7ef3b0b202','93263ee0-4e2d-4ec4-84ae-90ab1db22dbc') and activeflag=1;

update gapratesrevision
set activeflag = 0,
    updatedby='CJAMS-65283',
    updatedon = now()
where gaprateid in ('46b58264-f4ef-4c70-85cf-4e7ef3b0b202','93263ee0-4e2d-4ec4-84ae-90ab1db22dbc') and activeflag=1;

update routing
set activeflag = 0,
    updatedby='CJAMS-65283',
    updatedon = now()
where objectid in ('46b58264-f4ef-4c70-85cf-4e7ef3b0b202','93263ee0-4e2d-4ec4-84ae-90ab1db22dbc') and activeflag=1;


update gapratesrevision
set updatedby='CJAMS-65283',
    updatedon = now(),
    approvaldate =now() -- To trigger payments batch
where gaprateid in ('e028005d-f6fc-4317-a6df-e6698d6d6000') and activeflag=1;