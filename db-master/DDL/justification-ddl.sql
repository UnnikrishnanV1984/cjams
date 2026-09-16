/*
   Issue Description: CDM-23953
   Category/ Module  :  child-removal 
   Root cause: justification is not saving 
   Pull request# for code fix: No change in code
   Reason why no related code fix: 
*/

ALTER TABLE cjams.intakeservreqchildremoval_history ADD COLUMN IF NOT EXISTS justification varchar NULL;


ALTER TABLE cjams.intakeservreqchildremoval ADD COLUMN IF NOT EXISTS justification varchar NULL;

