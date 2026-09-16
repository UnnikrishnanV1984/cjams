/*
   Issue Description: CDM-30000
   Category/ Module  : Person Profile
   Root cause: Duplicate records in person role
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.personrole
set activeflag = 0, updatedon = now(), updatedby = 'CDM-30000'
where personroleid in ('ae5565ae-b1ce-4630-a06f-b2ae1155e2d5','01fd9410-ae10-409e-8b64-da2989f5ee53',
'd0787ddc-9a12-4a57-a502-5469669201bb','181d1a74-3aba-4948-87e2-4f46b840f787');