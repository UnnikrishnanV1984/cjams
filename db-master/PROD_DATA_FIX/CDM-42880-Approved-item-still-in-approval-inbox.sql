/*
   Issue Description: CDM-42280
   Category/ Module  : Approval inbox
   Root cause: User wants to delete from approval inbox
*/

update routing 
set activeflag=0, updatedby='CDM-42880',updatedon=NOW()
where servicerequestnumber='231030198788' and eventcode='YTP' and routingid='a98be03e-52b8-4c7b-9434-616f7893e40b' and activeflag=1;

