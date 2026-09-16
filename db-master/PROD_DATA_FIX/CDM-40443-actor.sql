/* 
  Issue Description: CDM-40443
  Category/ Module  : Person Profile
  Root cause: Code fix has been done
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

UPDATE cjams.actor
SET updatedon=now(), activeflag=0, updatedby='CDM-40443'
WHERE actorid in ('b40672e0-0d9f-4590-b903-db9cc532f9a2','53e6d5ed-1d32-4204-afc9-3d2a5cbb2384','191703d8-147e-4b8f-8229-5b9defdf5330',
'4624b127-217e-4c05-b919-71a8b4ee921f') and servicecaseid='3f4b495a-2c50-474c-9a95-12bd87a38a82' and personid in ('676e34f1-64f2-41b2-bad5-e7b1af2e7018',
'dd673399-8d3f-491a-9036-0e8d609482a4','8f622386-4dc8-48c5-8302-2730fb8d67b9','5adb69ff-9a60-41c5-95d0-b2e9ae5886dd');
