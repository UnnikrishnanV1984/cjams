/*
   Issue Description: CDM-28145
   Category/ Module  : child removal 
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update cjams.intakeservreqchildremoval set parent2comments ='Agency were unable to contact father after many attempts.', updatedby='CDM-28145', updatedon =now()

where intakeservreqchildremovalid ='5b463c53-8056-4412-9902-86c55acc8428';


update cjams.intakeservreqchildremoval_history set parent2comments ='Agency were unable to contact father after many attempts.', updatedby='CDM-28145', updatedon =now()

where intakeservreqchildremovalid ='5b463c53-8056-4412-9902-86c55acc8428' and activeflag =1;