
/*
   Issue Description: CDM-18193
   Category/ Module  : Removing Gap agreement rate records
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-18193',
	updatedon = now()
where gapagreementrateid in ('0c5c12cc-9b89-4fed-9537-2eb8c2d8b9bb')
and activeflag = 1 ;