
/*
Issue Description: CJAMS-67719
Category/Module: Child Removal
Root cause: Missing VPA Fields
Fix provided: Data fix has been promoted to set Voluntary Relinquishment- Yes,End Date- 4/19/2019,Parent 1- Trace Mulroy,Parent 2- Kyle Mulroy
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/
update intakeservreqchildremoval set volrelinquishment=1, vpaenddate='2019-04-19 00:00:00', 
parent1id= '3429990',parent2id='3429992', updatedby='CJAMS-67719', updatedon=now()
where intakeservreqchildremovalid='ff33c6c6-ee20-422c-9772-58050539ef62' and intakeservicerequestactorid='231f07ed-7bc4-48bb-8903-339074059eed';