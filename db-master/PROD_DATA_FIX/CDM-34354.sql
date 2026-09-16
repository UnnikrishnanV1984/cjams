/*
 * CDM-34354 - Case needs expungement 
 * Customer Email ID:lindsey.beck@maryland.gov
 * Customer Name:Lindsey Beck
 * Resolution Comments:Need to submit to SSA for approval
 * Focus Area:Social History
 * Description - Dashboard:This family's case from 2017 should be expunged, as it occurred 6 years ago and there was no case after it, requiring it to remain in CJAMS.
 * CPS AR Case -   CW2889234   for   Expungement. 
 * complete date missing  on the View Program , before expunging the case , completed date as approved on 05/26/2017 10.23am,  then accordingly do the expungement, 
 * find the approval email from SSA asking us the question on date completion and expungement approval
*/

select reporteddate, exitdate,  * from intakeservicerequest where intakeserviceid in ('88439e7e-f2fd-413f-8a3f-0544732b49d8','593a9d3c-c74a-471f-9b3c-de388329cb80');
UPDATE cjams.intakeservicerequest
SET exitdate='2017-05-26 10:23:00.000', updatedby='CDM-34354', updatedon=now() 
WHERE intakeserviceid='593a9d3c-c74a-471f-9b3c-de388329cb80';

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'AR'::character varying,
		'CW2889234'::character varying,
		null::date
	) ;
