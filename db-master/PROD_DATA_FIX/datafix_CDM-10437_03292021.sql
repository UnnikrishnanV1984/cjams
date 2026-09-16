-- CDM-10437 - Deletion
/*
-- Issue Description: 
	User request to expunge CPS-IR: CW2134734 
	The case needs to be deleted because the physical records had been deleted from the CIS and the record room/archive 
	and the case is more than 25 years. Record policy retention for investigation is only for 25 years 
	anything beyond 25 years should be deleted from the system
       
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD, CJAMS is currently not expunging the Indicated CPS-IRs with NO Maltreatment/Allegation & Findings (MD CHESSIE migrated data).
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- CPS-IR:  CW2134734
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2134734'::character varying,
		null::date
	) ;


