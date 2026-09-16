/*
Issue Description: Unable to extend the agreement end date. Alert message received. Client ID 3170594. Agreement end date should be Agreement End Date : 1/12/2028
Category/Module: Payments
Root cause: This provider was having incorrect SSN and so these two payments went on hold status. The  provider’s SSN was fixed with datafix ticket CJAMS-60137 from the provider module side. However, the fix to release these specific payments was not included in that datafix.
Fix Provided: Datafix has been promoted to release those specific payments on hold.
Regression Impacts: N/A
Is Code fix Required?: No
Reason why no related code fix: The datafix to release the payments was missed in prior data fix CJAMS-60137.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
select * from cjams.sp_release_payments(5007388::bigint) ;
