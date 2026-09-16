
/*
   Issue Description: CDM-18156
   Category/ Module  : Pending Request assigning it to default supervisor
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- ffaff6c5-0784-47e8-b29e-a04373e6cc89
update routing set tosecurityusersid = '9a1c8c5c-cc81-4c3f-8c25-65089b46afca', updatedby = 'CDM-18156', updatedon = now() where routingid = 'ebc0a257-c660-437a-9c90-fec7db4029dd';
 