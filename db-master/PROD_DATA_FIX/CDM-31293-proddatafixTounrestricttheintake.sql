/*
   Issue Description: CDM-31244
   Category/ Module  : Prod data fix to update correct IVE Role Mapping
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.restricteditems set activeflag = 0, updatedby = 'CDM-31293', updatedon = now()
where objectid = 'I231010600836' and activeflag = 1;
