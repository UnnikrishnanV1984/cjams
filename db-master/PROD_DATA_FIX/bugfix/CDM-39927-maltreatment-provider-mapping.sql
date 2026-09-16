/*
   Issue Description: CDM-39927 T. Jones Case Alleged Maltreator
   Category/ Module  : SDM
   Root cause: For the case number 241022260745 case head T. Jones, user requested to remove KKI as the provider from the maltreatment allegation tab and make it left blank. 
               Also need for this case to be changed in the SDM from provider involved maltreatment to living arrangement in foster care
   Fix provided : Data fix has been promoted to remove KKI as provider from the maltreatment allegations and also change SDM from provider involved maltreatment
                  to living arrangement in foster care.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/


UPDATE intakesnapshot 
SET jsondata = 
jsonb_set(
jsonb_set(
jsonb_set(jsondata, '{sdm,provider}', '[]'),
'{sdm,isfclivingarrangement}', 'true'),
			   '{sdm,isprivateplacement}', 'false'),
	updatedby = 'CDM-39927',
	updatedon = now()
where intakenumber ='I241012444103'
and activeflag=1;


update intakeservicerequestsdm
set isfclivingarrangement = true,
    isprivateplacement = false,
    updatedby = 'CDM-39927',
    updatedon = now()
where intakeserviceid = '014ef7df-3a3d-4f41-9880-cbd0588d8ca3'
and intakeservicerequestsdmid = 'c5dce5b7-1add-4f60-9be8-d25060119543';


