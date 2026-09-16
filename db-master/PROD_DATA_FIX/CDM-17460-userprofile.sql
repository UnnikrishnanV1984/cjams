/*
  Issue Description: CDM-17460 CJAMS - Worker's PII showing up in the system: Na'ilah Dawjubs
   Category/ Module  :  User management
   Root cause: User asked to updated the phone number
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update cjams.userprofilephonenumber set phonenumber='443-975-9023',updatedby='CDM-17460', updatedon=now() where
securityusersid='32faa66a-516a-4b64-b67b-dc43500d33d5';