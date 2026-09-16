/*
-- CDM-42650 - Expungement Request
-- Issue Description: 
	CW2947615:A request for the closed records was made in which they could not be located. 
	So upon further review of the case by adminstration, which includes the AD Stephanie Cooke, the records should be expunged at this time-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: 	User request To Expunge Case CW2947615 as Assistant Deputy Director, Stephanie Cooke has approved this request..
-- Fix Provided: Datafix has been promoted to update expunge the # CW2947615
-- Pull request# N/A 
-- Reason why no related code fix: For expunging the case, it needs to be dealed with the run of SQL batch.
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2947615'::character varying,
		null::date
	) ;