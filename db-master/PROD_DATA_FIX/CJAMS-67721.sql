
/*
Issue Description: CJAMS-67721
Category/Module: Assessment
Root cause: Fatality/ Near Fatality Button Correction
Fix provided: Data fix has been promoted to update the Child Fatality to Yes and Near-Death/Serious Physical Injury to No from backend
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/
update intakeservicerequestsdm 
set ischildfatality =true,isseriousphysicalinjury=false, updatedby ='CJAMS-67721', updatedon =now()
where intakeservicerequestsdmid ='61df4a58-529b-4fac-9918-32276e6343e3' and intakeserviceid ='bb7d3e8b-4fba-401c-91ea-4b1a4b747426';