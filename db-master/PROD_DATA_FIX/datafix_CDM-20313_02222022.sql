-- CDM-20313 - Payment is not interfacing / rate date is entered
/*
-- Issue Description: 
   Payment is not interfacing in the system and subsidy rate entered twice .
   Datafix to Remove the GAP Suspension as reuested by the user.
   
--	Case ID: 3293316
--	Client ID: 4289405 (MASIAH MCLEAN)
--	GAP ID: 1005941 - 11/22/2021 To 08/15/2036 - e1160dc6-b1bb-4fc0-94fc-98046d887d1c
--	Provider ID: 6004971 (MONICA WHITE)

-- Category/ Module: GAP (Case Management) 
-- Root cause: Date Issue (GAP Suspension with no routing record) 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete GAP Suspension
select gapid, startdate, enddate, activeflag, updatedby, updatedon 
    from cjams.gapsuspension 
where gapsuspensionid  = 'c172f857-eb3c-447c-8249-28d5fe60d4e5'
	and activeflag  = 1 ;

update cjams.gapsuspension  
set enddate = startdate,
	activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-20313'
where gapsuspensionid  = 'c172f857-eb3c-447c-8249-28d5fe60d4e5'
	and activeflag  = 1 ;
	
select guardiansubsidyid, gapsuspensionrevisionid, startdate, enddate, approvaldate, approvalstatustypekey, updatedby, updatedon 
	from gapsuspensionrevision
where suspensionid = 'c172f857-eb3c-447c-8249-28d5fe60d4e5'
	and activeflag  = 1 ;

	
update cjams.gapsuspensionrevision  
set enddate = startdate,
	activeflag = 0,
	approvaldate = now(),
	updatedon = now(), 
	updatedby = 'CDM-20313'
where suspensionid = 'c172f857-eb3c-447c-8249-28d5fe60d4e5'
	and activeflag  = 1 ;

select routingid, eventcode, remarks, activeflag, updatedby, updatedon 
	from routing  
where objectid = 'c172f857-eb3c-447c-8249-28d5fe60d4e5'
	and activeflag  = 1 ;
	
update routing	
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-20313'
where objectid = 'c172f857-eb3c-447c-8249-28d5fe60d4e5'
	and activeflag  = 1 ;
	
-- Delete duplicate GAP Rate
select gapagreementid, startdate, enddate, paymentamout, activeflag, updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '80a16b2a-f12d-4619-b675-79e7058a11aa'
	and activeflag = 1 ;
	
update gapagreementrate
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-20313'
where gapagreementrateid = '80a16b2a-f12d-4619-b675-79e7058a11aa'
	and activeflag = 1 ;
	
select gaprateid, ratestartdate, rateenddate, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid = '80a16b2a-f12d-4619-b675-79e7058a11aa'
	and activeflag = 1 ;	
		
update gapratesrevision		
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-20313'
where gaprateid = '80a16b2a-f12d-4619-b675-79e7058a11aa'
	and activeflag = 1 ;	
				
select routingid, eventcode, remarks, activeflag, updatedby, updatedon 
	from routing  
where objectid = '80a16b2a-f12d-4619-b675-79e7058a11aa'
	and activeflag  = 1 ;
	
update routing	
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-20313'
where objectid = '80a16b2a-f12d-4619-b675-79e7058a11aa'
	and activeflag  = 1 ;
				
-- To Trigger Under Over 
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision 
where gaprateid = '9fb694fa-e4b3-410a-a032-0dbd4a9a644d'
	and activeflag = 1 ;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-20313',
	updatedon = now()
where gaprateid = '9fb694fa-e4b3-410a-a032-0dbd4a9a644d'
	and activeflag = 1 ;
