-- CDM-32902 - GAP rate - pyament issue
/*
-- Issue Description: 
	User request to fix the GAP Rate slabs and generate the missing payments
    
-- Case ID: 3205038
-- Client ID: 3286009 (JULIUS FITZGERALD ROBINSON) - e9bae53f-5685-4aa3-b597-489744407eb5
-- GAP ID: 4788 - 2018-02-28 To 2027-10-26 - 24efc465-d29e-4789-8e30-7dc834b673cb
-- Provider ID: 6001946	(Marshall  Cabell)
-- Agreement ID: 68c1f699-505f-4adb-9a66-e0ed785ccff6
-- Rates:
-- Delete 
-- 47260bd3-878c-4ad6-9f58-14259eb119c6	2022-02-05 15:00:00	2022-02-05 05:00:00	700
-- Update end date as 2022-01-31 10:00:00 
-- 2ee17a2e-cf14-405e-840e-44d1864fc34d	2021-02-05 00:00:00	2022-02-04 10:00:00	700

-- Client ID: 3286006 (KYNDRA SNOW ROBINSON) - 5bf561c5-a825-4319-8b3c-f180179e78d9
-- GAP ID: 4790 - 2018-02-28 To 2023-12-20 - 433234a6-18e3-499e-8808-c96d3f606d29
-- Provider ID: 6001946	(Marshall  Cabell) 
-- Agreement ID: ccffe644-ec9d-4d61-bc0a-a6410fbe7d96
-- Rates:
-- Delete 
-- 252c5602-8116-4983-b29a-3806fd578f4c	2022-02-05 15:00:00	2022-02-05 05:00:00	700
-- Update end date as 2022-01-31 10:00:00 
-- 95563e2c-e62d-40c1-a038-e953786012df	2021-02-05 00:00:00	2022-02-04 10:00:00	700

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

-- To fix the GAP Rate slabs (CDM-32902)

-- Case ID: 3205038
-- Client ID: 3286009 (JULIUS FITZGERALD ROBINSON) - e9bae53f-5685-4aa3-b597-489744407eb5
-- GAP ID: 4788 - 2018-02-28 To 2027-10-26 - 24efc465-d29e-4789-8e30-7dc834b673cb

-- Delete 
-- 47260bd3-878c-4ad6-9f58-14259eb119c6	2022-02-05 15:00:00	2022-02-05 05:00:00	700
select startdate, enddate, paymentamout, activeflag, updatedby, updatedon, *
	from gapagreementrate
where gapagreementrateid = '47260bd3-878c-4ad6-9f58-14259eb119c6'
	and activeflag = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-32902',
	updatedon = now()
where gapagreementrateid = '47260bd3-878c-4ad6-9f58-14259eb119c6'
	and activeflag = 1 ;

select ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon, *
	from gapratesrevision
where gaprateid = '47260bd3-878c-4ad6-9f58-14259eb119c6'
	and activeflag = 1 ;

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-32902',
	updatedon = now()
where gaprateid = '47260bd3-878c-4ad6-9f58-14259eb119c6'
	and activeflag = 1 ;

select eventcode, routingid, routingstatustypeid, routeddescription, updatedby, updatedon, activeflag
	from routing
where objectid = '47260bd3-878c-4ad6-9f58-14259eb119c6'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-32902',
	updatedon = now()
where objectid = '47260bd3-878c-4ad6-9f58-14259eb119c6'
	and eventcode = 'GARR'
	and activeflag = 1 ;

-- Update end date as 2022-01-31 10:00:00 
-- 2ee17a2e-cf14-405e-840e-44d1864fc34d	2021-02-05 00:00:00	2022-02-04 10:00:00	700
select startdate, enddate, paymentamout, activeflag, updatedby, updatedon
	from gapagreementrate
where gapagreementrateid = '2ee17a2e-cf14-405e-840e-44d1864fc34d'
	and activeflag = 1 ;

update gapagreementrate
set enddate = '2022-01-31 10:00:00',
	updatedby = 'CDM-32902',
	updatedon = now()
where gapagreementrateid = '2ee17a2e-cf14-405e-840e-44d1864fc34d'
	and activeflag = 1 ;

select ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon
	from gapratesrevision
where gaprateid = '2ee17a2e-cf14-405e-840e-44d1864fc34d'
--	and activeflag = 1 
	;

update gapratesrevision
set rateenddate = '2022-01-31 10:00:00',
	approvaldate = now(),
	updatedby = 'CDM-32902',
	updatedon = now()
where gaprateid = '2ee17a2e-cf14-405e-840e-44d1864fc34d'
	-- and activeflag = 1 
	;

-- Client ID: 3286006 (KYNDRA SNOW ROBINSON) - 5bf561c5-a825-4319-8b3c-f180179e78d9
-- GAP ID: 4790 - 2018-02-28 To 2023-12-20 - 433234a6-18e3-499e-8808-c96d3f606d29

-- Delete 
-- 252c5602-8116-4983-b29a-3806fd578f4c	2022-02-05 15:00:00	2022-02-05 05:00:00	700
select startdate, enddate, paymentamout, activeflag, updatedby, updatedon, *
	from gapagreementrate
where gapagreementrateid = '252c5602-8116-4983-b29a-3806fd578f4c'
	and activeflag = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-32902',
	updatedon = now()
where gapagreementrateid = '252c5602-8116-4983-b29a-3806fd578f4c'
	and activeflag = 1 ;

select ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon, *
	from gapratesrevision
where gaprateid = '252c5602-8116-4983-b29a-3806fd578f4c'
	and activeflag = 1 ;

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-32902',
	updatedon = now()
where gaprateid = '252c5602-8116-4983-b29a-3806fd578f4c'
	and activeflag = 1 ;

select eventcode, routingid, routingstatustypeid, routeddescription, updatedby, updatedon, activeflag
	from routing
where objectid = '252c5602-8116-4983-b29a-3806fd578f4c'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-32902',
	updatedon = now()
where objectid = '252c5602-8116-4983-b29a-3806fd578f4c'
	and eventcode = 'GARR'
	and activeflag = 1 ;
	

-- Update end date as 2022-01-31 10:00:00 
-- 95563e2c-e62d-40c1-a038-e953786012df	2021-02-05 00:00:00	2022-02-04 10:00:00	700
select startdate, enddate, paymentamout, activeflag, updatedby, updatedon
	from gapagreementrate
where gapagreementrateid = '95563e2c-e62d-40c1-a038-e953786012df'
	and activeflag = 1 ;

update gapagreementrate
set enddate = '2022-01-31 10:00:00',
	updatedby = 'CDM-32902',
	updatedon = now()
where gapagreementrateid = '95563e2c-e62d-40c1-a038-e953786012df'
	and activeflag = 1 ;

select ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon
	from gapratesrevision
where gaprateid = '95563e2c-e62d-40c1-a038-e953786012df'
--	and activeflag = 1 
	;

update gapratesrevision
set rateenddate = '2022-01-31 10:00:00',
	approvaldate = now(),
	updatedby = 'CDM-32902',
	updatedon = now()
where gaprateid = '95563e2c-e62d-40c1-a038-e953786012df'
	-- and activeflag = 1 
	;

-- Delete Suspension
select gapid, startdate, enddate, suspensionreasontypekey, activeflag, updatedby, updatedon
	from gapsuspension
where gapsuspensionid = 'd346dc53-3942-4f61-90d5-badeeca765da'
	and activeflag = 1 ;

update gapsuspension
set activeflag = 0,
	updatedby = 'CDM-32902',
	updatedon = now()
where gapsuspensionid = 'd346dc53-3942-4f61-90d5-badeeca765da'
	and activeflag = 1 ;
