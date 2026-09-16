
/*
Issue Description: Need data fix to remove the IV-E case closure review record for the adoption case which was accidentally sent for IV-E case closure review by the worker. Case details are as below:
Category/Module: Adoption
Root cause: User accidently sent the request for IV-E case closure review for below adoption case.
Fix provided: Datafix has been promoted to soft delete the record in the ivecaseclosurereview and routing tables.
Data/Code fix ticket#: CJAMS-66199
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error, no code fix needed. Reveted the case closure review request by soft deleting the record in the table in the database.
Status of the code fix if already submitted and expected prod fix date: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update ivecaseclosurereview set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-66199'
where ivecaseclosurereviewid = '4090b9c9-4478-4718-89a6-0ce2ac80f66e' and activeflag = 1;

update routing set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-66199'
where objectid= 'ce98eb36-14e5-4fac-b2c2-f6b9e4308d0f' and activeflag = 1;