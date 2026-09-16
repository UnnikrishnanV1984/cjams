-- CDM-20225 - Expungement section
/*
-- Issue Description: 
	User request to expunge the following CPS-IR CW2207316 (Converted Investigation)
	The case file for Gloria Henry (DOB:8/11/1957) needs to be expunged since the record can't be located. 

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: N/A
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 1593543 (GLORIA HENRY-BROWN) - 9e8c5a3c-ad1c-4231-a937-8c5c6df83f15
-- CPS IR: CW2207316 - da1a37f8-d026-4ada-91ed-c067e9e62b8b
-- Neglect - Indicated	


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2207316'::character varying,
		null::date
	) ;
