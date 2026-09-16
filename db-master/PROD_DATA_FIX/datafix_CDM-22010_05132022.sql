-- CDM-22010 - Expungement
/*
-- Issue Description: 
	We are unable to locate the paper record for this 2004 CPS investigation. 
	There are no supporting documents in CJAMS. This case should therefore be expunged.
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2149025 - 04e1d540-2b3c-42f1-ab8b-d49acf3612e7
-- Converted : Neglect - Indicated

-- with NO Maltreatment/Allegation & Findings (migrated data).
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2149025'::character varying,
		null::date
	) ;
