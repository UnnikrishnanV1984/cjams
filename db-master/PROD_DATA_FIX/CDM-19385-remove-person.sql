/*
   Issue Description: CDM-19385
   Category/ Module  : remove person
   Root cause: user wants to remove person other
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
select * from intakeservicerequestactor where personid='b1327612-74a7-437c-9db5-77112e3c6331' 
and intakeservicerequestactorid in ('f4311b17-306c-41fb-9b2b-8d8d18d16ae2');

update intakeservicerequestactor set activeflag =0, updatedby='CDM-19385', 
updatedon=now() where intakeservicerequestactorid in ('f4311b17-306c-41fb-9b2b-8d8d18d16ae2');

select * from actor where personid='b1327612-74a7-437c-9db5-77112e3c6331';

update actor set activeflag =0, updatedby='CDM-19385', updatedon=now() 
where actorid in ('1fd28f3c-6849-4c11-8d73-651f9363ed04');