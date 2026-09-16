/*
   Issue Description: CDM-24833
   Category/ Module  : duplicate personprograms 
   Root cause: user wants to remove the duplicate person programs
   Pull request# for code fix: 5461
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM_24843', updatedon = now()
where intakeservreqchildremovalid = '4cf27f0c-db70-4195-a1b3-466ed67382e9' and activeflag = 1;


