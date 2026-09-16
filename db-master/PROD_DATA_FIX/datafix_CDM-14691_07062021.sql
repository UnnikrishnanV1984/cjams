-- CDM-14691 - Record Deletion
/*
-- Issue Description: 
	User request to expunge the CPS-IR CW2155948 (Converted Indicated)
	Reason for deletion: the investigation record has reached its 25 years of record-keeping policy. 
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR - CW2155948 - 3fa7586b-4127-4612-9fbb-1d00b28c33ed - Converted Indicated
-- with NO Maltreatment/Allegation & Findings (migrated data).

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2155948'::character varying,
		null::date
	) ;
	
/* 
-- For PostgreSQL - EnterpriseDB 10.8.16 
expungcaserequest
 --> cjams.expungcaserequest --> 3rd input parameter --> date(null::date)
 --> changes required PERFORM --> select * from

publishexpungreport --> now()::date --> date(now()::date)
	
*/	