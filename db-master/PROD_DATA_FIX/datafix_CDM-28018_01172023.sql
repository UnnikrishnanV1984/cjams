-- CDM-28018 - Expungement
/*
-- Issue Description: 
	User request To Expunge Cases CW2411965, CW2310235 and CW2710297.

-- CPS-IR	CW2310235	1a96afe1-b409-4a1f-b6e1-77a08c077f03
-- CPS-IR	CW2411965	b55c84be-7892-4803-968a-d03afd9dd9ab
-- CPS-IR	CW2710297	c0a6ef7c-c733-4083-8c62-e2ec576de4a3
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD, these are migrated CPS-IR cases and should have been expunged by now.
-- Fix Provided: Datafix has been promoted to update expunge the CPS-IRs CW2310235, CW2411965 & CW2710297 cases.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS-IR - CW2310235 - 1a96afe1-b409-4a1f-b6e1-77a08c077f03
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2310235'::character varying,
		null::date
	) ;

-- CPS-IR -	CW2411965 - b55c84be-7892-4803-968a-d03afd9dd9ab
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2411965'::character varying,
		null::date
	) ;
	
-- CPS-IR - CW2710297 - c0a6ef7c-c733-4083-8c62-e2ec576de4a3
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2710297'::character varying,
		null::date
	) ;
	
