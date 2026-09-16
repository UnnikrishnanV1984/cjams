/*
   Issue Description: CJAMS-59485
   Category/ Module  : Person profile
   Root cause: Old record with adoption date missing as it was added with the system enhancement if user selects yes to "Has this child ever been adopted?"
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update cjams.person
set 
    preadoptiondate = '2001-02-21',
    updatedby = 'CJAMS-59485',
    updatedon = now()
where cjamspid = '1712996'
and activeflag =1;