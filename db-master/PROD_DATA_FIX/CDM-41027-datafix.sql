/*
  Issue Description:  CDM-41027
   Category/ Module  :  Permanency Plan
   Root cause: User error to data fix for child removal 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

UPDATE intakeservreqchildremoval 
SET activeflag = 0,
updatedby ='CDM-41027',
updatedon = now()
WHERE intakeservreqchildremovalid = 'be0fbb07-d79d-428d-939f-e1b949408691' AND activeflag=1;


UPDATE intakeservreqchildremoval_history 
SET activeflag = 0,
updatedby ='CDM-41027',
updatedon = now()
WHERE intakeservreqchildremovalid = 'be0fbb07-d79d-428d-939f-e1b949408691' and intakeservreqchildremovalhistoryid = 'cf8a5f13-1e91-4cd9-9b7a-5772f2653e87' AND activeflag=1;

update personprogramarea set activeflag =0, updatedby ='CDM-41027', updatedon =now() where personid = '6d5ba301-740f-49c2-bf83-01676b79f7bf' and  
 personprogramid = '2d71b1a3-1559-498f-90b0-25fd2436c933' and activeflag = 1;


update routing set activeflag =0 WHERE objectid = 'be0fbb07-d79d-428d-939f-e1b949408691' and routingid = '36a9dbc8-a6fc-4abc-a453-4e97c2382aa7'
AND activeflag=1;


update tb_client_eligibility set delete_sw = 'Y', update_ts = now(), update_user_id = 'CDM-41027' where removal_id = '320967'
and delete_sw = 'N' ;