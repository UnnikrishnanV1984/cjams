-- CIDM-11587 GAP & Adoption Title IV-E episode dates and agreement dates not in sync - one-time data cleanup
/*
-- Issue Description: 
   GAP & Adoption Title IV-E episode dates and agreement dates not in sync

	Root cause: CJAMS is not updating the Title IV-E episode dates is NOT UPDATING when the Gap and Adoption Agreement Satrt and End date updates in CW application. 
	Fix Provided: One-time datafix has been promoted to update GAP & Adoption Title IV-E episode dates.
	Regression Impacts: GAP & Adoption setup and agreement extension flows 
	Is Code fix Required?: (Yes/No) Yes
		Code fix ticket#: (If Yes) CIDM-11594
		
*/
 
-- GAP
-- Update Start Date
update cjams.tb_client_eligibility ce
set start_dt = ga.startdate,
    update_user_id = 'CIDM-11587', 	
	update_ts = now()
from guardianship gs,
	gapagreement ga 
where btrim(ce.eligibility_type_cd) = '2935'
    and ce.delete_sw = 'N'
	and ce.guardian_subsidy_id = gs.alternateid
	and gs.gapid = ga.gapid
    and gs.activeflag = 1
    and ga.activeflag = 1
    and ( 
	    	( ce.start_dt is null and ga.startdate::date is not null )
	    	or	
		    ce.start_dt::date <> ga.startdate::date 
 	    );

-- Update End Date
update cjams.tb_client_eligibility ce
set end_dt = ga.enddate,
    update_user_id = 'CIDM-11587', 	
	update_ts = now()
from guardianship gs,
	gapagreement ga 
where btrim(ce.eligibility_type_cd) = '2935'
    and ce.delete_sw = 'N'
	and ce.guardian_subsidy_id = gs.alternateid
	and gs.gapid = ga.gapid
    and gs.activeflag = 1
    and ga.activeflag = 1
    and ( 
	    	( ce.end_dt is null and ga.enddate::date is not null )
	    	or	
		    ce.end_dt::date <> ga.enddate::date 
 	    );
		
-- Adoption

-- Adoption & Agreement Dates diff fixes
-- 2023-05-04	2035-01-12	1057272
update adoptioncase
set startdate = '2023-05-04',
	enddate = '2035-01-12',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 1057272
	and activeflag = 1 ;
	
-- 2020-05-01	2020-09-30	11426
update adoptioncase
set startdate = '2020-05-01',
	enddate = '2020-09-30',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 11426
	and activeflag = 1 ;
	
-- 2022-03-31	2026-08-19	26343
update adoptioncase
set startdate = '2022-03-31',
	enddate = '2026-08-19',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 26343
	and activeflag = 1 ;
	
-- 2017-08-10	2033-06-16	48068
update adoptioncase
set startdate = '2017-08-10',
	enddate = '2033-06-16',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 48068
	and activeflag = 1 ;
	
-- 2021-09-01	2037-02-09	1051290
update adoptioncase
set startdate = '2021-09-01',
	enddate = '2037-02-09',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 1051290
	and activeflag = 1 ;
	
-- 2022-05-04	2026-08-18	1051473
update adoptioncase
set startdate = '2022-05-04',
	enddate = '2026-08-18',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 1051473
	and activeflag = 1 ;
	
-- 2023-01-04	2036-12-07	1053179
update adoptioncase
set startdate = '2023-01-04',
	enddate = '2036-12-07',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 1053179
	and activeflag = 1 ;
	
-- 2023-01-18	2036-12-06	1051773
update adoptioncase
set startdate = '2023-01-18',
	enddate = '2036-12-06',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 1051773
	and activeflag = 1 ;
	
-- 2020-09-16	2033-10-02	1051017
update adoptioncase
set startdate = '2020-09-16',
	enddate = '2033-10-02',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 1051017
	and activeflag = 1 ;
	
-- 2021-01-15	2031-04-12	1051140
update adoptioncase
set startdate = '2021-01-15',
	enddate = '2031-04-12',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 1051140
	and activeflag = 1 ;
	
-- 2021-01-15	2034-09-02	1051144
update adoptioncase
set startdate = '2021-01-15',
	enddate = '2034-09-02',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 1051144
	and activeflag = 1 ;
	
-- 2021-03-31	2027-06-08	43412
update adoptioncase
set startdate = '2021-03-31',
	enddate = '2027-06-08',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 43412
	and activeflag = 1 ;
	
-- 2022-03-01	2025-03-01	41705
update adoptioncase
set startdate = '2022-03-01',
	enddate = '2025-03-01',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 41705
	and activeflag = 1 ;
	
-- 2003-11-01	2020-05-21	4703
update adoptioncase
set startdate = '2003-11-01',
	enddate = '2020-05-21',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 4703
	and activeflag = 1 ;
	
-- 2016-07-06	2021-01-08	46378
update adoptioncase
set startdate = '2016-07-06',
	enddate = '2021-01-08',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 46378
	and activeflag = 1 ;
	
-- 2003-11-06	2020-06-22	4197
update adoptioncase
set startdate = '2003-11-06',
	enddate = '2020-06-22',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 4197
	and activeflag = 1 ;
	
-- 2021-11-19	2034-12-08	1051423
update adoptioncase
set startdate = '2021-11-19',
	enddate = '2034-12-08',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 1051423
	and activeflag = 1 ;
	
-- 2019-05-29	2028-04-18	1000153
update adoptioncase
set startdate = '2019-05-29',
	enddate = '2028-04-18',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 1000153
	and activeflag = 1 ;
	
-- 2009-02-01	2028-06-12	20357
update adoptioncase
set startdate = '2009-02-01',
	enddate = '2028-06-12',
	updatedby = 'CIDM-11587', 	
	updatedon = now()
where alternateid = 20357
	and activeflag = 1 ;


-- Update Start Date
update cjams.tb_client_eligibility ce
set start_dt = ad.subsidy_start_dt::date
   -- update_user_id = 'CIDM-11587', 	
   -- update_ts = now()
from tb_adoption ad 
where btrim(ce.eligibility_type_cd) = '2934'
    and ce.delete_sw = 'N'
	and ce.create_user_id <> 'convertw'
	and ce.adoption_id = ad.adoption_id
    and ad.delete_sw = 'N'
    and ( 
	    	( ce.start_dt is null and ad.subsidy_start_dt::date is not null )
	    	or	
		    ce.start_dt::date <> ad.subsidy_start_dt::date 
 	    )
	;		
	
-- Update End Date
update cjams.tb_client_eligibility ce
set end_dt = ad.subsidy_end_dt::date
   -- update_user_id = 'CIDM-11587', 	
   -- update_ts = now()
from tb_adoption ad 
where btrim(ce.eligibility_type_cd) = '2934'
    and ce.delete_sw = 'N'
	and ce.adoption_id = ad.adoption_id
    and ad.delete_sw = 'N'
    and (  	ce.end_dt is null
	    	or	
		    ce.end_dt::date <> ad.subsidy_end_dt::date 
 	    )
	;		