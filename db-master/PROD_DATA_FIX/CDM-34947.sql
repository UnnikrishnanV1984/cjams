/*
   Issue Description: CDM-34947
   Category/ Module  : Routing   
   Root cause: Due to secuirtyuserdid issue and global code fix done
   Fix Provided: Did data fix to remove the record 
*/


update cjams.routing set activeflag  =0,
updatedby  ='CDM-34947', updatedon  = now()
where routingid  in ('d5886cbb-2cec-46c5-9f42-8f911099bb02','31a2e258-6bc5-49a1-8042-6c05ca7524b2');