-- CDM-15622 - Expungement
/*
-- Issue Description: 
	User request to expunge the following CPS-AR CW2861283 needs to be expunged. 
	
	Reason for deletion: Alleged Maltreator(3297477) is not involved in any other subsequent allegations.
       
-- Category/ Module: Intake/Investigation (Expungement)
-- Root cause: TBD
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/
	
-- CPS-AR CW2861283	- a83afd2a-99b5-4e3b-9dae-c380c9baded0
select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2861283'::character varying,
		null::date
	) ;
	

