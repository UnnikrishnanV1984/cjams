-- CDM-174, CDM-176, CDM-178 
update intakedastaging set activeflag = 0 where activeflag = 1 and intakenumber in (
select distinct intakenumber from intakedastaging id where status = 'pending' and activeflag = 1 
and trunc(updatedon) > '2020-03-26' and    
exists (select 1 from intakeservicerequest ir where ir.intakenumber = id.intakenumber )) 
