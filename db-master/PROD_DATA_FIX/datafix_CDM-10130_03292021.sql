-- CDM-10130 Delete Investigation

/*
-- Issue Description: 
	User request to expunge CPS-IR: CW2156689
	User is requesting to expunge this CPS as the case has past the 25 years of record retention timeline.
       
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD, CJAMS is currently not expunging the Indicated CPS-IRs with NO Maltreatment/Allegation & Findings (MD CHESSIE migrated data).
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- CPS-IR:  CW2156689
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2156689'::character varying,
		null::date
	) ;


