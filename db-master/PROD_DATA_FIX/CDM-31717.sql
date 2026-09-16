/*
   Issue Description: CDM-31717
   Category/ Module  :
   Root cause: user want to change yes for "Was this child an active member of the household at the start of the case but not included on the referral?*"
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update personrole set initialresponse=1,updatedby='CDM-31717',updatedon=now() where personroleid='7f7cd7b9-e0de-407d-be5a-9bb81c68ffd4';
