/*
   Issue Description: CDM-15386
   Category/ Module  :  Living Arrangement 
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update placement
set updatedby = 'CDM-15386', updatedon = now(), activeflag = 0
where placementid = 'f048a8cb-3914-4f80-b7cd-5d01e463c829';
