-- CDM-14622 -  OOH PA start date and end dates are not correctly displayed
/*
-- Issue Description: 
   User requested to update personprogram start date
   
-- CASE # 2020030203889	 	Client Name : Joseph R Alderman 	CJAMS PID# : 3698831 
-- 		Person Program Area start date to change from 01/08/2021 to 01/07/2021
-- CASE #  202100505174 	Client Name: Shamar Lewis		CJAMS PID#	:	200154009
--		Person Program Area start date to change from 01/05/2021 to 01/04/2021

-- Category/ Module: Placements  (Case Management) 
-- Root cause: User Request
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

--CASE # 2020030203889	CJAMS PID#	:	3698831
select 	startdate, * from personprogramarea
where 	personprogramid = '3fbc7a21-aeb5-4250-a2b2-bb9edca7039b' and activeflag = 1;

update 	personprogramarea
set 	startdate = '2021-01-07 00:00:00',
		updatedby = 'CDM-14622',
		updatedon = now()
where 	personprogramid = '3fbc7a21-aeb5-4250-a2b2-bb9edca7039b' and activeflag = 1;

-- placement and placementrevision data looks good

-- CASE #  202100505174 	CJAMS PID#	:	200154009
select 	startdate, * from personprogramarea
where 	personprogramid = '0abe7170-52ac-44a7-bea0-2d00aeb04cff' and activeflag = 1;

update 	personprogramarea
set 	startdate = '2021-01-04 00:00:00',
		updatedby = 'CDM-14622',
		updatedon = now()
where 	personprogramid = '0abe7170-52ac-44a7-bea0-2d00aeb04cff' and activeflag = 1;

-- placement and placementrevision data looks good

