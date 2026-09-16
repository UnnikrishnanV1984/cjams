-- CDM-32987 - Incorrect Provider
/*
-- Issue Description: 
	Incorrect Provider on the most recent GAP rate 
    
-- Case ID: 3298445
-- Client ID: 200161415 (Julian	James Hayes) - bd00f68e-1f55-4358-aa84-23412e7b27cf
-- Provider ID: 6005656	(Kenyatta Carter)
-- GAP ID: 1006036 - 2022-03-21 To 2038-10-13 - 00d5d291-ddb0-4e42-818c-cca2e292b709

-- Delete Rate
-- 5036069	9cef1cbb-5728-4c64-9ff2-7daf9c78c5b7	2024-03-21 12:00:00	2025-03-20 12:00:00	887

-- End date the GAP suspesnion
-- 3c37dbc6-4a47-460f-83c5-5798db792ee7	2023-03-01 05:00:00 To Currrent 

-- Wrong Provider ID: 5036069	(Tonya Tillman)

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to fix the GAP Rates as requested by the user. 
				 And to generate the missing system adjustments for Dec 21 and Jan 22 services of client # 3286006
-- Note: KYNDRA ROBINSON was having one additional overlapping suspension starting 12/01/2021, 
--       which is not getting displayed on the screen. We will do further analysis of this issue.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To fix the GAP Rate slabs (CDM-32987)

-- Delete Rate
-- 5036069	9cef1cbb-5728-4c64-9ff2-7daf9c78c5b7	2024-03-21 12:00:00	2025-03-20 12:00:00	887
select provider_id, startdate, enddate, paymentamout, activeflag, updatedby, updatedon, *
	from gapagreementrate
where gapagreementrateid = '9cef1cbb-5728-4c64-9ff2-7daf9c78c5b7'
	and activeflag = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-32987',
	updatedon = now()
where gapagreementrateid = '9cef1cbb-5728-4c64-9ff2-7daf9c78c5b7'
	and activeflag = 1 ;

select providerid, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon, *
	from gapratesrevision
where gaprateid = '9cef1cbb-5728-4c64-9ff2-7daf9c78c5b7'
	and activeflag = 1 ;

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-32987',
	updatedon = now()
where gaprateid = '9cef1cbb-5728-4c64-9ff2-7daf9c78c5b7'
	and activeflag = 1 ;

select eventcode, routingid, routingstatustypeid, routeddescription, updatedby, updatedon, activeflag
	from routing
where objectid = '9cef1cbb-5728-4c64-9ff2-7daf9c78c5b7'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-32987',
	updatedon = now()
where objectid = '9cef1cbb-5728-4c64-9ff2-7daf9c78c5b7'
	and eventcode = 'GARR'
	and activeflag = 1 ;

-- End date the GAP suspesnion
-- 3c37dbc6-4a47-460f-83c5-5798db792ee7	2023-03-01 05:00:00 To Currrent 
select gapsuspensionid, startdate, enddate, activeflag, updatedby, updatedon 
	from gapsuspension 
where gapsuspensionid  = '3c37dbc6-4a47-460f-83c5-5798db792ee7' 
	and activeflag = 1 ;
	
update gapsuspension
set enddate = startdate,
	updatedby = 'CDM-32987',
	updatedon = now()	
where gapsuspensionid  = '3c37dbc6-4a47-460f-83c5-5798db792ee7' 
	and activeflag = 1 ;

select gapsuspensionrevisionid, suspensionid, startdate, enddate, activeflag, updatedby, updatedon 
from gapsuspensionrevision 
where suspensionid  = '3c37dbc6-4a47-460f-83c5-5798db792ee7' ;
	
update gapsuspensionrevision
set enddate = startdate,
	approvaldate = now(),	
	updatedby = 'CDM-32987',
	updatedon = now()
where suspensionid  = '3c37dbc6-4a47-460f-83c5-5798db792ee7' ;
	
-- Update Account Receivable linked Payment ID as 4664624 (old value 4630446)	
select receivable_detail_id, payment_detail_id, start_dt, end_dt, receivable_ts, update_ts, update_user_id 
	from tb_receivable_detail 
where receivable_detail_id = 1732483
	and delete_sw = 'N' ;

update tb_receivable_detail 
set payment_detail_id = 4664624,
	update_user_id = 'CDM-32987',
	update_ts = now()
where receivable_detail_id = 1732483
	and delete_sw = 'N' ;

