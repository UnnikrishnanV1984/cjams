/*
   Issue Description: Person card update
   Category/ Module  : Person 
   Fix Provided: Did data fix to pull back the given person 
   Pull request# for code fix: 
*/		
        
        update intakeservicerequestactor set 
updatedby = 'CDM-32394', updatedon = now(),
isprimary ='true' where intakeservicerequestactorid = '37d64bfd-113e-4b3a-a596-15bb885b95a9'
and actorid = '20ccc5ba-23ce-4e31-9a01-c9f4059067f9';
		