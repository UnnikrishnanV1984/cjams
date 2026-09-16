/*
Issue Description: CJAMS-62410 Add adoption date
Category/Module: Person Profile
Root cause: Unable to add client 1379932 to the case manually to serivecase 3133192.
            Data fix is needed to update the previous adoption date(03/05/1996) for the client 1379932 
Fix provided: Data fix has been done to update the previous adoption date (03/05/1996) for the client 1379932
Data/Code fix ticket#: CJAMS-62410
Regression Impacts: N/A
Is Code fix Required?: N/A
Code fix ticket#: N/A
Reason why no related code fix: Known issue with user profile as it cannot be updated without previous adoption date and data fix needed to update it.
*/

update person 
set preadoptiondate ='1996-03-05', 
	updatedby ='CJAMS-62410',
	updatedon = now()
where personid ='51cb8c81-f431-45bb-ba1a-60f7f5913e8f' and activeflag =1;