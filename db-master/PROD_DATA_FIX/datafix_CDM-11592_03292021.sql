-- CDM-11592 - Record deletion
/*
-- Issue Description: 
	User request to expunge CPS-IR: CW2142319 
	Reason for deletion: the investigation record has reached its 25 years of the record-keeping policy. 
	NOTE: the record from CIS has already been deleted.
       
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD, CJAMS is currently not expunging the Indicated CPS-IRs with NO Maltreatment/Allegation & Findings (MD CHESSIE migrated data).
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- CPS-IR: CW2142319
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2142319'::character varying,
		null::date
	) ;


