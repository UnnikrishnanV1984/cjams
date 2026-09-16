/*
Issue: CJAMS-63964 3170001:Could you please change the discharged date to December 6, 2025? The date was entered wrong.
Category/Module: Placement
Root cause: The placement was endate incorrectly and data fix is needed to correct it.
Fix provided:  Data fix has been done to update the living arrangement end date from 12/05/2025 to 12/06/2025.
Data/Code fix ticket#: CJAMS-63964
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error
*/

update placement
set enddatetime = '2025-12-06 00:00:00',
    updatedon = now(),
    updatedby = 'CJAMS-63964'
where placementid = 'e7784098-c9ac-4320-8af4-793697353e04'
and activeflag = 1;

update placementrevision
set exitdate = '2025-12-06 00:00:00',
    updatedon = now(),
    updatedby = 'CJAMS-63964'
where placementrevisionid = 'd6c8ec6a-d526-494b-b5d1-40ac37ebe699'
and activeflag = 1;


update personhospitalization
set hospital_dischargeddate = '2025-12-06 22:30:00',
    updatedon = now(),
    updatedby = 'CJAMS-63964'
where hospitalizationid = 'e835b99b-d8c3-42a5-80bc-9a25f79ddf13'
and activeflag = 1;    

