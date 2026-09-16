/*
   Issue Description: CDM-14360
   Category/ Module  : progressnote table
   Root cause: user wants to remove 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   user entered wrongly so we just removing the wrong record by updating the falg
*/


update progressnote set activeflag = 0, updatedby = 'CDM-14360', updatedon = now() where progressnoteid = '166b1191-f95e-4554-a9a4-797ca05ad3d3';