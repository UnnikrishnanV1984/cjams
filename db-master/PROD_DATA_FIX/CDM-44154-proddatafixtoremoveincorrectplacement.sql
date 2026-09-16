/*
   Issue Description: CDM-44154
   Category/ Module  : Prod data fix to Remove pending placement
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




update placement set activeflag = 0 , updatedby = 'CDM-44154', updatedon = now()
where placementid in ('f62fa4bf-1590-4e19-b8e4-ea84639a7a00', '3b6a017c-8544-47ef-be0f-a1a24cce94bb') and activeflag =1;

update placementrevision set activeflag = 0 , updatedby = 'CDM-44154', updatedon = now()
where placementid in ('f62fa4bf-1590-4e19-b8e4-ea84639a7a00', '3b6a017c-8544-47ef-be0f-a1a24cce94bb') and activeflag =1;

update routing set activeflag = 0 , updatedby = 'CDM-44154', updatedon = now()
where objectid in ('f62fa4bf-1590-4e19-b8e4-ea84639a7a00', '3b6a017c-8544-47ef-be0f-a1a24cce94bb') and activeflag =1;