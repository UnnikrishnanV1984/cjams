/*
 Issue Description:CDM-18393
 Category/ Module:duplicate removal
 Root cause: duplicate removal
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/


update intakeservreqchildremoval set activeflag =0, updatedby = 'CDM-18770', updatedon = now() where intakeservreqchildremovalid = '41ee2039-cc66-4c62-85f1-a3b39eb8afda';
