/*
   Issue Description: CJAMS-64087
   Category/ Module  : Prod data fix to update is provider involved
   Root cause:  
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/





update investigationallegation set isproviderinvolved = 1, updatedby = 'CJAMS-64087', updatedon = now()
where  maltreatmentid = '8c0e6a20-bf68-4760-a30a-d82161cae44f';