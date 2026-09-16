/*
   Issue Description: CDM-25413
   Category/ Module  : Placement history  
   Root cause: User requested to remove records
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update placement p set activeflag  = 0, updatedby = 'CDM-25413', updatedon = now() where placementid = 'd81c3b91-f43e-49e6-8412-dfa7192e3d4a' and activeflag = 1;

update placement p set activeflag  = 0,updatedby = 'CDM-25413', updatedon = now() where placementid = '6375656f-ea44-48dd-8400-a0db0288bd34' and activeflag = 1;
