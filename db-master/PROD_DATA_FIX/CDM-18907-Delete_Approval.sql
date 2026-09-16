/*
 Issue Description:CDM-18907
 Category/ Module: Removal Approval
 Root cause: Removed the record
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update routing set activeflag=0,updatedon=now(),updatedby='CDM-18907' where objectid='b4ee12c6-09fd-4f20-b3b1-1697f536ec37' and routingid='7d96d513-edd3-4cca-ab46-9bf500773a01';