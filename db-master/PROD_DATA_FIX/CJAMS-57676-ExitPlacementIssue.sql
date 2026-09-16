/*
Issue Description: when Supervisor approves the Living Arrangement exit, the End date is not updated. Need technical analysis. 
Category/Module: Support
Root cause: due to data glitch endate not updated 
Fix provided: DB queries to  update record in placement placementrevision livingarrangement
Data/Code fix ticket#: CJAMS-57676
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update placement  
set enddatetime = '2025-02-05 00:00:00.000', updatedby = 'CJAMS-57676' ,updatedon = now()
where activeflag =1 and placementid = '05559a30-628b-428d-a796-02fa80929827';

update placementrevision  
set enddate  = '2025-02-05', updatedby = 'CJAMS-57676' ,updatedon = now()
where activeflag =1 and placementrevisionid  = '63baa5a9-cb91-4319-abda-04694ae436f4';

update livingarrangement  
set livingenddate  = '2025-02-05 00:00:00.000', updatedby = 'CJAMS-57676' ,updatedon = now()
where activeflag =1 and livingid  = '7c03348e-d3d3-450b-a776-d3b906b7a816';



