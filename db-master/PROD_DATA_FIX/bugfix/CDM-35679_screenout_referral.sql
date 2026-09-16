/*
   Issue Description: CDM-35679
   Category/ Module  : recover an intake to pending
   Root cause: User is not able to see an intake and requested to recover it where user should be able to send the decision screen-in/screen-out
   Fix Provided: 
*/

select * from routing where objectid ='I231011447482';

select eventcode, activeflag,* from routing where objectid in('I231011447482');

update cjams.routing 
set eventcode ='INTR', activeflag =1, updatedby = 'CDM-35679', updatedon = now()
where routingid ='713c2ba8-a1ae-4efc-b9b4-fc8d429265e7' and objectid = 'I231011447482' and activeflag = 0;