/*
   Issue Description: CDM-34502
   Category/ Module  : Routing   
   Root cause: Due to secuirtyuserdid issue and global code fix done
   Fix Provided: Did data fix to remove the record 
*/

update cjams.routing set activeflag  =0,
updatedby  ='CDM-34502', updatedon  = now()
where routingid  ='cafe5ec0-aa84-4db4-aea7-a04ce57f4b18';