/*
Issue: CJAMS-66601
Category/Module: Tickets
Root cause: User requested to update the county as (Dochester) as it was missed
Fix provided:  Data fix has been done by updating the county (Dorchester)
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
*/


update defecttracking.supportlog 
set ldssregion = 'Dorchester', updatedby = 'CJAMS-66601', updatedon = now() 
where supportlogid= '715b007a-9b1d-4122-a9a8-a7713b651a86' and activeflag = 1;