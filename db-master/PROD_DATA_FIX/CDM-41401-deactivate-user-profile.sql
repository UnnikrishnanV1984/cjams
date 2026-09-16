/* 
   Issue Description: CDM-41401 FSD previous staff removal (CJAMS/Sailpoint) (DAM ticket)
   Category/ Module  : user management
   Root cause: Data fix needed to Offboarding list below for FSD Sailpoint role/account removal of previous staff.
            1)Karla Gonzalez -left Family Services Division employment as of 10/5/2021
            2)Kaitlin McAuliffe- left Family Services Division employment as of 10/30/2023
   Fix Provided : Data fix has been provided Deactive the users from user profile related tables.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update userprofile 
set activeflag=0,updatedon=now(), updatedby = 'CDM-41401'
where securityusersid in ('bda3f50c-0afa-4185-a2f5-a51e832c0063','08679475-416c-4b26-8880-9104ac839296');

update muser 
set activeflag=0,updatedon=now(), updatedby = 'CDM-41401'
where securityusersid in ('bda3f50c-0afa-4185-a2f5-a51e832c0063','08679475-416c-4b26-8880-9104ac839296');

update rolemapping
set activeflag = 0, updatedby = 'CDM-41401', updatedon = now() 
where principalid in ('13493','14896') and activeflag = 1;

update userresource
set activeflag = 0, updatedby = 'CDM-41401', updatedon = now() 
where userid in (13493,14896) and activeflag = 1;

update teammemberassignment 
set activeflag=0,updatedon=now(), updatedby = 'CDM-41401'
where securityusersid in ('bda3f50c-0afa-4185-a2f5-a51e832c0063','08679475-416c-4b26-8880-9104ac839296');

update securityusers 
set activeflag=0,updatedon=now(), updatedby = 'CDM-41401'
where securityusersid in ('bda3f50c-0afa-4185-a2f5-a51e832c0063','08679475-416c-4b26-8880-9104ac839296');

update teammember set activeflag = 0, updatedby = 'CDM-41401', updatedon = now()
where teammemberid in ('e83c7ff1-118f-49ea-ac39-57970004f8a7','ab7bf7d7-f38a-4126-8b47-63d898f864f9') and activeflag = 1;
