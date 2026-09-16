/*
   Issue Description: CJAMS-58484
   Category/ Module  : Placement
   Root cause: Data fix done remove the Living Arrangement & Hospitalization below.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--removing the Living Arrangement

update livingarrangement
set activeflag = 0, updatedby = 'CJAMS-58484', updatedon = now()
where placementid = '2fbdee9e-03ab-4775-8051-c108ed856022';

update placement
set activeflag = 0, updatedby = 'CJAMS-58484', updatedon = now()
where placementid = '2fbdee9e-03ab-4775-8051-c108ed856022';
 
update placementrevision
set activeflag = 0, updatedby = 'CJAMS-58484', updatedon = now()
where placementid = '2fbdee9e-03ab-4775-8051-c108ed856022';
 
update routing
set activeflag = 0, updatedby = 'CJAMS-58484', updatedon = now()
where objectid = '2fbdee9e-03ab-4775-8051-c108ed856022';

--removing Hospitalization

update personhospitalization
set activeflag = 0, updatedby = 'CJAMS-58484', updatedon = now()
where hospitalizationid = '707354c9-bbcf-4eeb-b06b-c82428d5f261' and activeflag = 1;

--Deactivating in personhospitalization_history
update personhospitalization_history
set activeflag = 0, updatedby = 'CJAMS-58484', updatedon = now()
where hospitalizationid = '707354c9-bbcf-4eeb-b06b-c82428d5f261' and activeflag = 1;
