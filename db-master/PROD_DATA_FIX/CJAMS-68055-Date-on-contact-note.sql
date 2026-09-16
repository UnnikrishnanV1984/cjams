
/*
Issue Description: CJAMS-67694 -to update the LRR reason value on the CPS IR # 261023716219
Category/Module: Case Management
Root cause: Contact ID: 16197876 - Date from 4/8/2026 to 4/29/2026 - Received supervisor approval 
Fix provided: update the Contact Date as : 05/09/2026 for Contact ID: 16197876 backend
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/


update progressnote 
set contactdate = '2026-04-29 00:00:00', updatedby = 'CJAMS-68055', updatedon = now()
where witsid='16197876' and activeflag = 1;


