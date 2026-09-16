/*
   Issue Description: CDM-34657
   Category/ Module  : Prod data fix to update contact notes type user error
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.progressnote
SET progressnotetypeid='b83d8c25-f7db-4816-87f4-35a657790ad4'::uuid, updatedby='CDM-34657'
WHERE progressnoteid='b3dd9590-b67a-4ea8-b451-4881f3269f9f'::uuid and witsid = 11555361;
