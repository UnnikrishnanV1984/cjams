-- CDM-23885 - Gap Agreement unable to be extended
/*
-- Issue Description: 
   The child turned 18 years old on 7/19/2022. 
   The end date on the Guardianship agreement needs to be extended to his 21st birthday on 7/19/2025. 

   There's only one Guardian primary parent and not able to sent for approval because 
   the secondary guardian parent signature date is mandatory. 
   
-- Case ID: 3167002
-- Client ID: 2338744 (NATHAN SANTONI) - 4dc7e65a-a054-4557-9e11-f5900c12fe4d
-- GAP ID: 1100 - 2010-01-27 To 2022-07-19 - ce9b3c86-6f7b-43d9-8292-f182dda4b84a
-- Provider ID: 5039888	(Mirian Santoni)

-- Category/ Module: GAP (Case Management) 
-- Root cause: Legacy (MD CHESIE) Data issue 
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, updatedby, updatedon
from guardianship 
where gapid = 'ce9b3c86-6f7b-43d9-8292-f182dda4b84a'
	and activeflag = 1 ;

update guardianship 
set -- guardianonename = 'Mirian Vieria',
	-- guardianoneid = 106339, -- (approval_person_id -> tb_prov_approval_person )
	-- guardianoneproviderid = 5039888,
	-- primaryrelationshipkey = 'W',
	guardiantwoname = NULL, -- NULL
	guardiantwoid = NULL, -- 106340 (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = NULL, -- 5039888
	secondaryrelationshipkey = NULL, -- W
	updatedby = 'CDM-23885', -- DBCR6172
	updatedon = now() -- 2011-10-19 19:02:39
where gapid = 'ce9b3c86-6f7b-43d9-8292-f182dda4b84a'
	and activeflag = 1 ;
	
-- fix GAP Rate slab more than 365 days issue
select startdate, enddate, updatedby, updatedon, paymentamout, gapagreementrateid 
	from gapagreementrate
where gapagreementrateid = 'c75b182e-06cd-4703-8c01-5a09aaeac9c9'
	and activeflag = 1 ;

update gapagreementrate
set enddate = '2011-01-26 00:00:00', -- '2011-09-30 00:00:00'
	updatedby = 'CDM-23885', -- HCH732910
	updatedon = now() -- 2014-12-01 16:30:16
where gapagreementrateid = 'c75b182e-06cd-4703-8c01-5a09aaeac9c9'
	and activeflag = 1 ;

INSERT INTO cjams.gapagreementrate
	(	gapagreementrateid, gapagreementid, 
		startdate, enddate, paymentamout, 
		isoverride, paymenttypekey, notes, activeflag, effectivedate, 
		insertedby, insertedon, updatedby, updatedon, old_id, 
		provider_id, alternateid, status, negotiateddate, rateapprovaldate, 
		etl_userid, etl_load_date, ssaapprovaldate)
VALUES
	(	gen_random_uuid(), '02b26fbc-3c6b-4d00-b3da-99a2343a38a0', 
		'2011-01-27 00:00:00.000', '2011-09-30 00:00:00.000', 585, 
		true, NULL, 'CHESSIE BUILD CORRECTION..change date', 1, '2011-01-27 00:00:00.000', 
		'CDM-23885', now(), 'CDM-23885', now(), NULL, 
		5039888, nextval('sequence_gapagreementrate'::regclass), 'Approved', NULL, '2011-01-27 00:00:00.000', 
		NULL, NULL, NULL
	);
