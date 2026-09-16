/*
   Issue Description: CDM-24919
   Category/ Module  :  User not able to add/edit Court Info
   Root cause: User teamtypekey is IV-E, it needs to be 'CW'
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update  userprofile
set     teamtypekey = 'CW',
        updatedby = 'CDM-24919',
        updatedon = now()
where   securityusersid = '642d8fd5-5615-4464-acbf-70c283c190df' and activeflag=1;
