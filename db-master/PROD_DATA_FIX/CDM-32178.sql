	
/*
   Issue Description: CDM-32178
   Category/ Module  :personprogramarea
   Root cause: 
   Pull request# for code fix: 5821
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/


	update cjams.personprogramarea set enddate = null,endreasonkey= null,  updatedon = now(), updatedby ='CDM-32178'
	where personprogramid ='52bc363f-8518-446f-83c1-6598a5e490da';