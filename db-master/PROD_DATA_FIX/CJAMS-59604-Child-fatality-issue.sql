/*
    Issue Description: CJAMS-59604 251023054998:This was a child fatality report but the Child Fatality button was not selected in the intake. 
                      The child's profile has been updated with a date of death but the SDM will still not allow the report marked as a child fatality. 
                      Please update to answer yes to the "child fatality" question on the maltreatment type tab. 
    Category/ Module  :  SDM
    Root cause: the fatality information received after the intake screened in. User requested to update the child fatality and we have received SSA approval on 05/13/2025 to proceed with the data fix.
    Fix provided : Data fix has been promoted to update the fatality information in the intake and case side.
    Regression Impacts : N/A
    Code fix ticket#: N/A
    Reason why no related code fix: N/A 
*/

update intakesnapshot
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
updatedby = 'CJAMS-59064',  updatedon =now()
where intakeserviceid = '4f7ce1b0-1272-4403-b42f-47c45fabba6a' and intakenumber='I251013283812' and activeflag=1;

update intakeservicerequestsdm
set ischildfatality = true,
    updatedby = 'CJAMS-59064',
    updatedon = now()
where intakeserviceid='4f7ce1b0-1272-4403-b42f-47c45fabba6a' and activeflag =1;

update intakedastaging
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
updatedby = 'CJAMS-59064',  updatedon =now()
where intakenumber='I251013283812' and activeflag=1;