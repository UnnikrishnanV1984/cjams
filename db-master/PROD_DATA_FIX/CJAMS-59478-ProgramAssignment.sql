
/*
Issue:3276107:Hello. I need to readd the program assignment for this case to say adoption and please remove the end date for the subsidy.
Root Cause:User request to remove program end date, they have access but they edit option.
Fix Provided (Data Fix Only):Data fix was done by updating the routing table .
Data/Code fix ticket#: CJAMS-59478
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The issue was casused by incorrect data stastus, not a problem in the apllication code, so only a data update was needed to correct it.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/




update personprogramarea
set enddate = null, updatedby = 'CJAMS-59478', updatedon = now()
where personprogramid = '2b7b086f-6cb9-4705-a6bc-9fd9699372ea' and activeflag =1;