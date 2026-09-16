/*
Issue Description:251023063016:Worker requested a service case to be opened and it was not needed. This request was not approved. After AR Case was closed. This request remains.
Root cause: user could not able to disconnect the CPS-AR from the intake  ,they can only create.
Fix provided: DB queries  update enddate intakeservicerequest tables
Data/Code fix ticket#: CJAMS-60970
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update routing 
set activeflag =0 , updatedby = '', updatedon = now()
where routingid  = 'e1a54668-39a7-4123-9e41-d22fa818cb6f' and activeflag  =1;