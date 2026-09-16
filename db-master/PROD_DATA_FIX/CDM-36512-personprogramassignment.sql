/*
   Issue Description: CDM-36512
   Category/ Module  :  Program Assignment
   Root cause: user wants to remove ooh end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update personprogramarea set enddate = null, updatedby = 'CDM-36512', updatedon = now() 
where personprogramid in ('2acdd697-69b5-4f40-8a04-b9fb46c9a85c','d41adc3d-7286-432a-b2b4-5e22fb5347bc');