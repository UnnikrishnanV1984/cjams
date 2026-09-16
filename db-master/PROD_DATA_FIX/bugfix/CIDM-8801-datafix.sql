/* 
    Issue Description: CIDM-8801
   Category/ Module  : Placement
   Root cause: :Removing the Duplicate record 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update livingarrangement set activeflag = 0, updatedby = 'CIDM-8801', updatedon = now()
where livingid = '7b39dc4a-4fc6-41b0-a144-6b1058c4ef0e'
and placementid = '12db9ff2-3eaa-4ebe-a968-bd3ccce96d9c';