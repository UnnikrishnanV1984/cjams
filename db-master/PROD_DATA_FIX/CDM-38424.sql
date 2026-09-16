/*
 * CDM-38424 - Transfer referral glitched
 * Customer Email ID:diana.tyree2@maryland.gov
 * Description - I241012116340:This referral began in Baltimore City a couple of days ago and was screened out. I overrode the referral 
 * today as we received a protective order. CJAMS allowed me to override but then would not allow me to edit it. I requested 
 * Baltimore City transfer the referral to me. They did but then it would not allow me to assign the referral to a worker. 
 * It will not allow me to edit it at all as a supervisor or as a worker. This needs to be accepted. 
 * Diana requested to assign the Intake.
 * 
 */

select * from cjams.routing where objectid  = 'I241012116340'; 
DELETE FROM cjams.routing
WHERE objectid  = 'I241012116340'; 

select * from cjams.administrativeoverrides where entityid = 'I241012116340'; 
DELETE FROM cjams.administrativeoverrides
WHERE entityid = 'I241012116340'; 

select * from cjams.intaketransfers where intakenumber = 'I241012116340'; 
UPDATE cjams.intaketransfers
SET receivingcountyworker='47dc653d-9089-4b47-b40e-0168ef6c2321'::uuid 
WHERE intakenumber='I241012116340'; 

select * from intakedastatus where intakenumber = 'I241012116340' and activeflag =1; 
UPDATE cjams.intakedastatus
SET status=null, updatedby='47dc653d-9089-4b47-b40e-0168ef6c2321', insertedby='47dc653d-9089-4b47-b40e-0168ef6c2321', intakeuser='47dc653d-9089-4b47-b40e-0168ef6c2321' 
WHERE intakenumber = 'I241012116340';

select * from v_userprofile where email  = 'diana.tyree2@maryland.gov';
select * from intakedastaging where intakenumber = 'I241012116340' AND activeflag=1;
select * from county where countyname = 'Baltimore County';
update intakedastaging
set jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'Author' || jsonb(json_build_object('Author','DianaTyree') )
from intakedastaging i 
where intakenumber = 'I241012116340' and activeflag = 1)))
from intakedastaging i2
where intakenumber = 'I241012116340' and activeflag = 1)
where intakenumber = 'I241012116340' and activeflag = 1; 

update intakedastaging
set jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'countyid' || jsonb(json_build_object('countyid','1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b') )
from intakedastaging i 
where intakenumber = 'I241012116340' and activeflag = 1)))
from intakedastaging i2
where intakenumber = 'I241012116340' and activeflag = 1)
where intakenumber = 'I241012116340' and activeflag = 1; 

SELECT * from cjams.intakeservicerequest where intakenumber = 'I241012116340' and activeflag = 1;
UPDATE cjams.intakeservicerequest  
SET activeflag=0 
where intakenumber = 'I241012116340' and activeflag = 1; 

