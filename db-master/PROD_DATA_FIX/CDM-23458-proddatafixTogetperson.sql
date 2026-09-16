/*
   Issue Description: CDM-23458
   Category/ Module  : Prod data fix to case connect
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- 624e4411-74d8-45a1-a366-dca54b8a0676
update actor set servicecaseid = '0b008b36-f79f-4631-9d6e-e285319c5134', updatedby = 'CDM-23458', updatedon = now()
where actorid = 'd179bc6c-d2a5-4484-87f5-ffddfcdc25e6';