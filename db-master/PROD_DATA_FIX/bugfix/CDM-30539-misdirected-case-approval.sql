 /*  Issue Description: CDM-30539-misdirected-case
   Category/ Module  :  service case
   Root cause: 
   Pull request# for code fix: N/A.
   Reason why no related code fix: N/A.
   Status of the code fix if already submitted and expected prod fix date: N/A 

*/

update routing set activeflag =0 ,
updatedby='CDM-30539', updatedon=now()
where routingid = '9a86db47-d6bf-4cd6-a01c-4de9c43923fc';