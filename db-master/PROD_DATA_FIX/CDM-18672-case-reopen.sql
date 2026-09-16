/*
   Issue Description: CDM-18672
   Category/ Module  :  Reopen service case
   Root cause: user asked to reopen service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


UPDATE servicecase 
	SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-18672',updatedon = now() 
	WHERE servicecaseid = 'ebe2a621-ed83-4c23-b7ef-87f0f3db12d9';

	update servicecasedisposition 
	set activeflag = 0, updatedby = 'CDM-18672',updatedon = now() 
	where servicecasedispositionid = '85ee15a0-0c65-47d5-b2b8-dfb6046eb1ad';

	update personprogramarea set enddate = null, updatedby = 'CDM-18672', updatedon = now() 
	where personprogramid in ('72d6e6d4-c296-4e70-9716-72d700585bea');
