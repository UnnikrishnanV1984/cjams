-- CDM-20349 Expunge Old Record
/*
-- Issue Description: 
	User request to expunge the following CPS-IR CW2169483 (Converted Indicated Investigation)
	This investigation from 2001 needs to be expunged from the system. 
	Per instructions from Deputy Director, Susan Tyzack, this is to be expunged. 
	This would be considered an AR case by today's terms, and the mother has not had 
	any other indicated findings since this case 20 years ago.

-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: N/A
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 1430835 (SHELLY ANN SMITH) - 0a79f235-a2f9-47d6-9d9a-2cf3b5326473
-- CPS IR: CW2169483 - b66cc4e9-8c83-4c25-a683-8a15e02a3af7
-- Neglect - Indicated	

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2169483'::character varying,
		null::date
	) ;

