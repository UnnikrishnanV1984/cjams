/*
   Issue Description: CDM-44142
   Category/ Module  : Pending Approval
   Root cause: user requeseted to remove pending approvals. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update routing set activeflag = '0', updatedon = now(), updatedby = 'CDM-44142'
where objectid = '02c8c148-732d-4a3d-8876-ff09eb4f5891'
and routingid ='eed21376-9d46-4f1f-864a-4e1acb9e00fd' and activeflag = 1;