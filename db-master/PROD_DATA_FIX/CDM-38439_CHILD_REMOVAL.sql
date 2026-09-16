/*
   Issue Description: CDM-38439
   Category/ Module  : child removal
   Root cause: user wants to remove 
   Pull request# for code fix: 
   Reason why no related code fix: 
  221030018879:Child was accidentally removed in CJAMS. Attempting to return child and getting an error that a "family" assignment is needed.  */


UPDATE intakeservreqchildremoval 
SET activeflag = 0,
   updatedby = 'CDM-38439',
   updatedon = now() 
WHERE intakeservreqchildremovalid = 'c92ecbb1-0d2d-4649-bd13-a04e9fcfd39d';

UPDATE intakeservreqchildremoval_history
SET activeflag = 0,
   updatedby = 'CDM-38439',
   updatedon = now() 
where intakeservreqchildremovalid = 'c92ecbb1-0d2d-4649-bd13-a04e9fcfd39d'
and activeflag = 1;

UPDATE routing 
SET activeflag = 0,
   updatedby = 'CDM-38439',
   updatedon = now() 
   where objectid = 'c92ecbb1-0d2d-4649-bd13-a04e9fcfd39d';