
/*
   Issue Description: CDM-21408
   Category/ Module  : Removing Pending records
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag = 0, updatedby = 'CDM-21408', updatedon = now() where routingid = '745b2369-5e94-4003-9676-89fb2975df24';
