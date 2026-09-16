
/*
   Issue Description: CDM-19397
   Category/ Module  : Reverting Gap Agreement Record
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update gapagreementrate set activeflag = 0, updatedby = 'CDM-19397', updatedon = now() where gapagreementrateid = 'd05c86a3-86b7-4685-92aa-cb0ad0a98045' and activeflag = 1;
update gapratesrevision set activeflag = 0,approvaldate = now()::date ,transactiondate = now()::date, updatedby = 'CDM-19397', updatedon = now() where gaprateid = 'd05c86a3-86b7-4685-92aa-cb0ad0a98045' and activeflag = 1;
