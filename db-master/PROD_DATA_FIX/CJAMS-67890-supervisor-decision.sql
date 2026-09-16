/*
   Issue Description: CJAMS-67890
   Category/ Module  : Update Supervisor Decision
   Root cause: Supervisor wants to screenin
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakedastatus 
set status =1, ispreintake=true, updatedby ='CJAMS-67890', updatedon =now()
where intakenumber ='I261013947397' and activeflag =1;

update routing
set activeflag =1, updatedby ='CJAMS-67890', updatedon =now()
where objectid ='I261013947397' and routingid ='9f1542e5-da45-4ae7-ae07-c7811d88765f';
