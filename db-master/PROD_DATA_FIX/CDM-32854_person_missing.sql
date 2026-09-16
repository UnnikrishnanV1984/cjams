/*
   Issue Description: Person Missing from CPS and intake after new role added in service case
   Category/ Module  : Person 
   Fix Provided: Did data fix to pull back the given person 
   Pull request# for code fix: Code fix has been done as part CIDM-7358
*/		
        
update intakeservicerequestactor set 
updatedby = 'CDM-32854', updatedon = now(), isprimary ='true' 
where intakeservicerequestactorid = 'dbe63e36-2b9b-4174-b654-b38f9b209953'
and personid = 'dc439618-090d-4fa3-8c65-f9041fce8066';

update intakeservicerequestactor set 
updatedby = 'CDM-32854', updatedon = now(), isprimary ='false' 
where intakeservicerequestactorid = 'b49dc9a5-3119-4a7e-9924-1f77e7526cec'
and personid = 'dc439618-090d-4fa3-8c65-f9041fce8066';
		