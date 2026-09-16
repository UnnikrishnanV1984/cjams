/*
Issue Description: Please remove two living arrangement records as highlighted for Client ID: 3479423
Category/ Module : Error
Root cause: The two living arrangements starting 12/22/2023 and ending 12/22/2023 are not needed.
Fix provided: Yes, write Db query 
Code fix ticket#: CDM-40176
Reason why no related code fix: Status of the code fix  already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Deactivating in placement
update placement
set activeflag = 0, updatedby = 'CDM-40176', updatedon = now()
where placementid in ('9049a52b-36e0-49e0-ad0c-f9d42fda4c89', '37f620d8-6ed8-4519-b590-4c6c652ba692') and activeflag = 1;

--Deactivating in placementrevision
update placementrevision
set activeflag = 0, updatedby = 'CDM-40176', updatedon = now()
where placementid in ('9049a52b-36e0-49e0-ad0c-f9d42fda4c89', '37f620d8-6ed8-4519-b590-4c6c652ba692') and activeflag = 1;

--Deactivating in livingarrangement
update livingarrangement
set activeflag = 0, updatedby = 'CDM-40176', updatedon = now()
where placementid in ('9049a52b-36e0-49e0-ad0c-f9d42fda4c89', '37f620d8-6ed8-4519-b590-4c6c652ba692') and activeflag = 1;

--Deactivating in routing
update routing
set activeflag = 0, updatedby = 'CDM-40176', updatedon = now()
where objectid in ('9049a52b-36e0-49e0-ad0c-f9d42fda4c89', '37f620d8-6ed8-4519-b590-4c6c652ba692') and activeflag = 1;