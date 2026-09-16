/*
   Issue Description: CDM-30648
   Category/ Module  : Investigation Findings
   Root cause: user requested to remove the duplicate findings 
   Pull request# for code fix: 8783
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Data fix is required.
*/

update Investigationmaltreatment 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-30648' 
where maltreatmentid = '3bb49b70-8f79-4375-8520-d4c44df2be9a';