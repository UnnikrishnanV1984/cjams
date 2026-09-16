/*
   Issue Description: CDM-31244
   Category/ Module  : Prod data fix to update correct IVE Role Mapping
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


--1051
update rolemapping set roleid = 147, updatedby = 'CDM-31244', updatedon = now()
where id = 108855221;


update teammember set roletypekey = 'IVELI', updatedby = 'CDM-31244', updatedon = now()
where teammemberid = '1bd4695e-622f-45ea-8ed4-266f9a12b924';