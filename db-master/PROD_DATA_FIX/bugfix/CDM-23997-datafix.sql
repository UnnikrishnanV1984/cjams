/*
   Issue Description: CDM-23997
   Category/ Module  :  Removed Dummy Case
   Root cause: Removed Dummy Case
*/


update	cjams.servicecase 
set 	activeflag = 0, 
		updatedby = 'CDM-23997',
		updatedon = now()
where 	servicecasenumber = '221030017442';


update 	cjams.servicecasedisposition 
set		activeflag = 0,
		updatedby = 'CDM-23997',
		updatedon = now()
where 	servicecaseid = 'dc96bbd8-5b65-48d9-ac1f-af14910b1c8b';

update 	cjams.routing
set		activeflag = 0,
		updatedby = 'CDM-23997',
		updatedon = now()
where 	objectid = 'dc96bbd8-5b65-48d9-ac1f-af14910b1c8b';