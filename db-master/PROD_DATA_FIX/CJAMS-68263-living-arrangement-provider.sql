/* 
Issue Description: CJAMS-68263
Category/ Module: Placements
Root cause: Requested for a data fix to remove the living arrangement record where the provider details are missing
Fix provided: Data fix has been done to remove the living arrangement record
Is code fix required: N 
Pull request# for code fix: 
Reason why no related code fix: 
Status of the code fix if already submitted and expected prod fix date: N/A
Backup before update/ delete: 
 */

update placement
set activeflag=0, updatedby='CJAMS-68263', updatedon=now()
where placementid='0bd8223f-f08e-4b48-9c1b-fe3a82ba086a' and activeflag=1;

update routing
set activeflag=0, updatedby='CJAMS-68263', updatedon=now()
where objectid ='0bd8223f-f08e-4b48-9c1b-fe3a82ba086a' and activeflag=1;