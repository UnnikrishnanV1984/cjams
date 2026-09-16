/*
Issue Description: Please remove the highlighted placement record records
Category/Module: Bug
Root cause: Placement records needed to be removed
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-41039
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update placement 
set activeflag =0, updatedby ='CDM-41039', updatedon =now()
where placementid in ('98af63ce-8772-4ea3-8b4f-92f8ea7ed493','d9e97b78-5681-4167-bfe9-485f720a0e13') and activeflag =1;

update placementrevision  
set activeflag =0, updatedby ='CDM-41039', updatedon =now()
where placementid in ('98af63ce-8772-4ea3-8b4f-92f8ea7ed493','d9e97b78-5681-4167-bfe9-485f720a0e13') and activeflag =1;

update livingarrangement  
set activeflag =0, updatedby ='CDM-41039', updatedon =now()
where placementid in ('98af63ce-8772-4ea3-8b4f-92f8ea7ed493','d9e97b78-5681-4167-bfe9-485f720a0e13') and activeflag =1;

update routing  
set activeflag =0, updatedby ='CDM-41039', updatedon =now()
where objectid in ('98af63ce-8772-4ea3-8b4f-92f8ea7ed493','d9e97b78-5681-4167-bfe9-485f720a0e13') and activeflag =1;