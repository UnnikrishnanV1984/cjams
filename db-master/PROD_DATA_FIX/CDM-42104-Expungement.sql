/*
-- CDM-42104-Expungement
-- Issue Description: 
	CW2222882:A request for the closed records was made in which they could not be located. 
	So upon further review of the case by adminstration, which includes the AD Stephanie Cooke, the records should be expunged at this time
    -- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: 	User request To Expunge Case CW2222882 as Assistant Deputy Director, Stephanie Cooke has approved this request..
-- Fix Provided: Datafix has been promoted to update expunge the # CW2222882
-- Pull request# N/A 
-- Reason why no related code fix: For expunging the case, it needs to be dealed with the run of SQL batch.
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2222882'::character varying,
		null::date
	) ;