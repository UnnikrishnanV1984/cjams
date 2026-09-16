	
    /*
  Issue Description:  CDM-24783
   Category/ Module  :  Assessment
   Root cause: wrongly created
   Pull request# for code fix: 
   Reason why no related code fix: user requested 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
*/
--ef648b5c-8d50-4a75-a3ea-1e0b91823847 -- updatedby
--2022-08-30 15:53:05 -- updatedon 

update cjams.assessment set activeflag =0, updatedby='CDM-24783', updatedon= now() where assessmentid ='2f3d9e40-cb98-4cbd-8438-3b4c745ce8cd';
