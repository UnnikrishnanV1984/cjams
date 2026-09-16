/*
Issue: I261013849372:The youth, Andrea Kerins, has a Program Assignment that was automatically assigned and unable to be end dated. 
						The intake was a substance exposed newborn that was an override in the SDM to a screen out so no service case was created
Root Cause:User request to delete the program assignment for the Client Id : 204721851 (Andrea Kerins)
Fix Provided (Data Fix Only):Data fix to delete the program assignment.
Data/Code fix ticket#: CJAMS-65017
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The issue was casused by incorrect data stastus, not a problem in the apllication code, so only a data update was needed to correct it.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/


update personprogramarea
	set activeflag = 0, 
		updatedby = 'CJAMS-65017', 
		updatedon = now()
	where personprogramid = 'bb3c6879-75f8-475a-b123-106e2cef6e71' 
		and activeflag =1;