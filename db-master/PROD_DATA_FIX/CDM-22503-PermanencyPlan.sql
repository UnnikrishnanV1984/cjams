/*
   Issue Description: CDM-22503
   Category/ Module  : Permamnency plan
   Root cause: user was not able to save data when the approved button is clicked
   Pull request# for code fix: 5745
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update permanencyplan 
set intakeservicerequestactorid = 'f05e69a2-f8e5-4991-b155-803611de173b', updatedby = 'CDM-22503', updatedon = now()
where permanencyplanid = '9491f58d-7858-409c-b9e1-a78e9587056f';
	