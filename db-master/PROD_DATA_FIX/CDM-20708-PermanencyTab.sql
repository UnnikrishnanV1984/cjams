/*
   Issue Description: CDM-20708
   Category/ Module  : permanency plan
   Root cause: user wants to remove plan changes 
   Pull request# for code fix: 5025
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update permanencyplan set intakeservicerequestactorid = 'fb1eac6a-159e-432c-a8c8-5e3cd4301c12', updatedby = 'CDM-20708', updatedon = now()
where permanencyplanid = 'a2aea5f3-016e-4c7a-ba5f-0cf957ce7a99';

update permanencyplan set activeflag = 0, updatedby = 'CDM-20708', updatedon = now()
where permanencyplanid = '015c49ce-f9ad-44c4-ba55-fbf6501823d9';