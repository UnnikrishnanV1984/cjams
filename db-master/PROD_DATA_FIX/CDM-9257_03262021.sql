-- CDM-9257 Deletion
/*
-- Issue Description: 
	User request to expunge the following Case
    CW2152907 - the 25 years record retention for this case has passed. 
	Records retention for indicated investigation is only for 25 years. 
	The case has already been deleted from the CIS.  
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD, CJAMS is currently not expunging the Indicated CPS-IRs with NO Maltreatment/Allegation & Findings (MD CHESSIE migrated data).
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- CPS-IR	CW2152907
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2152907'::character varying,
		null::date
	) ;

