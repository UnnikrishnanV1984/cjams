/*
   Issue Description: CDM-20047
   Category/ Module  : CPS Case assignments 
   Root cause: user wants to remove cps case assignments 
   Pull request# for code fix: 4780
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update personprogramarea set activeflag = 0, updatedby = 'CDM-20047', updatedon = now()
where personprogramid in ('5be6067a-4e33-4774-8b37-f57ded00fb5c', 'd12c6797-2a9e-443d-a360-61dc98225b72', 
'5ec50cca-23f5-4ee4-bf0b-e83ba27d6c31', '7a2f6639-0771-45fc-aa7b-5297b6f030b6');