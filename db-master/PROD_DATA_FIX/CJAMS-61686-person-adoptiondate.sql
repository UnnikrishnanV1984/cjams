/*
Issue Description: CJAMS-61686 GAP subsidy rate
Category/Module: GAP
Root cause: Client profile cannot be saved if the previous adoption date is blank.
            Need data fix to update Previous adoption date as 6/30/2005 for Client ID: 1073816.
Fix provided: Data fix has been done to update the previous adoption date
Data/Code fix ticket#: CJAMS-61686
Regression Impacts: N/A
Is Code fix Required?: N/A
Code fix ticket#: N/A
Reason why no related code fix: Known issue with user profile as it cannot be updated without previous adoption date and data fix needed to update it.
*/

update person 
set preadoptiondate ='2005-06-30', 
	updatedby ='CJAMS-61686', 
	updatedon = now()
where personid ='b68d7fba-7743-4325-a6b5-eb84c71bb36e' and activeflag =1;