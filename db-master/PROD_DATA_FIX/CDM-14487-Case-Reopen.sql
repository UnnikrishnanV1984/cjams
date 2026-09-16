/*
   Issue Description: CDM-14487
   Category/ Module : investigation findings
   Root cause: user wants to reopen the case 
   Pull request# for code fix: 7423
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed. Need to do data fix
*/
update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= NOW(), updatedby='CDM-14487'
where intakeserviceid = 'a757cd45-b92b-44f2-a104-8392b9cdde50';
