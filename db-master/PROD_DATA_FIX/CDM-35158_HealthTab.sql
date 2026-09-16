-- CDM-35158 - Health Tab update existingcondition
/* Issue Description:User request to update existing condition on health tab # 211030009797

-- Person ID: a2feaf69-1f43-4ae6-a1e8-3d8df8bdc4db

-- Category/ Module: Case Connect (Person Info-Health-disabilty) 

-- Root cause: Unable to update existing condition 
-- Fix Provided: Datafix has been provided to update existing condition on persondisability for a2feaf69-1f43-4ae6-a1e8-3d8df8bdc4db
-- Pull request# N/A

*/
select * from persondisability 
where personid ='a2feaf69-1f43-4ae6-a1e8-3d8df8bdc4db' 
    and disabilityconditiontypekey ='Yes' and activeflag=1;


update persondisability
set existingcondition=true ,
	updatedon = now(), 	
	updatedby = 'CDM-35158'
where personid ='a2feaf69-1f43-4ae6-a1e8-3d8df8bdc4db' 
    and disabilityconditiontypekey ='Yes' and activeflag=1;