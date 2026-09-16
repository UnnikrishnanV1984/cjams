/*
   Issue Description: CDM-28699
   Category/ Module  : Removal
   Root cause:For some reason the system allowed the worker to start a new removal. We need this 2nd removal deleted.Wanda Noltwanda.nolt@maryland.gov
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update intakeservreqchildremoval set activeflag =0, updatedon = now(), updatedby ='CDM-28699'  where intakeservreqchildremoval  ='56c107f1-1625-446c-b494-13cf712f9626';