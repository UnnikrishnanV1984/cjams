-- CDM-37234 - CPS Finding Correction
/*	   
-- Category/ Module: Intake/Investigation Management
-- Root cause: CPS IR #CW2126570 has been closed. Finalization date of 9/29/2006 finding needs to be changed to an Unsubstantiated finding.
-- Fix provided: Datafix has been promoted to update the finding as Unsubstantiated and expunge the case.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- CPS IR: CW2126570 - 0e86bb53-e48f-4640-843a-05f789a2e372
-- ID - Indicated --> UD - Unsubstantiated
select investigationfindingid, investigationfindingtypekey , activeflag , updatedby , updatedon, fk_r_id   
	from investigationfinding
where investigationfindingid  = '0423a320-3fdb-4567-bbef-9eaddc525d08'
	and activeflag = 1;

-- UPDATE cjams.investigationfinding
-- SET investigationfindingtypekey='ID', activeflag=1, updatedby='CPA957509', updatedon='2006-11-27 11:45:14.000', fk_r_id='CW2126570'
-- WHERE investigationfindingid='0423a320-3fdb-4567-bbef-9eaddc525d08'::uuid;


update cjams.investigationfinding
 	set investigationfindingtypekey ='UD', updatedby ='CDM-37234', updatedon = now()
 	where investigationfindingid ='0423a320-3fdb-4567-bbef-9eaddc525d08' and activeflag  = 1;


select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'CW2126570'::character varying,
		null::date
	) ;	