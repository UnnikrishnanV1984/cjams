/*
   Issue Description: CDM-28146
   Category/ Module  : child removal 
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update cjams.intakeservreqchildremoval set parent2comments ='Agency were unable to contact father after many attempts.', updatedby='CDM-28146', updatedon =now()

where intakeservreqchildremovalid ='1c62d122-09d1-4066-aa10-009f4d7fb127';


update cjams.intakeservreqchildremoval_history set parent2comments ='Agency were unable to contact father after many attempts.', updatedby='CDM-28146', updatedon =now()

where intakeservreqchildremovalid ='1c62d122-09d1-4066-aa10-009f4d7fb127' and activeflag =1;