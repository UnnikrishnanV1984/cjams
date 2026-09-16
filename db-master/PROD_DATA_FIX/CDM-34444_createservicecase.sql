
/*
   Issue Description: CDM-34444
   Category/ Module  : servicecase 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

select * from createservicecase('e0112157-dd2e-4e7e-b4ce-e82702d27e2f', null,1,'9d425628-e466-4839-a395-68b2c2ec320c','intake');

update servicecase
set startdate = '2023-09-07 09:33:00', insertedon ='2023-09-07 09:33:00'
where servicecaseid = ( select servicecaseid
                            from intakeservicerequest
                        where intakeserviceid  ='e0112157-dd2e-4e7e-b4ce-e82702d27e2f'
                     );
                     
update servicecasedisposition                     
set statusdate = '2023-09-07 09:33:00', effectivedate = '2023-09-07 09:33:00'
where servicecaseid = ( select servicecaseid
                            from intakeservicerequest
                        where intakeserviceid  ='e0112157-dd2e-4e7e-b4ce-e82702d27e2f'
                     );