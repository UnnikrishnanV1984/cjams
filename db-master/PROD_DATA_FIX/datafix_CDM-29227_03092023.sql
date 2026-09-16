/*
   Issue Description: CDM-29227 - Incorrect Guardianship date, Court Order Date
   
   2021011107384:The Guardianship start date auto populated an incorrect date. The correct date should be 12/20/22 not 12/28/22. 
   The information is pulled from the court hearing screen however that screen also reflect 12/20/22. Please see attachment for information.
   
   Category/ Module  :  Court Hearing, PERMANENCY PLAN
   Root cause: Data issue
*/

/*
select * from getservicecasecourtorder('987f458e-5811-4fa8-add0-a05e2f5aa4ee');
select * from intakeservreqcourtorder where servicecaseid = '987f458e-5811-4fa8-add0-a05e2f5aa4ee';
update intakeservreqcourtorder 
set courtorderdate= '2022-12-20 05:00:00', updatedon=now(), updatedby='CDM-29227'
where servicecaseid ='987f458e-5811-4fa8-add0-a05e2f5aa4ee' and intakeservreqcourtorderid = '31ce631d-af3e-4151-9d5f-be3905ed06c7';
*/
-- select * from getgapagreementlist('9d477529-7c7b-4ee2-a1b6-dedff9869d62', 1, 10, null, '');

select * from gapagreement where gapid = '9d477529-7c7b-4ee2-a1b6-dedff9869d62';
update gapagreement 
set startdate= '2022-12-20 05:00:00', updatedon=now(), updatedby='CDM-29227'
where gapid = '9d477529-7c7b-4ee2-a1b6-dedff9869d62';

select ratestartdate, rateenddate, approvaldate, updatedby, updatedon, activeflag
from gapratesrevision
where guardiansubsidyid = '9d477529-7c7b-4ee2-a1b6-dedff9869d62';
update gapratesrevision
set approvaldate = now(),
updatedon = now(),
updatedby = 'CDM-29227'
where guardiansubsidyid = '9d477529-7c7b-4ee2-a1b6-dedff9869d62';

