-- CDM-29708 - Manually Trigger Response Timer Condition on all the Open CPS-IR / CPS-AR Cases
/*
-- Issue Description: 
   Datafix to Trigger Response Timer Conditions on all CJAMS created CPS-IR / CPS-AR Cases
   where Timer is still running
   
-- Category/ Module: Placements  (Case Management) 
-- Root cause: Response Timer Code was having a flaw and fix has been promoted to production
			this datafix is to cover all CSP cases where timer should have stoped by now. 	
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- *****  Dependency ******
/*
Please deploy the below Stored procedures prior to this script run (CDM-29112_datafix.sql)
 
1) cpsresponsetimerupdate.sql
2) sp_cps_responsetimer_datafix.sql
															  )
*/

select a.al_sqlcode, a.as_mess
from cjams.sp_cps_responsetimer_datafix('CDM-29708'::character varying) a ;