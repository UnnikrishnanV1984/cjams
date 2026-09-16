/*
   Issue Description: CJAMS-59984
   Service Case# 3276097,
    Client ID: 200161296 (Sevannah Blick Perry)
    Client ID: 200147371 (Sevionna Blick Perry)
    1. Need to delete the "Child removal" episode and "OOH Program" assignment for both the clients.
    2. Need to delete the "Living arrangement" placement for both the clients.
   Category/ Module  : Remove living arrangement
   Root cause: User Error, user entered the removal and the placement on the wrong case.
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

--Client ID: 200147371 (Sevionna Blick Perry)
-- 1. Remove the Child Removal 
--select * from cjams.intakeservreqchildremoval where intakeservreqchildremovalid= '380f12da-e92d-4eef-9f7d-751e7ec04fa0' and activeflag=1;--6c712d50-3927-4e33-ab77-c34713391071,348829

update cjams.intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CJAMS-59984',
	updatedon = now()
where intakeservreqchildremovalid = '380f12da-e92d-4eef-9f7d-751e7ec04fa0' 
	and activeflag = 1;

/*
select * from intakeservreqchildremoval_history
where intakeservreqchildremovalid = '380f12da-e92d-4eef-9f7d-751e7ec04fa0' 
	and activeflag = 1;
*/

update cjams.intakeservreqchildremoval_history
set activeflag = 0,
	updatedby = 'CJAMS-59984',
	updatedon = now()
where intakeservreqchildremovalid = '380f12da-e92d-4eef-9f7d-751e7ec04fa0' 
	and activeflag = 1;

update routing
set activeflag = 0,
	updatedby = 'CJAMS-59984',
	updatedon = now()
where objectid = '380f12da-e92d-4eef-9f7d-751e7ec04fa0'
	and activeflag = 1; 

--select * from tb_client_eligibility where removal_id ='348830';

update tb_client_eligibility 
set delete_sw = 'Y', 
	update_ts = now(), 
	update_user_id = 'CJAMS-59984' 
where removal_id = 348830
	and delete_sw = 'N' ;	
	
-- 2. Remove the OOH program assignment with start date as 03/19/2019
update personprogramarea 
set activeflag = 0, 
	updatedby = 'CJAMS-59984', 
	updatedon = now() 
where personprogramid = '6e827d14-31e6-40dd-90e5-e2811d9d85eb' 
	and activeflag = 1;
	
	
--3. Remove living arragement
--select * from placement where placementid = '51995467-32bf-4051-824b-4bd37b9f57a4';

update
	placement
set
	activeflag = 0,
	updatedby = 'CJAMS-59984',
	updatedon = now()
where
	placementid = '51995467-32bf-4051-824b-4bd37b9f57a4'
	and activeflag = 1;

update
	livingarrangement
set
	activeflag = 0,
	updatedby = 'CJAMS-59984',
	updatedon = now()
where
	placementid = '51995467-32bf-4051-824b-4bd37b9f57a4'
	and activeflag = 1;
	
update 
	routing
set
	activeflag=0,
	updatedby = 'CJAMS-59984',
	updatedon = now()	
where 
	 objectid = '51995467-32bf-4051-824b-4bd37b9f57a4'
	and eventcode = 'PLTR' and activeflag = 1;

update
	placementrevision
set
	activeflag = 0,
	updatedby = 'CJAMS-59984',
	updatedon = now()
where
	placementid = '51995467-32bf-4051-824b-4bd37b9f57a4'
	and activeflag = 1;
	
---------------------------------- second child-------------------------------
--Client ID: 200161296 (Sevannah Blick Perry)

-- 1. Remove the Child Removal 

--select * from cjams.intakeservreqchildremoval where intakeservreqchildremovalid= '9f492370-d662-40e0-a13b-e93f143b2672' and activeflag=1;

update cjams.intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CJAMS-59984',
	updatedon = now()
where intakeservreqchildremovalid = '9f492370-d662-40e0-a13b-e93f143b2672' 
	and activeflag = 1;

/*
select * from intakeservreqchildremoval_history
where intakeservreqchildremovalid = '9f492370-d662-40e0-a13b-e93f143b2672' 
	and activeflag = 1;
*/

update cjams.intakeservreqchildremoval_history
set activeflag = 0,
	updatedby = 'CJAMS-59984',
	updatedon = now()
where intakeservreqchildremovalid = '9f492370-d662-40e0-a13b-e93f143b2672' 
	and activeflag = 1;

update routing
set activeflag = 0,
	updatedby = 'CJAMS-59984',
	updatedon = now()
where objectid = '9f492370-d662-40e0-a13b-e93f143b2672'
	and activeflag = 1; 

--select * from tb_client_eligibility where removal_id ='348831';

update tb_client_eligibility 
set delete_sw = 'Y', 
	update_ts = now(), 
	update_user_id = 'CJAMS-59984' 
where removal_id = 348831
	and delete_sw = 'N' ;	
	
-- 2. Remove the OOH program assignment with start date as 03/19/2019
update personprogramarea 
set activeflag = 0, 
	updatedby = 'CJAMS-59984', 
	updatedon = now() 
where personprogramid = '66cb4dae-008e-426c-bba0-45c9cc9a5f94' 
	and activeflag = 1;
	
--3. Remove living arragement
--select * from placement where placementid = '53ba839e-0e77-4598-9648-3942e79a69da';

update
	placement
set
	activeflag = 0,
	updatedby = 'CJAMS-59984',
	updatedon = now()
where
	placementid = '53ba839e-0e77-4598-9648-3942e79a69da'
	and activeflag = 1;

update
	livingarrangement
set
	activeflag = 0,
	updatedby = 'CJAMS-59984',
	updatedon = now()
where
	placementid = '53ba839e-0e77-4598-9648-3942e79a69da'
	and activeflag = 1;
	
update 
	routing
set
	activeflag=0,
	updatedby = 'CJAMS-59984',
	updatedon = now()	
where 
	 objectid = '53ba839e-0e77-4598-9648-3942e79a69da'
	and eventcode = 'PLTR' and activeflag = 1;

update
	placementrevision
set
	activeflag = 0,
	updatedby = 'CJAMS-59984',
	updatedon = now()
where
	placementid = '53ba839e-0e77-4598-9648-3942e79a69da'
	and activeflag = 1;