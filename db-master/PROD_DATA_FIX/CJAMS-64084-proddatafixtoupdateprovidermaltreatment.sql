/*
   Issue Description: CJAMS-64084
   Category/ Module  : Prod data fix to update is provider involved
   Root cause:  
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/





update investigationallegation set isproviderinvolved = 1, updatedby = 'CJAMS-64084', updatedon = now()
where  maltreatmentid = '849dbde5-832a-431c-a2c8-0d2970eb0f7f';