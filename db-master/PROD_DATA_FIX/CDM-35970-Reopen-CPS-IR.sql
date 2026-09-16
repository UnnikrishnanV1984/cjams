/*
   Issue Description: CDM-35970
   Category/ Module  : Case Reopen
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed and changed status to screenout
*/

update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', 
updatedon= now(), updatedby='CDM-35970'
where intakeserviceid = 'bb34519e-a8cf-4ca9-a777-5a0fbfed5bd3';


UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =0, 
updatedby = 'CDM-35970',
updatedon = now() 
WHERE 
intakeservicerequestdispositioncodeid = '0566139e-65b9-4a5e-817d-789688baeae0';


update caseassignment set enddate = null, updatedby = 'CDM-35970',
updatedon = now() where caseassignmentid ='70ed1ec9-c413-4fb2-8714-1dec7542a97a';

update
	personprogramarea
set
	activeflag = 0,
	updatedby = 'CDM-35970',
	updatedon = now()
where
	personprogramid in ('0e6f83ed-d38b-4087-bb76-c5748abc7405','16d1e024-a50d-4b5b-b9fd-94e77738b4d5','8dbd7eeb-a4e0-4660-880d-eaeadecc7533','913283fb-0210-4d65-bc57-a834908ceff9')
	and activeflag = 1;