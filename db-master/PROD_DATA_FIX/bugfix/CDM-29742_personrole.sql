/*
   Issue Description: CDM-29742
   Category/ Module  : Person Profile
   Root cause: Duplicate records in person role
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.personrole
set activeflag = 0, updatedon = now(), updatedby = 'CDM-29742'
where personroleid in ('bb125946-0a28-40ab-819d-d0010c18f796','d5672fd6-e208-4bae-abcd-905121e45719');

