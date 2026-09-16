/*
 Issue Description:CDM-18200
 Category/ Module: case closure
 Root cause: user wants to remove the case
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update routing set activeflag=0,updatedby='CDM-18200',updatedon=now() where routingid='5322034b-9b76-45fe-9ae2-df62825f5997';