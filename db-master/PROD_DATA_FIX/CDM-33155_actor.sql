/*
   Issue Description: CDM-33155
   Category/ Module  :Permanency plan person actorid
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cjams.intakeservicerequestactor 
set isprimary = true, updatedby = 'CDM-33155', updatedon = now()
where intakeservicerequestactorid = '30a24208-f642-47f9-a4ae-eef2eb87caf5' and personid = '4d857c6e-0ede-4cc8-9c8b-af6cebd9f863';

update cjams.intakeservicerequestactor 
set isprimary = false, updatedby = 'CDM-33155' , updatedon = now()
where intakeservicerequestactorid = '5eb8cee0-3bdb-40d5-b979-688ac4cefc66' and personid = '4d857c6e-0ede-4cc8-9c8b-af6cebd9f863';
