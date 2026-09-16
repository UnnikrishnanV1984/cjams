/*
  Issue Description:  CDM-42387
   Category/ Module  : Payments
   Root cause: User request to change the effective date
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup before update/ delete: NA
*/

update adoptioncaseagreement 
set effectiveswitchdate = '2024-09-30 04:00:00.000'
where adoptionagreementid = '0859e956-6f84-4f7a-8422-8be6969336f0'
and adoptioncaseid = '70701625-0a54-428a-893a-9aa18db6272e' and activeflag = 1;
