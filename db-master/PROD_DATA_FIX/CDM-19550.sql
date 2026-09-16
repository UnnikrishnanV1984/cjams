 /*
  Issue Description: CDM-19550 - CASE IS A VPA CASE BUT WAS SET UP IN CJAMS
   Category/ Module  :  child welfare
   Root cause: removed read only access
   Pull request# for code fix: 
   Reason why no related code fix: 
   data fix issue, updation of intakeservreqchildremoval table
   Backup before update/ delete:
*/

update intakeservreqchildremoval
set isbothparentssigned = 2,
agencysigneddate = '2022-06-29 16:13:02',
vpaenddate = '2022-04-30 16:13:02',
vpabegindate  = '2022-06-29 16:13:02',
volrelinquishment = 0,
removaltypekey='CDVP',
updatedon  = now(),
updatedby  = 'CDM-19550'
where intakeservreqchildremovalid  = 'ef2582db-0517-48a3-a2cb-d83a846eb54e';

