/*
 Issue Description:CDM-17841
 Category/ Module: unable to locate
 Root cause: userwants to remove the record
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update routing set activeflag=0,updatedby='CDM-17841',updatedon=now() where routingid='d85032a2-1ef9-4d26-87d7-b71e6b599557';
