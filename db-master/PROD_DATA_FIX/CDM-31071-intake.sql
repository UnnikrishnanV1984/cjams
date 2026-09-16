
/*
   Issue Description: CDM-31071
   Category/ Module  : Intake 
   Root cause:  
   Pull request# for code fix: 8838
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Data fix is required.
*/


--Checked with QA with new cases same senario those are working good only 
--so updated this record as per QA comments 

update cjams.routing set eventcode ='INTR', routingstatustypeid =2, activeflag =1, updatedon ='2023-03-09 10:39:01'
where objectid ='I231010518893';
