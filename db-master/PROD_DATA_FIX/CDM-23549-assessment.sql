
/*
   Issue Description: CDM-23549
   Category/ Module  : Assessments 
   Root cause: user requeseted 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update cjams.routing set activeflag  =0, updatedby ='CDM-23549', updatedon =now()

where routingid in ('a3049615-f9af-47f6-9054-faadfcaf6cc1','74e4b10c-82a2-4018-99b9-2abbf2f04f47');


update cjams.assessment  set activeflag =0

where assessmentid in('4a432c1f-1a45-43e6-953c-346aad321b76','a83be57b-db40-41e2-90fb-2a1ff18b294d');