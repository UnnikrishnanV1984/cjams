
/*
   Issue Description: CDM-28966
   Category/ Module  :Person Module
   Pull request# for code fix: Remove duplicate person 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update cjams.intakeservicerequestactor 
set activeflag = 0, updatedby = 'CDM-28966', updatedon = now()
where intakeservicerequestactorid in('70d7387b-a5db-46a2-850e-4af108432650')and personid ='e0f2c7a9-ff56-4361-a840-8733248aee96';


update actor set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28966'
where actorid = '4fd7fa35-b01e-4887-a83d-b57f3259f55b';