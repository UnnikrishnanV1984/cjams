/*
 * CDM-34797 - Double submission of closure
 * Customer Email ID:elizabeth.orff@maryland.gov
 * Customer Name:Elizabeth Orff
 * Focus Area:Decision
 * Description - 3188510:When Eboni Williams closes a case it is submitting twice. This is the third or fourth time this has occurred.
 * Case has been closed on 10/12/2023, 10:08 AM and please remove the duplicate case closure under review status.
 * 
 */

select 	activeflag, routingstatustypeid, * 
from 	routing 
where 	servicerequestnumber = '3188510' and activeflag =1 and objectid = '4aff5826-082f-407f-8cdf-0063eb4689fb';

update 	routing
set 	activeflag = 0,
		updatedby = 'CDM-34797',
		updatedon = now()
where 	routingid = '90e29e9a-ff2b-4298-8918-fed981831f5f' and activeflag = 1; 

select activeflag, * from servicecasedisposition where servicecasedispositionid = '4aff5826-082f-407f-8cdf-0063eb4689fb';
UPDATE cjams.servicecasedisposition
SET activeflag=0, updatedby = 'CDM-34797', updatedon = now() 
WHERE servicecasedispositionid='4aff5826-082f-407f-8cdf-0063eb4689fb';

