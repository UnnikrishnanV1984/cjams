-- CDM-33172 - Gap Subsidy Issue
/*
-- Issue Description: 
	User request to fix GAP rate slabs & suspension dates.
    
-- Case ID: 3183101
-- Client ID: 2881686 (BRODIE LEE GILLELAND) - a01a8f06-ac71-4e41-b6f7-dfca30fc659c
-- GAP ID: 1582 - 2011-03-16 To 2027-10-22 - 2a81a0f3-5028-47fe-a8af-989a60dff02d
-- Provider ID: 6052268	(Donald Willis) 
	
-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to fix the GAP Rates and 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To fix fix GAP rate slabs & suspension dates (CDM-33172)

-- Change the Provider ID for the subsidy rate slab on 07/15/2022 - 05/02/2023 
-- from Provider ID # 6052268 to # 5042496 and rate end date from 05/02/2023 to 05/01/2023
-- 2011554f-a53d-4969-a86a-857add75db34	2022-07-15	2023-05-02

select provider_id, startdate, enddate, paymentamout, activeflag, updatedby, updatedon, *
	from gapagreementrate
where gapagreementrateid = '2011554f-a53d-4969-a86a-857add75db34'
	and activeflag = 1 ;

update gapagreementrate
set provider_id = 5042496, -- 6052268
	enddate = '2023-05-01 04:00:00',
	updatedby = 'CDM-33172',
	updatedon = now()
where gapagreementrateid = '2011554f-a53d-4969-a86a-857add75db34'
	and activeflag = 1 ;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where gaprateid = '2011554f-a53d-4969-a86a-857add75db34' ;

update gapratesrevision
set providerid = 5042496, -- 6052268
	rateenddate = '2023-05-01 04:00:00',
	approvaldate = now(),
	updatedby = 'CDM-33172',
	updatedon = now()
where gaprateid = '2011554f-a53d-4969-a86a-857add75db34' ;


-- Change the current subsidy rate start from 05/03/2023 to 05/02/2023
-- 27177fa8-aa14-4d52-8bc3-e87abb168439	2023-05-03	2024-05-02

select provider_id, startdate, enddate, paymentamout, activeflag, updatedby, updatedon, *
	from gapagreementrate
where gapagreementrateid = '27177fa8-aa14-4d52-8bc3-e87abb168439'
	and activeflag = 1 ;

update gapagreementrate
set startdate = '2023-05-02 08:00:00',
	enddate = '2024-05-01 08:00:00',
	updatedby = 'CDM-33172',
	updatedon = now()
where gapagreementrateid = '27177fa8-aa14-4d52-8bc3-e87abb168439'
	and activeflag = 1 ;

select gapratesrevisionid, providerid, ratestartdate, rateenddate, paymentamt, 
	approvaldate, approvalstatustypekey, updatedby, updatedon 
from gapratesrevision 
where gaprateid = '27177fa8-aa14-4d52-8bc3-e87abb168439' ;

update gapratesrevision
set ratestartdate = '2023-05-02 08:00:00',
	rateenddate = '2024-05-01 08:00:00',
	approvaldate = now(),
	updatedby = 'CDM-33172',
	updatedon = now()
where gaprateid = '27177fa8-aa14-4d52-8bc3-e87abb168439' ;

-- Change the suspension End date to 05/02/2023
-- 2446eec7-abc6-471e-ae00-70a5efce790f	2023-05-02 04:00:00	2023-06-22 04:00:00

select gapsuspensionid, startdate, enddate, activeflag, updatedby, updatedon 
	from gapsuspension 
where gapsuspensionid  = '2446eec7-abc6-471e-ae00-70a5efce790f' 
	and activeflag = 1 ;
	
update gapsuspension
set enddate = startdate,
	updatedby = 'CDM-33172',
	updatedon = now()	
where gapsuspensionid  = '2446eec7-abc6-471e-ae00-70a5efce790f' 
	and activeflag = 1 ;

select gapsuspensionrevisionid, suspensionid, startdate, enddate, activeflag, updatedby, updatedon 
from gapsuspensionrevision 
where suspensionid  = '2446eec7-abc6-471e-ae00-70a5efce790f' ;
	
update gapsuspensionrevision
set enddate = startdate,
	approvaldate = now(),	
	updatedby = 'CDM-33172',
	updatedon = now()
where suspensionid  = '2446eec7-abc6-471e-ae00-70a5efce790f' ;
	
