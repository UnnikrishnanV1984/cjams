/*
 * CDM-32516 - Remove case
 * Description - 3171079:Please remove 3171079 from case connect. It was case connected to 231020577849 by accident. 
 * Screen URL: https://cw.cjams.mdthink.maryland.gov/#/pages/case-worker/51ebc84c-9c7c-4116-99e1-6d2ce7c7706b/3171079/dsds-action/person-cw/list
 * Customer Email ID:nikki.robey@maryland.gov
 */

-- I231010645827
-- CPS-AR - 544994ae-79d1-41f1-ac32-00fe97b59ede
-- Case ID: 3171079 - 51ebc84c-9c7c-4116-99e1-6d2ce7c7706b
--select servicerequestnumber, * from intakeservicerequest where  intakenumber = 'I231010645827'

-- Nullify servicecaseid
select activeflag, intakeserviceid, servicecaseid, intakenumber, actiontype, servicecaseid, updatedby, updatedon
from intakeservicerequest
where servicerequestnumber = '231020577849'
and activeflag = 1 ;

UPDATE cjams.intakeservicerequest
SET servicecaseid=null, updatedby='CDM-32516', updatedon=now() 
WHERE intakeserviceid='544994ae-79d1-41f1-ac32-00fe97b59ede';


-- Nullify servicecaseid
select activeflag, servicecaseid, intakenumber, intakeserviceid, insertedon, insertedby, updatedby, updatedon
from actor
where intakeserviceid = '544994ae-79d1-41f1-ac32-00fe97b59ede'
and servicecaseid = '51ebc84c-9c7c-4116-99e1-6d2ce7c7706b'
and activeflag = 1 ;

UPDATE cjams.actor
SET servicecaseid=null, updatedby='CDM-32516', updatedon=now() 
where intakeserviceid = '544994ae-79d1-41f1-ac32-00fe97b59ede'
and servicecaseid = '51ebc84c-9c7c-4116-99e1-6d2ce7c7706b'
and activeflag = 1 ;


-- Nullify servicecaseid
select activeflag, servicecaseid, intakenumber, intakeserviceid, insertedon, insertedby, updatedby, updatedon
from intakeservicerequestactor
where intakeserviceid = '544994ae-79d1-41f1-ac32-00fe97b59ede'
and servicecaseid = '51ebc84c-9c7c-4116-99e1-6d2ce7c7706b'
and activeflag = 1 ;

UPDATE cjams.intakeservicerequestactor
SET servicecaseid=null, updatedby='CDM-32516', updatedon=now() 
where intakeserviceid = '544994ae-79d1-41f1-ac32-00fe97b59ede'
and servicecaseid = '51ebc84c-9c7c-4116-99e1-6d2ce7c7706b'
and activeflag = 1 ;


-- update activeflag = 0
select activeflag, *
from servicecasedisposition
where servicecaseid = '51ebc84c-9c7c-4116-99e1-6d2ce7c7706b'
and servicecasedispositionid = 'fbccb0d9-f4d5-40c0-9f4e-997e8b9e879c';

UPDATE cjams.servicecasedisposition
SET activeflag=0, updatedby='CDM-32516', updatedon=now() 
where servicecaseid = '51ebc84c-9c7c-4116-99e1-6d2ce7c7706b'
and servicecasedispositionid = 'fbccb0d9-f4d5-40c0-9f4e-997e8b9e879c';


-- update activeflag = 0
select activeflag, startdate, enddate, responsibilitytypekey, *
from caseassignment
where objectid = '51ebc84c-9c7c-4116-99e1-6d2ce7c7706b'
and caseassignmentid = '645400f3-1697-42cb-94cf-6e75d946593c';
-- order by insertedon desc

UPDATE cjams.caseassignment
SET activeflag=0, updatedby='CDM-32516', updatedon=now() 
where objectid = '51ebc84c-9c7c-4116-99e1-6d2ce7c7706b'
and caseassignmentid = '645400f3-1697-42cb-94cf-6e75d946593c';

-- Close the Service case
-- update statustypekey = 'Closed',  dispositioncode = 'Closed',  enddate = '2009-03-26 00:00:00',

select servicecasenumber, statustypekey, dispositioncode, enddate, updatedby, updatedon
from servicecase
where servicecasenumber = '3171079'
and activeflag  = 1 ;

UPDATE cjams.servicecase
SET statustypekey='Closed', dispositioncode='Closed', enddate='2009-03-26 00:00:00', updatedby='CDM-32516', updatedon=now() 
where servicecasenumber = '3171079'
and activeflag  = 1 ;
