/*
   Issue Description: CDM-23832
   Category/ Module  : Removing role - Initial Contact Caregiver to Person
   Root cause: Removing role since it has two
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-23832', updatedon = now() where intakeservicerequestactorid = '7fd32c15-3595-489a-ba8c-cc7638b267f9';