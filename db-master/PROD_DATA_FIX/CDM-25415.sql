/*
   Issue Description: CDM-25415
   Category/ Module  : Prod data fix to remove the permanency plan end date
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update permanencyplan set enddate = null, updatedon = now(), updatedby = 'CDM-25415' 
where permanencyplanid in ('6152dc09-0efa-4e94-9eaa-145374c06001','b9ac853a-12b3-4977-b052-358524c30e27','f5e43aae-15e8-44ea-ad3d-bdbf21e78487'
,'851e9112-e885-4830-8976-3fd73aca4a1f','10825ce1-c377-40bf-a731-31c898a3401a');