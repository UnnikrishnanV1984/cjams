/*
   Issue Description: CDM-28955
   Category/ Module  : Person Profile
   Root cause: Duplicate records in person
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix 201161797,201161798,201161799,201161801,201161802
*/

update cjams.intakeservicerequestactor
set activeflag = 0, updatedon = now(), updatedby = 'CDM-28955'
where personid ='0f3bde83-b237-4d56-a69e-d8c8df53c3cd';

update cjams.personrole
set activeflag = 0, updatedon = now(), updatedby = 'CDM-28955'
where personid ='0f3bde83-b237-4d56-a69e-d8c8df53c3cd';


update cjams.actor
set activeflag = 0, updatedon = now(), updatedby = 'CDM-28955'
where actorid='121f0206-96bd-467e-a726-238133a6c8bb'
