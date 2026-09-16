-- CDM-23686 - PAYMENT
/*
-- Issue Description: 
   User reuest to re-open the Placement / Child Removal / OOH   

-- Case ID: 3262299
-- Client ID: 3895174 (KYNLI DESHIELDS) - 4b5376ef-4cdf-4031-9aed-bb53fa621333  
-- Placement ID: 1569516 - 2021-06-08 To 2022-04-22 - d201877e-26a1-4e85-ab5a-96dad1676437
-- Provider ID: 6004213	(LASHAWNETTE Latoya MITCHELL)

-- Removal ID: 194629 - 2019-01-22 To 2022-04-22 - 82c8e648-e867-4e57-b294-0fafc4ff6ee7
-- Eligibility ID: 167470
-- OOH: 2019-01-22 To 2022-04-22 - 019b5c6e-d2aa-42d3-8845-ded203e1fd7e
 
-- Category/ Module: Removal (Case Management) 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to re-open the Placement, Removal, OOH & IV-E

-- Placement
select alternateid, startdatetime, starttime, enddatetime, enddatetime, 
	exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = 'd201877e-26a1-4e85-ab5a-96dad1676437'
	and activeflag = 1 ;

update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-23686'
where placementid = 'd201877e-26a1-4e85-ab5a-96dad1676437'
	and activeflag  = 1 ;

-- Placement Revision
select exitdate, exittime, exitreasontypkey, exittypekey, updatedby , updatedon  
	from cjams.placementrevision  
where placementid = 'd201877e-26a1-4e85-ab5a-96dad1676437'
	and ( exitdate is not null or exittime is not null ) ;

update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-23686'
where placementid = 'd201877e-26a1-4e85-ab5a-96dad1676437'
	and ( exitdate is not null or exittime is not null ) ;
	
-- Update Removal
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from cjams.intakeservreqchildremoval
where removalid = 194629
	and activeflag = 1 ;
	
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby = 'CDM-23686',
	updatedon = now()
where removalid = 194629
	and activeflag = 1 ;
	
-- Update OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '019b5c6e-d2aa-42d3-8845-ded203e1fd7e'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-23686',
	updatedon = now()
where personprogramid = '019b5c6e-d2aa-42d3-8845-ded203e1fd7e'
	and activeflag = 1 ;
	
-- Legal Custodies are Active in this case
/*
select fromdate, todate, updatedby, updatedon
	from legalcustody 
where legalcustodyid = ??
	and activeflag = 1;

update cjams.legalcustody 
set todate = Null, 
	updatedby = 'CDM-23686',
	updatedon = now()
where legalcustodyid = ?? 
	and activeflag = 1;
*/
	
-- Update Eligibility
select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_client_eligibility
where removal_id =  194629
	and delete_sw = 'N' ;

update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-23686',
	update_ts = now()
where removal_id =  194629
	and delete_sw = 'N' ;
	
/*
Eligibility Period is Active in this case

select start_dt, end_dt, update_ts, update_user_id 
	from cjams.tb_eligibility_period
where eligibility_id =  167470
	and delete_sw = 'N' ;

update cjams.tb_eligibility_period
set end_dt = Null,
	update_user_id = 'CDM-23686',
	update_ts = now()
where eligibility_id =  167470
	and delete_sw = 'N' ;
*/

-- Update Provider Vacancy
select provider_id, vacancy_no, update_ts, update_user_id
	from prov.tb_provider
where provider_id = 6004213
	and delete_sw = 'N' ;

update prov.tb_provider
set vacancy_no = vacancy_no - 1,
	update_ts = now(),
	update_user_id = 'CDM-23686'
where provider_id = 6004213
	and delete_sw = 'N' ;
