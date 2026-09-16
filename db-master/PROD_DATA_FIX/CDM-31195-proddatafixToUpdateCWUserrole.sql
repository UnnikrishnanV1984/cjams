/*
   Issue Description: CDM-31244
   Category/ Module  : Prod data fix to update correct IVE Role Mapping
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

--CWCW
update teammember set roletypekey = 'CWIW', updatedby = 'CDM-31195', updatedon = now()
where teammemberid = '3559cfa4-10a2-40be-b437-407fca543b84';


--71
update rolemapping set roleid = 41, updatedby = 'CDM-31195', updatedon = now()
where id = 103362787;
