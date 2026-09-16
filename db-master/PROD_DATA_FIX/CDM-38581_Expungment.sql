/*
-- CDM-38581 - Expungement Request
-- Issue Description: 
	User request To Expunge Case CW2861173 as Assistant Deputy Director, Stephanie Cooke has approved this request..
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: User Error
-- Fix Provided: Datafix has been promoted to update expunge the # CW2861173
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2861173'::character varying,
		null::date
	) ;