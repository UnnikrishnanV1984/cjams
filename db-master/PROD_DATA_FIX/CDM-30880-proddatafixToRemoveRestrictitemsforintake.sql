/*
   Issue Description: CDM-30880
   Category/ Module  : Prod data fix to update correct IVE Role Mapping
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update restricteditems set activeflag = 0, updatedby = 'CDM-30880', updatedon = now()
where objectid = 'I231010586176' and activeflag =1;