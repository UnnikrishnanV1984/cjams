-- CDM-17829 - Deletion
/*
-- Issue Description: 
	User request to expunge the following CPS-IR 2141944 (Converted Indicated Investigation)
	Reason for deletion: The record and archive has no record of the investigation. 
	The record needs to be deleted in CJAMS.
		   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR: CW2141944 - afa1d097-bd0f-4904-a9f8-33714fd79b9b

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2141944'::character varying,
		null::date
	) ;
