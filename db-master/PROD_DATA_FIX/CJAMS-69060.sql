/*
Issue Description: CJAMS-69060 - Unable to setup gap case
Category/Module: Permanency Plan / GAP Agreement
Root cause: User entered the wrong court order date while setting up the GAP agreement, so the GAP Agreement start date was saved as 08/13/2021 instead of the correct court order date 05/19/2026 on case # 3258823.
Fix provided: Data fix has been promoted to update the GAP Agreement start date from 08/13/2021 to 05/19/2026 on case # 3258823.
Data/Code fix ticket#: CJAMS-69060
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User data entry error, no defect in the application.
*/

update gapagreement
set startdate = '2026-05-19 12:00:00',
    updatedby = 'CJAMS-69060',
    updatedon = now()
where gapagreementid = 'bafdb596-df88-4592-acda-6714ea56b228'
and activeflag = 1;


update gapagreementrevision
set approvaldate =now(),
    updatedby = 'CJAMS-69060',
    updatedon = now()
where gapagreementid = 'bafdb596-df88-4592-acda-6714ea56b228'
and activeflag = 1;