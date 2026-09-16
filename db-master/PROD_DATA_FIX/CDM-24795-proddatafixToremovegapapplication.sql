/*
   Issue Description: CDM-24795
   Category/ Module  : Prod data fix to remove gap application
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update gapapplication set activeflag = 0, updatedby = 'CDM-24795', updatedon= now() 
where gapapplicationid = '15f844ad-49fd-48ac-bb66-7d5616414fcb' and activeflag = 1;