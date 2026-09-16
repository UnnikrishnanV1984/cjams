-- CDM-24170 - Initial Contact Timer
/*
-- Issue Description: 
   Datafix to Trigger Response Timer Conditions on all CJAMS created CPS-IR / CPS-AR Cases
   where No Clients are participating as a Child or Other Children
   
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Response Timer Code fix has been promoted as aprt of this fix
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: Next Prod deployemnt 
*/


-- *****  Dependency ******
/*
Please deploy the below Stored procedures prior to this script run (datafix_CDM-24170_08172022.sql)
 
1) cpsresponsetimerupdate.sql
2) sp_cps_responsetimer_datafix.sql
*/

select a.al_sqlcode, a.as_mess
from cjams.sp_cps_responsetimer_datafix('CDM-24170'::character varying) a ;