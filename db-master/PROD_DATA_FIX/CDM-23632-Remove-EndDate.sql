/*
   Issue Description: CDM-23632
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to remove end date and placement 
   Pull request# for code fix: 5821
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
	
update intakeservreqchildremoval set exitdate = null, updatedby = 'CDM-23632', updatedon = now() 
where intakeservreqchildremovalid = '244c48b7-e6d3-40c7-a337-1a9d12a699ae';

update personprogramarea set enddate = null, updatedby = 'CDM-23632', updatedon = now() 
where personprogramid = 'df5aa2cf-ea84-4da5-8d91-addce9c9dddb';