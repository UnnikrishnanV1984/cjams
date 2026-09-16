-- CJAMS-59682 Expungement Request

/*
-- Issue Description: 
	SSA is approved TO expunge the case # CW2241094

-- Category/ Module: Persons
-- Root cause: User requested to expunge the case # CW2241094 
-- Resolution: Data fix has been made to expunge the case # CW2241094 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: CJAMS is not expunging such CIS 
   converted investigations with automated batch. 
   So, we are expunging these CIS Investigations with SSA approvals.
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2241094'::character varying,
		null::date
	);


