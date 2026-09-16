/*
   Issue Description: CJAMS-63463
   Category/ Module  : Prod data fix to remove living arrangement
   Root cause:  
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/





update placement set activeflag = 0, updatedby = 'CJAMS-63463', updatedon = now()
where placementid = '54cc1709-96b8-4cb3-968e-31bb3d6ab814';

update livingarrangement set activeflag = 0, updatedby = 'CJAMS-63463', updatedon = now()
where placementid = '54cc1709-96b8-4cb3-968e-31bb3d6ab814';

update placementrevision 
set activeflag = 0, updatedby = 'CJAMS-63463', updatedon = now()  
where placementid = '54cc1709-96b8-4cb3-968e-31bb3d6ab814'
 and activeflag = 1;

