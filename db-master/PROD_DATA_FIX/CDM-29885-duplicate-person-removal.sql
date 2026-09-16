/*
   Issue Description: CDM-29885
   Category/ Module  : Person Profile
   Root cause: Duplicate records in person role
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update personrole 
set activeflag = 0, 
updatedby ='CDM-29885', 
updatedon = now()
where personroleid = '6dab2be2-c969-4e83-a402-776963844a09';