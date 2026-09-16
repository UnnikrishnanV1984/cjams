/*
Issue Description: Please remove the highlighted placement records
Category/Module: Bug
Root cause: Placement records needed to be removed
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-40923
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update placement 
set activeflag =0, updatedby ='CDM-40923', updatedon =now()
where placementid in ('ceb9e324-706e-45bb-a14b-6b248fe2bfac') and activeflag =1;

update placementrevision  
set activeflag =0, updatedby ='CDM-40923', updatedon =now()
where placementid in ('ceb9e324-706e-45bb-a14b-6b248fe2bfac') and activeflag =1;

update livingarrangement  
set activeflag =0, updatedby ='CDM-40923', updatedon =now()
where placementid ='ceb9e324-706e-45bb-a14b-6b248fe2bfac' and activeflag =1;

update routing  
set activeflag =0, updatedby ='CDM-40923', updatedon =now()
where objectid ='ceb9e324-706e-45bb-a14b-6b248fe2bfac' and activeflag =1;

