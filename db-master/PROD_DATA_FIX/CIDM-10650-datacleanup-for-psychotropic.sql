/*
   Issue Description: CIDM-10650
   Category/ Module  : Psychotropic Medication Review
   Root cause: Few records in db has null objecttypekey
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: yes, CIDM-10650
    Need to do data fix
*/
update psychotropicmedications 
set objecttypekey ='servicecase', 
updatedby = 'CIDM-10650' ,
updatedon =now() 
where objecttypekey is null;