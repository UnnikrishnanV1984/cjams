/*
  Issue Description: CDM-27840 202105506197:Contact note from 12.21.22 disappeared.
   Category/ Module  :  child welfare
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   data fix issue, 
   Backup before update/ delete:
*/

update cjams.progressnote set insertedon = '2022-12-22T00:00:00', updatedon='2022-12-22T00:00:00',
updatedby = 'CDM-27840'
where progressnoteid  = '4938b7fe-3546-4cbc-97d3-5a15828812e4';