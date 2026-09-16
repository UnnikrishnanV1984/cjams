/*
Issue Description: Please remove the rejected living arrangement as requested.Client ID: 201029883 (Genaveve Christine Stalfort)
Category/Module: Bug
Root cause: user requestto  removing rjected living arrangement records in placement tab.User can able to creted, but they do not deleted .
Fix provided: DB queries  update placement,placementrevision,table.
Data/Code fix ticket#: CJAMS-58622
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A           
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update placement 
set activeflag = 0, updatedby = 'CJAMS-58622', updatedon = now()
where placementid in ('f809881c-7271-471a-9ee9-8cdd92452e6c', '4f6dcd22-9a99-424d-9fd4-6e71b6c77ce2') and activeflag =1;

update placementrevision   
set activeflag = 0, updatedby = 'CJAMS-58622', updatedon = now()
where placementrevisionid  in ('b5347b3b-beb3-407e-93af-037ea2090667', 'ef566a58-a371-4ea4-97b8-5ffa7dd8c6ad')and activeflag =1;



update livingarrangement 
set activeflag = 0, updatedby = 'CJAMS-58622', updatedon = now()
where livingid in ('023f511c-0469-4dac-b54b-901579c15df3','816b6ec2-c628-4d2b-82e8-e1754036a547') and activeflag =1;


update routing 
set activeflag = 0, updatedby = 'CJAMS-58622', updatedon = now()
where routingid in (
'5ca4d702-c0ef-447c-bee2-9e0ff446d95f',
'36177ca1-3ef9-41dd-992b-9a9400035e98',
'b94f32e5-fc8f-48c2-8dac-dff0a7952f8d',
'6a2ff7df-630b-4673-b88f-1beb41164487'
) and activeflag =1;