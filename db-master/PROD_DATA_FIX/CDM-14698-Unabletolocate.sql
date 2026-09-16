/*
 Issue Description:CDM-14698
 Category/ Module: user remove
 Root cause: user couldnt delete
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update routing set activeflag=0,updatedby='CDM-14698',updatedon=now() where routingid='75738c23-147e-4566-8d21-bc400b651f30';