/*
Issue:I231011318335:251022986357:The Incident date is incorrect in this report. The child stated the incident occurred when he was 3 and living with his mother. the date should be 07/01/2016. the Approximate Date should also be checked. We need this changed to address our Maltreatment in Care reports.Wanda Nolt Screen
Root Cause:Incident date is mismatch due to unable approve ssa.user do not have acces edit date .
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table and inserted a record into routing table..
Data/Code fix ticket#: CJAMS-59756
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The issue was casused by incorrect date , not a problem in the apllication code, so only a data update was needed to correct it.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/



update investigationallegation 
set incidentdate = '2016-07-01 00:00:00.000',isapproximatedate = 1,	updatedby = 'CJAMS-59756',	updatedon = now()
where investigationid = '47286d31-0fcc-48ed-9699-e289fbd37ef3' and activeflag =1;
