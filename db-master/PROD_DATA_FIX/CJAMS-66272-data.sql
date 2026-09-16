/*

Root Cause:user error,  user incorrectly select the Child Fatality & Near-Death/Serious Physical Injury incorrectly
Fix Provided (Data Fix Only): Data fix is done to update the child fatality from No to Yes and Near-Death/Serious Physical Injury from yes to NO .
Data/Code fix ticket#: CJAMS-66272
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: this was a one time data correction specific  to a single referral.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/




--Child Fatality - from No to Yes
update intakesnapshot
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
 updatedby = 'CJAMS-66272',  updatedon =now()
where intakenumber = 'I261013947104' and activeflag = 1;


update intakeservicerequestsdm
set ischildfatality = true,
   updatedby = 'CJAMS-66272',  updatedon =now()
where intakeserviceid='aad64271-c066-425f-b31f-93796346c7d6' and activeflag =1;

update intakedastaging
set jsondata=jsonb_set(jsonb_set(jsondata,'{sdm,childfatality}','"yes"'),'{sdm,ischildfatality}','true'),
updatedby = 'CJAMS-66272',  updatedon =now()
where intakenumber='I261013947104' and activeflag=1;

----Near-Death/Serious Physical Injury incorrectly - from Yes to No

update cjams.intakeservicerequestsdm
	set isseriousphysicalinjury = false,
		updatedby = 'CJAMS-66272',
		updatedon = now()
	where intakeservicerequestsdmid = '971ebd78-1074-48e1-b58a-b2c591e12333'
		and intakeserviceid = 'aad64271-c066-425f-b31f-93796346c7d6'; 
	
		
UPDATE cjams.intakedastaging
	SET updatedby = 'CJAMS-66272',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'false'::jsonb))
WHERE
    intakenumber = 'I261013947104'
    AND activeflag = 1;
   
UPDATE cjams.intakesnapshot
	SET updatedby = 'CJAMS-66272',
		updatedon = now(),
		jsondata = jsonb_set(jsondata, '{sdm}', 
			jsonb_set(jsondata->'sdm', '{isseriousphysicalinjury}', 'false'::jsonb))
WHERE
    intakenumber = 'I261013947104'
    AND activeflag = 1;