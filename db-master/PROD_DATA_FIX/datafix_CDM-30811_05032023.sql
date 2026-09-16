-- CDM-30811 - Change CPS Finding
/*
-- Issue Description: 
   User request to update CPS finding from Indicated to Ruled Out. (Received the SSA approval)
   CPS IR: CW2785140 - f957a00b-c7c0-428c-ad47-e72c713707ee
	   
-- Category/ Module: Intake/Investigation Management
-- Root cause: CPS IR case, beyond the given timeframe to change the finding (appeal process time elapsed).
-- Fix provided: Datafix has been promoted to update the finding as Ruled Out and expunge the CPS case.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2785140 - f957a00b-c7c0-428c-ad47-e72c713707ee
-- ID - Indicated --> RO - Ruled Out
select investigationfindingid, investigationfindingtypekey , activeflag , updatedby , updatedon, fk_r_id   
	from investigationfinding
where investigationallegationid  = 'f898ebe5-e4b7-4932-801a-017f574c5995'
	and activeflag = 1;
 
update investigationfinding 
set investigationfindingtypekey = 'RO',
    updatedby = 'CDM-30811',
    updatedon = now()
where investigationallegationid  = 'f898ebe5-e4b7-4932-801a-017f574c5995'
	and activeflag  = 1;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2785140'::character varying,
		null::date
	) ;	