-- CDM-12331 - Payments
/*
-- Issue Description: 
   The GAP recon was done for the case #3178166 however payments have not generated. 
   
   Case ID: 3178166
   Client ID: 1429406 (JASIAH ISAIAH DUCKWORTH) - c7bd587f-4b98-4643-a17f-74a9cfed5c71
   GAP ID: 3466 - 2017-02-14 to 2021-06-14 - 8d8b9e7a-2694-4656-b43d-3540e72bfb42
   PP ID: 72de277d-4d97-4702-bf4f-fde7dcd93569
   
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: GAP Under Over SP is currently not re-calculating the payments after Agreement extension. 
	sp_under_over_gap was modified to fix this error.	
-- Pull request# ??
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: Next Prod Build
*/

-- To Trigger Under Over
-- 2020-02-14 to 2021-06-14 
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where guardiansubsidyid = '8d8b9e7a-2694-4656-b43d-3540e72bfb42'
	and activeflag = 1 ;

update cjams.gapratesrevision
	set approvaldate = now(),
		updatedby = 'CDM-12331',
		updatedon = now()	
where guardiansubsidyid = '8d8b9e7a-2694-4656-b43d-3540e72bfb42'
	and activeflag = 1 ;

-- 2019-02-14 to 2020-02-13 
INSERT INTO cjams.gapratesrevision
	(	gapratesrevisionid, transactiondate, ratestartdate, rateenddate, 
		paymentamt, "comments", approvalstatustypekey, approvaldate, isoriginal, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		gaprateid, guardiansubsidyid, providerid, alternateid, 
		etl_userid, etl_load_date
	)
VALUES
	(	gen_random_uuid(), '2019-02-14 00:00:00', '2019-02-14 00:00:00', '2020-02-13 00:00:00', 
		965, NULL, '3047', now(), NULL, 
		now(), 'CDM-12331', now(), 'CDM-12331', 1, 
		'a6c2ee99-7622-419a-9d61-20e183231814', '8d8b9e7a-2694-4656-b43d-3540e72bfb42', 5068925, nextval('sequence_gapraterevision'::regclass), 
		NULL, NULL
	);

