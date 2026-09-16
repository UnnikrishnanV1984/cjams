/*
   Issue Description: CDM-23458
   Category/ Module  : Prod data fix to case connect
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


select * from createservicecase('f0fc7bdb-898f-4c48-877e-90e7a4c2109e', '0b008b36-f79f-4631-9d6e-e285319c5134', 0, 'c4d0b6a8-99c0-4d7e-b6ff-859618c9d4ae') ;

-- Deleting Newly created case
update servicecase set activeflag = 0, updatedby = 'CDM-23458', updatedon = now()
where servicecaseid = '624e4411-74d8-45a1-a366-dca54b8a0676';