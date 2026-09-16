/*
Issue Description:CJAMS-65070 
Category/Module: Service Plan 
Root cause: User delete service plan version goal objective by mistake and requested to revert the delete:
Fix provided: Data fix has been done to set active flag 1 to deleted record
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

update cjams.splanobjective
 	set activeflag = 1,
 		updatedby= 'CJAMS-65070',
 		updatedon = now()
 	where splanobjectiveid = '4b8a9cc5-dc7e-4221-b8ea-d6ff4582a015'
 		and activeflag = 0;