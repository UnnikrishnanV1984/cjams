/*
   Issue Description: CDM-28267
   Category/ Module  :Placement Must be Voided
   Root cause: :3306148:Most recent placement at Mother's Home needs to be voided.
   Reason why no related code fix:  Data fix

   
*/


update placement set activeflag = 0, updatedby = 'CDM-28267', updatedon = now() where placementid = '0617a58c-c01f-4410-8153-584ccb412085';
update placementrevision set activeflag = 0, updatedby = 'CDM-28267', updatedon = now() where placementid = '0617a58c-c01f-4410-8153-584ccb412085' and activeflag = 1;
update livingarrangement set activeflag = 0, updatedby = 'CDM-28267', updatedon = now() where placementid = '0617a58c-c01f-4410-8153-584ccb412085' and activeflag = 1;
update routing set activeflag = 0, updatedby = 'CDM-28267', updatedon = now() where objectid = '0617a58c-c01f-4410-8153-584ccb412085' and activeflag = 1;
