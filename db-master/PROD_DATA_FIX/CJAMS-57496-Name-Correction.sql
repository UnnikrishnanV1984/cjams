/*
   Issue Description: CJAMS-57496 Name Correction
   Category/ Module  : Name change/person module
   Root cause: user requeseted to change the firstname. 
   Pull request# for code fix: NA
   Reason why no related code fix: NA 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update
    cjams.person
set
    firstname = 'Jill',
    updatedby = 'CJAMS-57496',
    updatedon = now()
where
    cjamspid = 204070896
    and activeflag = 1;