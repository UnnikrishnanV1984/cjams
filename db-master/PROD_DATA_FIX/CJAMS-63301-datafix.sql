/*
Issue Description: CJAMS-63301
Category/Module: GAP
Root cause: User requested to update Previous Adoption Date as 7/17/2014 for Client ID: 3683991 (James White)
Fix provided: Data fix to update Previous Adoption Date as 7/17/2014 for Client ID: 3683991 (James White)
    Adoption Case# : 3241540
    Agreement Start Date: 7/17/2014
Data/Code fix ticket#: CJAMS-63301
Regression Impacts: N/A
Is Code fix Required?: N/A
Code fix ticket#: N/A
Reason why no related code fix: Known issue with user profile as it cannot be updated without previous adoption date and data fix needed to update it.
*/

update person 
set preadoptiondate ='2014-07-17', 
	updatedby ='CJAMS-63301', 
	updatedon = now()
where personid ='ed870501-4298-4032-b131-d147acca7cb7' 
 and activeflag =1;