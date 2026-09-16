/*
   Issue Description: CDM-17880
   Category/ Module  :  Remove case assignment for that particular case
   Root cause: user asked to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update caseassignment 
	set activeflag=0, updatedby = 'CDM-17880', updatedon = now() 
	where caseassignmentid = '01aa6316-6040-4a69-ba32-74f65e09a466' and activeflag = 1;