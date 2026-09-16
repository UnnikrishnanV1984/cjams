delete from routing where routingid ='0c6ed01d-9d6b-4238-85bc-792d1ce5664d';

UPDATE intakedastaging
SET ispreintake=false, status='pending', updatedon=now(), updatedby='CDM-7952'
WHERE id=903726;

update intakeDAStatus 
set status=1, updatedon=now(), updatedby='CDM-7952'
where intakenumber in ('I202000507471') and intakedastatusid='166ff617-bd62-4769-a5a7-b744b92415c6';
