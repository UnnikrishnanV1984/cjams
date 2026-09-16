/*
Root Cause: User requested to update the provider involved maltreator as Yes at both intake and case level
Fix Provided (Data Fix Only): Data fix is done by updating the provider involved maltreator as Yes from No at both intake and case level
Data/Code fix ticket#: CJAMS-66571
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: this was a one time data correction specific  to a single referral.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

	
UPDATE intakesnapshot
SET 
    jsondata = jsonb_set(
        jsondata, 
        '{sdm}', 
        jsonb_set(
            jsondata->'sdm', 
            '{maltreatment}', 
            '"yes"' 
        )
    ),
    updatedby = 'CJAMS-66571',
    updatedon = now()            
WHERE intakenumber = 'I261013973091' 
  AND activeflag = 1;



UPDATE intakedastaging
SET 
    jsondata = jsonb_set(
        jsondata, 
        '{sdm}', 
        jsonb_set(
            jsondata->'sdm', 
            '{maltreatment}', 
            '"yes"' 
        )
    ),
    updatedby = 'CJAMS-66571',
    updatedon = now()            
WHERE intakenumber = 'I261013973091 ' 
  AND activeflag = 1;
  


update cjams.intakeservicerequestsdm
	set ismaltreatment = true,
		updatedby = 'CJAMS-66571',
		updatedon = now()
	where intakeservicerequestsdmid = '2eb3126d-cc03-45b8-9877-d3c4f49854d1'
		and intakeserviceid = '85d92487-9236-4cb2-ad90-5dfc5fc23749'; 

