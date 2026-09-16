/*
-- Issue Description: 
	User request to expunge the CPS-IR 
     SSA approved on 08/11/2026 and please expunge below cases;

CW2559783
CW2587666
221020195096
221020208104 (Converted Indicated Investigations)
	   
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: CIS Converted Investigation with No information about maltreator or the maltreatment/allegation.
--			   CJAMS is not expunging such converted investigations with automated batch.
-- Fix provided: Datafix has been promoted to expunge the CPS IR case.
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2559783'::character varying,
		null::date
	) ;


    select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2587666'::character varying,
		null::date
	) ;


    select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'221020195096'::character varying,
		null::date
	) ;


    select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'221020208104'::character varying,
		null::date
	) ;

