-- CDM-12871 - Record Deletion
/*
-- Issue Description: 
	User request to expunge the following CPS IRs:
	CW2188941, CW2140413 & CW2188304
	
	Reason for deletion: the investigation record has reached its 25 years of record-keeping policy. 
	Therefore, the record needs to be deleted in CJAMS. 
	NOTE: the record from CIS has already been deleted.
       
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/
	
-- CPS-IR: CW2188941 - d9ece034-b267-451c-9818-f074e2fdea33
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2188941'::character varying,
		null::date
	) ;

-- CPS-IR: CW2140413 - d32125ce-fe7a-461f-957e-b893474bcdc3
-- Converted Data no AM
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2140413'::character varying,
		null::date
	) ;

-- CPS-IR: CW2188304 - f2852bdb-b32c-4993-8510-4d87ad434db3
-- Converted Data no AM
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2188304'::character varying,
		null::date
	) ;

