/*
Root Cause: User requested to update the provider involved maltreator as Yes in Maltreatment Allegations tab.
Fix Provided (Data Fix Only): Data fix is done by updating the provider involved maltreator as Yes at case level.
Data/Code fix ticket#: CJAMS-66844
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: this was a one time data correction specific  to a single referral.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update investigationallegation
set isproviderinvolved =1, updatedby ='CJAMS-66844', updatedon =now()
where investigationallegationid='92fc628f-5e4a-4c85-8462-437094c2f910';