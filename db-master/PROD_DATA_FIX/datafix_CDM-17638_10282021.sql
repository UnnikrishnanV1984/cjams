-- CDM-17638 - Deletion
/*
-- Issue Description: 
	User request to expunge the following CPS-IR CW2134160 (Converted Indicated Investigation)
	Reason for deletion: The record and archive has no record of the investigation. 
	The record needs to be deleted in CJAMS.
		   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR: CW2134160 - 61a951ed-7acf-4f52-ac03-acc1a195c5bc

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2134160'::character varying,
		null::date
	) ;
