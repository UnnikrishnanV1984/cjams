
/*
   Issue Description: CDM-28538
   Category/ Module  :Wrong Periods generated IVE foster care
   Root cause: ::As wrong court date is selected, periods generated are showing wrongly on screen
   Reason why no related code fix:  Data fix
*/
UPDATE cjams.tb_foster_care_judicial
SET  redetcourtorderid = null, dateofcourthearing=NULL, magistrateorjudgename=NULL, issignedbyjudge=NULL, 
dateofnexthearing=NULL, dateofjudicialfindingofrefpp=NULL, dateofsubsequentjudicialfindingofrefpp=NULL, update_ts=now()  
WHERE client_id::BIGINT = 2494400 and removal_id::BIGINT = 189259 and period_type = 'R5';
