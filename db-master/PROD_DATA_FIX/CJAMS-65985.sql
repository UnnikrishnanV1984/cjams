/*
Root Cause: User requested to change the date ranges
Fix Provided: Fix was provided by updateing the date range as requested  (fromdate ='2025-08-22', todate ='2026-02-18')
Code Fix: Not required
*/

update snapshothist 
set fromdate ='2025-08-22', todate ='2026-02-18', updatedby ='CJAMS-65985', updatedon =now()
where objectid ='aa1e82a2-804c-4697-b58a-949e171f71fd' and id ='26866147-0663-4bd1-a265-094620bc5053';