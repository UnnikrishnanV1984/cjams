
/*
   Issue Description: CDM-29827
   Category/ Module  : Servicecase
   Root cause: user error : User requested to delete this service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.routing set activeflag = 0 
, updatedby ='CDM-29827', updatedon = now()
where routingid in ('52564355-1069-47d6-9959-5a64a047bfdb','240a1bed-5617-45e2-ade5-03b084c1bfd5','4f049402-aad8-4451-a271-369a5e37dac5')
and activeflag = 1;


 

 