/*
   Issue Description: CDM-35670
   Category/ Module  : recover an intake to pending
   Root cause: User is not able to see an intake and requested to recover it where user should be able to send the decision screen-in/screen-out
   Fix Provided: 
*/

select * from routing where objectid ='I231011471843';

select eventcode, activeflag,* from routing where objectid in('I231011471843');

update cjams.routing 
set eventcode ='INTR', activeflag =1, updatedby = 'CDM-35670', updatedon = now()
where routingid ='659d89d5-a159-4ff2-94f6-14c163e87965' and objectid = 'I231011471843' and activeflag = 0;