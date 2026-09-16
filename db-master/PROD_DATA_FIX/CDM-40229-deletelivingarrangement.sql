/*
Issue Description: The living arrangement from 11/10/22-11/12/22 should not be there. Can you please remove?
Category/ Module : Bug
Root cause: from 11/10/22-11/12/22 should not be there (Living Arrangement)
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-40229
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

 --routing
update routing
set activeflag = 0, updatedby = 'CDM-40229', updatedon = now()
where objectid = '04f9b688-1391-49cd-80da-848e058c9b07' and activeflag = 1;

--placementrevision
update placementrevision
 set activeflag = 0,updatedon = now(),updatedby = 'CDM-40229'
 where placementid = '04f9b688-1391-49cd-80da-848e058c9b07' and activeflag = 1;
     
--livingarrangement
update livingarrangement
 set updatedby = 'CDM-40229', updatedon = now(), activeflag = 0
 where placementid = '04f9b688-1391-49cd-80da-848e058c9b07' and activeflag = 1;
    
--placement
update placement
set updatedby = 'CDM-40229',updatedon = now(),activeflag = 0
where placementid = '04f9b688-1391-49cd-80da-848e058c9b07' and activeflag = 1 ;