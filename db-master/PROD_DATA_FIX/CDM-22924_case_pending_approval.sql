/*
   Issue Description: CDM-22924
   Need to remove the case pending approval which are stuck 
   in supervisor pending approval dashboard. Those four cases have been approved.
*/


update routing 
set activeflag = 0, updatedby = 'CDM-22924', updatedon = now()
where routingid in ('d0be38e4-1a4b-4f8c-b0e2-15174eeb258b','4beae397-b30c-4366-b4b5-35e8bb819efd',
'd6ff7f72-9590-4af0-ab85-57761e7c8b23','e615e8c0-74ba-4ad2-9eb7-fd754e61256e','b19c61a5-6b8f-46f1-b27e-fe67a3beffe6'
);