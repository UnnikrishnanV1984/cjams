/*
   Issue Description: CDM-44073
   Category/ Module  : Pending Approval
   Root cause: user requeseted to remove pending approvals. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update routing set activeflag = '0', updatedon = now(), updatedby = 'CDM-44073'
where objectid = '50180bd6-61d1-4cb0-b8c6-5ee9987eddaa'
and routingid in ('c89a78a1-a870-4e39-9355-8eeed5455b3b','b5f2f755-9c59-4eb6-b23a-14a3bf4fd6de') and activeflag = 1;
