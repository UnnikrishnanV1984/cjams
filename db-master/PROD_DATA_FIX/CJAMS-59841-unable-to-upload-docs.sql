/*
  Issue Description: CJAMS-59841 Supervisor Role
  User is not given the supervisor role yet and the upload button will be available once the role is added.
   Category/ Module  :  user management
   Root cause: User is having only CJAMS_CWCASEWORKER(71) role not the CJAMS_CWSUPERVISOR (36)role
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: roleid= 71 , roletypekey = 'CWCW' 
*/
-- email:sonia.allen@maryland.gov userid: 7529
--select * from teammemberassignment where securityusersid = '0b165786-bd73-4a5d-9e0b-56a7cd7ef557';-- teammember id: 7d5fbd55-93d3-4f76-8b47-45fdc14b3b6b

update rolemapping 
	set roleid =36, 
	updatedby ='CJAMS-59841', 
	updatedon = now() 
where principalid = '7529' 
	and id =167843530; 

update teammember 
	set roletypekey = 'CWSP', 
	description='Supervisor,CW' , 
	updatedby ='CJAMS-59841' , 
	updatedon = now() 
where teammemberid = '7d5fbd55-93d3-4f76-8b47-45fdc14b3b6b'
	and activeflag=1;
