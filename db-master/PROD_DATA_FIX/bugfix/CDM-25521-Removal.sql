/*
   Issue Description: CDM-25521
   Category/ Module  : child removal 
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update cjams.intakeservreqchildremoval set parent2comments ='2nd parent couldn''t sign VPA', updatedby='CDM-25521', updatedon =now()

where intakeservreqchildremovalid ='beb1608d-b797-45fb-8736-61de55348d31';


update cjams.intakeservreqchildremoval_history set parent2comments ='2nd parent couldn''t sign VPA', updatedby='CDM-25521', updatedon =now()

where intakeservreqchildremovalid ='beb1608d-b797-45fb-8736-61de55348d31' and activeflag =1;