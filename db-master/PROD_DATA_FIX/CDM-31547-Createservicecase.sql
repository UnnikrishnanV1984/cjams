
/*
   Issue Description: CDM-31547
   Category/ Module  : servicecase 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

select * from createservicecase('b432f5c0-d706-423d-8678-5727213c9ce3', null,1,'1fb9ce5b-34ae-4bd9-8622-af58330109b6','intake');

update servicecase
set startdate = '2023-05-22 12:30:00', insertedon ='2023-05-22 12:30:00'
where servicecaseid = ( select servicecaseid
                            from intakeservicerequest
                        where intakeserviceid  ='b432f5c0-d706-423d-8678-5727213c9ce3'
                     );
                     
update servicecasedisposition                     
set statusdate = '2023-05-22 12:30:00'
where servicecaseid = ( select servicecaseid
                            from intakeservicerequest
                        where intakeserviceid  ='b432f5c0-d706-423d-8678-5727213c9ce3'
                     );