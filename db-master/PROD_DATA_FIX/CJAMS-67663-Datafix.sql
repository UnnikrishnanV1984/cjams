/*
  
  
   Issue Description: CJAMS-67663-Datafix
   Category/ Module  : Deelete person
   Root cause:Can you please soft delete this client 4164527 removal, This removal is not approved impacting ACQI report.
Removal start date: 2022-02-02 00:00:00
   Pull request# for code fix:
   Reason why no related code fix: 
    requested a data fix to resolve
*/


update cjams.intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CJAMS-67663',
	updatedon = now()
where intakeservreqchildremovalid = '7c566fb4-ca90-461c-8750-9dd799b46ddf'
	and activeflag = 1 ;
	

update cjams.personprogramarea 
set activeflag = 0, 
	updatedby = 'CJAMS-67663',
	updatedon = now()
where personprogramid = 'd219505c-8a88-4fac-aafc-df0d77f32e12'
	and activeflag = 1 ;

update cjams.tb_client_eligibility
set delete_sw  = 'Y',
	update_user_id = 'CJAMS-67663',
	update_ts = now()
where removal_id =  374412
	and delete_sw = 'N' ;



update cjams.intakeservreqchildremoval_history
set activeflag = 0,
	updatedby = 'CJAMS-67663',
	updatedon = now()
where intakeservreqchildremovalid = '7c566fb4-ca90-461c-8750-9dd799b46ddf'
and activeflag = 1 ;


update cjams.routing
set activeflag = 0,
	updatedby = 'CJAMS-67663',
	updatedon = now()
where objectid = '7c566fb4-ca90-461c-8750-9dd799b46ddf'
and activeflag = 1 ;


--Deactivating in placement
 update placement
set intakeservreqchildremovalid = '7867742b-8d38-42f4-b42b-68356635dfcd', updatedby = 'CJAMS-67663', updatedon = now()
WHERE intakeservreqchildremovalid='7c566fb4-ca90-461c-8750-9dd799b46ddf'
 and activeflag = 1;
