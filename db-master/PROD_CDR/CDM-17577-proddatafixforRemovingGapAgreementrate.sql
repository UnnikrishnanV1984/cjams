
/*
   Issue Description: CDM-17577
   Category/ Module  : Removing Gap agreement rate records
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-17577',
	updatedon = now()
where gapagreementrateid in ('d5c2f691-dcf0-418a-8138-c9d7babf73cd',
'fa119fb4-ab94-49af-b78f-9bc098a4f5f1','7fae97d6-7ca1-413b-acc0-ddab2a6dd4fe',
'99ee18f9-5593-4c65-ade8-cabc94d7e839','b893f08c-24e4-435c-bd90-0789c2115f2e')
and activeflag = 1 ;