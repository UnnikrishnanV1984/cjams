/*
-- CDM-42332-Expungement
-- Issue Description: 
	211020132145:211020132145Case should of been expunged 8/16/2023
    -- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: 	User request To Expunge Case 211020132145 as Assistant Deputy Director, Stephanie Cooke has approved this request..
-- Fix Provided: Datafix has been promoted to update expunge the # 211020132145
-- Pull request# N/A 
-- Reason why no related code fix: For expunging the case, it needs to be dealed with the run of SQL batch.
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'211020132145'::character varying,
		null::date
	) ;