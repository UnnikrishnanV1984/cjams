
/*
   Issue Description: CDM-32424
   Category/ Module  : servicecase 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

select * from createservicecase('de6e64f3-c280-4e93-b9e0-f7b3aa55acaa', null,1,'3a6c20ab-c946-4c9b-a2b6-5f9b82cf1069','intake');

update servicecase
set startdate = '2023-06-20 15:37:00', insertedon ='2023-06-20 15:37:00'
where servicecaseid = ( select servicecaseid
                            from intakeservicerequest
                        where intakeserviceid  ='de6e64f3-c280-4e93-b9e0-f7b3aa55acaa'
                     );
                     
update servicecasedisposition                     
set statusdate = '2023-06-20 15:37:00'
where servicecaseid = ( select servicecaseid
                            from intakeservicerequest
                        where intakeserviceid  ='de6e64f3-c280-4e93-b9e0-f7b3aa55acaa'
                     );