/*
Issue Description: Youth, Sarah Strother, had two living arrangements added and approved although the second living arrangement labeled as Respite needs to be deleted as this was incorrectly added. 
Category/ Module : Bug
Root cause: second living arrangement labeled as Respite needs to be deleted as this was incorrectly added
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-40242
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

 --routing
update routing
set updatedby = 'CDM-40242',updatedon = now(),activeflag = 0
where objectid = '0e13f58a-c8d7-4ff4-a31f-d922dadd198d' and activeflag = 1;

--placementrevision
update placementrevision
 set updatedby = 'CDM-40242',updatedon = now(),activeflag = 0
 where placementid = '0e13f58a-c8d7-4ff4-a31f-d922dadd198d' and activeflag = 1;
     
--livingarrangement
update livingarrangement
 set updatedby = 'CDM-40242', updatedon = now(), activeflag = 0
 where placementid = '0e13f58a-c8d7-4ff4-a31f-d922dadd198d' and activeflag = 1;
    
--placement
update placement
set updatedby = 'CDM-40242',updatedon = now(),activeflag = 0
where placementid = '0e13f58a-c8d7-4ff4-a31f-d922dadd198d' and activeflag = 1 ;