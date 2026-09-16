/*
Issue: CJAMS-65035 Payments did not populate
Category/Module: GAP / Suspension
Root cause: There is no GAP subsidy payment created from September 2025 to January 2026.Verified in the DB and found that there is an exisiting Suspension record with
            start date as 2025-08-22 04:00:00.000 which is a draft record and this is not shown in the UI as there is routing record missing for this suspension.
            As mentioned user has wrongly created a suspension and removed it later but still the draft record is existing in the DB.
Fix provided:  Data fix has been done to remove the incorrect GAP suspension record and trigger the pending payments.
Data/Code fix ticket#: CJAMS-65035
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Draft suspension created and data fix needed for this issue.
*/

update gapsuspension 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CJAMS-65035'
where gapsuspensionid = '7887e18f-84ea-4d65-96db-e862b826a1ce'
and   gapid = 'aad24fb8-af6e-4764-a5d7-58843b100722'
and activeflag = 1;


--updating gapraterevision table to trigger finance batch.

update gapratesrevision
set approvalDate = now(),
    updatedby = 'CJAMS-65035',
    updatedon = now()
where gaprateid in ('df2eaf8a-d1b8-42b8-8968-e26f1451e843','240a05ba-8d77-4742-8ab6-898c1eaded5a')
and activeflag = 1;  