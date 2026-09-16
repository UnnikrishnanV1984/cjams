/*
   Issue Description: CDM-31804
   Category/ Module  :  
   Root cause: user wants change the answer to "Yes" for "Was this child an active member of the household at the start of the case but not included on the referral" 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update personrole set initialresponse=1 ,updatedby='CDM-31804',updatedon=now() where personroleid='57b63f06-8141-4472-bb97-106ffb2003bd';
update personrole set initialresponse=1 ,updatedby='CDM-31804',updatedon=now() where personroleid='f44b7744-fe7c-41bf-827f-8076f16fd626';