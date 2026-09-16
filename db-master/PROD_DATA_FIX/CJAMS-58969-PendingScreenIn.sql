
/*
Issue Description:Referral I251013256718 was transferred from another county and screened out appropriately, but still showing up on my dashboard as "pending approval".
Category/Module: Bug
Root cause: User can only create intake , they do not have access to delete . So, they request requested to remove it.
Fix provided: DB queries  update intakedastatus, intakedastaging table.
Data/Code fix ticket#: CJAMS-58969
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Roor
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update routing 
set activeflag= 0, routingstatustypeid = '8', updatedon = now(), updatedby = 'CJAMS-58969' 
where routingid = 'cf02640f-2d44-4656-9f85-ce702b1cb8c4' and activeflag =1;
