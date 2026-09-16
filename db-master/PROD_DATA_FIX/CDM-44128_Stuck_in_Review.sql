/*
   Issue Description: CDM-44128
   Category/ Module  : GAP
   Root cause: GAP agreement review for the case 221030014331 has been sent to the supervisor who is inactive. 
   Fix Provided: Data fix has been done to redirect GAP to  Supervisor. 
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: This issue happend due to user deactivation and data fix will fix this.
   Status of the code fix if already submitted and expected prod fix date: N/A  
*/

update routing
set toroleid='CWSP', 
	fromsecurityusersid = '96ba1f6c-c1bd-4213-92c2-0e62812330f0', --PamelaPrice	
	tosecurityusersid='aabfe50d-3996-444c-a2fb-4640f0ff257b', --AmberWebster 
	updatedby='CDM-44091', updatedon = now()
where objectid='ccffba67-34d2-40f8-bd52-877601ab0fbf' and activeflag = 1; --Oliver gapagreementid

