-- CDM-10129 - Record deletion
/*
-- Issue Description: 
	User request to expunge the following Case
	CW2167286 Reason for deletion: record retention policy. 
       
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD, CJAMS is currently not expunging the Indicated CPS-IRs with NO Maltreatment/Allegation & Findings (MD CHESSIE migrated data).
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- CPS-IR	CW2167286
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2167286'::character varying,
		null::date
	) ;

