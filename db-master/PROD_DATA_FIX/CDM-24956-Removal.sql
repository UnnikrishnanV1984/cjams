
/*
   Issue Description:CDM-24956
   Category/ Module  :  Child Removal 
   Root cause: user asked to remove the extra record 
   Pull request# for code fix: 
   Reason why no related code fix: 
*/


---There is no placement for this removalid 

update cjams.intakeservreqchildremoval set activeflag=0, updatedby='CDM-24956', updatedon=now()

where intakeservreqchildremovalid='4853907f-2a43-4101-a46f-f2ab6f5457cf';