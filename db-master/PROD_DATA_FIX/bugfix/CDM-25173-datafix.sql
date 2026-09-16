/*
   Issue Description: CDM-25173
   Category/ Module  : Persons missing in persons tab (Intake)
   Root cause: user wants to add persons (children) 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/
select 	* 
from 	intakeservicerequestactor 
where 	intakeserviceid = 'ee4cd897-888e-4d0f-981d-38dd9645a99d' 
		and intakeservicerequestactorid in ('1c300f7f-923e-4be1-a37d-07519cdf6669', 'bd675fc9-e762-40a5-9988-da472d441037', 'b50b2a61-d1d8-4f61-92b0-aa623bec74f1');
	
update 	intakeservicerequestactor
set 	intakenumber = 'I221010308293', 
		isprimary = true, 
		updatedby = 'CDM-25173', 
		updatedon = now()
where 	intakeserviceid = 'ee4cd897-888e-4d0f-981d-38dd9645a99d' 
		and intakeservicerequestactorid in ('1c300f7f-923e-4be1-a37d-07519cdf6669', 'bd675fc9-e762-40a5-9988-da472d441037', 'b50b2a61-d1d8-4f61-92b0-aa623bec74f1');
