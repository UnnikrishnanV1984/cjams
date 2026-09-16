/*
Root Cause:Please carry out data fix to update the Near-Death/Serious Physical Injury radio button to "No" in SDM tab for CPS IR# 261023642954 and Intake# I261013911229
Fix Provided (Data Fix Only):Updated the Serious Physical Injury in sdm for the client Elijah Everett (204168095) .
Data/Code fix ticket#:
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update cjams.intakeservicerequestsdm
	set isseriousphysicalinjury = false,
		updatedby = 'CJAMS-69019',
		updatedon = now()
	where intakeservicerequestsdmid = '6a582ce9-6917-453f-8817-cde82ed0cff1'
		and intakeserviceid = '923d34b8-16ae-48b6-958b-cbf9dc78f9ee'; 
	
		
