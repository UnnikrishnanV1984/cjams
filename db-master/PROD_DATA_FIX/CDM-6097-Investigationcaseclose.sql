
 /*  Issue Description: CDM-6097-Delete
   Category/ Module  :  Deleted the investigation case as user requested.CW2136006,CW2164682
   Root cause: As this case is more than 25 years, user requested to delete the cases.
   Pull request# for code fix: N/A.
   Reason why no related code fix: N/A.
   Status of the code fix if already submitted and expected prod fix date: N/A 

*/
update intakeservicerequest set activeflag=0, updatedby='CDM-6097',updatedon=now() where servicerequestnumber in ('CW2136006','CW2164682') and
intakeserviceid in ('d328bc1f-c4c7-4ee1-a194-28cfab6ff152','2e4250b9-24c5-4719-b183-b996febabb98');
