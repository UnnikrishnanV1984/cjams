/*
   Issue Description: CDM-22334
   Category/ Module  : Prod data fix to Remove Gap Rate records
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update gapagreementrate set activeflag = 0, updatedby = 'CDM-22334', updatedon = now() where gapagreementrateid in ('cee6ec28-e69a-450d-97f1-e3d86129f5c2','316991fc-f278-425f-997c-7a0eec13faf1');
update gapratesrevision set activeflag = 0,approvaldate = now(), updatedby = 'CDM-22334', updatedon = now() where gaprateid in ('cee6ec28-e69a-450d-97f1-e3d86129f5c2','316991fc-f278-425f-997c-7a0eec13faf1');
