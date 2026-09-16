/*
Issue: CJAMS-64082 Intake Stuck Referral number I251013519815 
Category/Module: Intake
Root cause: Referral number I251013519815 Intake has been transferred from Wicomico county to Montgomery County and approved by MoCo on 12/05/2025. 
            The Jurisdiction is still listed as Wicomico county so the MoCo Intake Worker can not works with the referral.
Fix provided: Data fix needed to change the Jurisdiction from Wicomico to Montgomery and make sure the worker is able to screen out the intake.
Data/Code fix ticket#: CJAMS-64082
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is due to intake referral
*/


--Updating intakedastaging
update intakedastaging
set jsondata = jsonb_set(jsondata, '{General, countyid}', '"f6ab02d5-c386-4659-8810-687fc191a967"', false),
updatedby = 'CJAMS-64082', updatedon = now()
where intakenumber = 'I251013519815' and activeflag = 1;

--Updating intakedastatus
update intakedastatus
set jsondata = jsonb_set(jsondata, '{General, countyid}', '"f6ab02d5-c386-4659-8810-687fc191a967"', false),
updatedby = 'CJAMS-64082', updatedon = now()
where intakenumber = 'I251013519815' and activeflag = 1;