/*
   Issue Description: CDM-38079
   Category/ Module  : Stuck Approvals
   Root cause: Need to cleaning up the supervisor pending approval dashboard
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag =0, updatedby = 'CDM-38079', updatedon = now() 
where objectid = 'bf7bb0ff-b39f-471b-9252-517f56e9f594' and servicerequestnumber ='3003080' and routingstatustypeid = 15 and activeflag =1;

update routing set activeflag =0, updatedby = 'CDM-38079', updatedon = now() 
where objectid = 'b69ac0c0-ebed-4578-9373-9d32230fb032' and servicerequestnumber ='3215342' and routingstatustypeid = 15 and  activeflag =1;

update routing set activeflag =0, updatedby = 'CDM-38079', updatedon = now() 
where objectid = '6ebae169-1e36-47f1-9dde-ee22a413b6fe' and servicerequestnumber ='3215342' and routingstatustypeid = 15 and activeflag =1;

update routing set activeflag =0, updatedby = 'CDM-38079', updatedon = now() 
where objectid = 'cdd8b536-3df9-4adb-9487-1a0492846f6e' and servicerequestnumber ='3225033'and routingstatustypeid = 15 and activeflag =1;

update routing set activeflag =0, updatedby = 'CDM-38079', updatedon = now() 
where objectid = '28881904-5693-400c-b606-21ccda70bd87' and servicerequestnumber ='3215342' and routingstatustypeid = 15 and activeflag =1;

update routing set activeflag =0, updatedby = 'CDM-38079', updatedon = now() 
where objectid = 'b75bad99-6fe7-49ea-a588-26dc0cb9befc' and servicerequestnumber ='3287558' and routingstatustypeid = 15 and activeflag =1;

update routing set activeflag =0, updatedby = 'CDM-38079', updatedon = now() 
where objectid = 'c59729eb-b037-40cd-b51b-87e5e50f20d0' and servicerequestnumber ='3262105'and routingstatustypeid = 15 and activeflag =1;

update routing set activeflag =0, updatedby = 'CDM-38079', updatedon = now() 
where objectid = '22cfa78b-ef28-4fff-8742-83a709147e8c' and servicerequestnumber ='3240625' and routingstatustypeid = 15 and activeflag =1;