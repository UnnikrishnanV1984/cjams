/*
   Issue Description: CDM-17003
   Category/ Module  :  contacts removal
   Root cause: User asked to remove contatcs
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update progressnote p set activeflag = 0, updatedon = now(), updatedby = 'CDM-17003' 
    where progressnoteid = '20d8c2d8-da4c-494d-8358-1d529b08ca33' and activeflag = 1;