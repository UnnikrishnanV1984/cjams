/*
 Issue Description:CDM-19328
 Category/ Module:approved assessment
 Root cause: migrated record
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
 
 
update cjams.routing
set activeflag = 0, updatedby = 'CDM-19328', updatedon = now() 
where eventcode = 'ASST' 
AND objectid IN ('cec4caee-1b17-42f7-90c4-d844eba18897') 
AND servicerequestnumber IN ('3299616');