-- CDM-7796 - GAP data issue (Removal of end date)
/*
-- Issue Description: 
   Datafix to update GAP dates and remove suspension (MD CHESSIE data issue)

   GAP ID: 5230 - Case ID : 3277272 - Client ID: 3296995
	  
-- Category/ Module: GAP (Case Management) 
-- Root cause: Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- GAP Agrrement Dates
-- Before 
select old_id, startdate, enddate, signaturedate, guardianonedate, guardiantwodate,  updatedby, updatedon , ldssdate
	from gapagreement 
where gapid = '56735f3b-3fc4-4bf2-bc68-60cddf659833' 
	and activeflag = 1 ;

-- Update
update gapagreement
	set startdate = '2019-09-10 00:00:00', 
		enddate = '2030-05-28 00:00:00', 
		signaturedate = '2019-05-21 00:00:00', 
		guardianonedate = '2019-05-21 00:00:00.000', 
		ldssdate  = '2019-05-21 00:00:00.000', 
		guardiantwodate = NULL, 
		updatedby = 'CDM-7796', 
		updatedon = now()
where gapid = '56735f3b-3fc4-4bf2-bc68-60cddf659833' 
	and activeflag = 1 ;


-- Gap Suspension
-- Before 
select activeflag, updatedby, updatedon, startdate, enddate
	from gapsuspension 
where gapsuspensionid = 'b8f44b56-d36e-4bbe-bede-9f08011ba113' 
	and activeflag = 1 ;

-- Update
update gapsuspension  
	set	enddate = startdate, 
		activeflag = 0,
		updatedon = now(), 
		updatedby = 'CDM-7796'
where gapsuspensionid = 'b8f44b56-d36e-4bbe-bede-9f08011ba113' 
	and activeflag = 1 ;

	
-- To trigger Under/Over	
insert into gapratesrevision
(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, 
	"comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, 
	insertedby, updatedon, updatedby, activeflag, gaprateid, 
	guardiansubsidyid, providerid, etl_userid, etl_load_date
)
values
(	gen_random_uuid(), now(), '2019-09-10 00:00:00', '2020-09-09 00:00:00', 852.00, 
	'Data fix', '3047', now(), false, now(), 
    'CDM-7796', now(), 'CDM-7796', 1, '8538fa29-9443-4ae2-bf7c-c2ee948d9c7b', 
     '56735f3b-3fc4-4bf2-bc68-60cddf659833', 5087303, NULL, NULL
);
