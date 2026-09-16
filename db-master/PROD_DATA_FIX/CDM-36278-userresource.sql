/*
   Issue Description: CDM-36278
   Category/ Module  : Adoption Case Access
   Root cause: Resource Specialist role was assigned which is readonly.
   Pull request# for code fix: 
   Reason why no related code fix: Role issue 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update userresource
set activeflag = 0, updatedby = 'CDM-36278', updatedon = now()
where userid in (7333, 7673, 7752, 7443, 7046)  and roleid = 139 and activeflag = 1;