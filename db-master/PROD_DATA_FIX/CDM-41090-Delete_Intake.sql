/*
 * CDM-41090 - Deleting a Intake
 * Customer Email ID:theresa.kleppinger@maryland.gov
 * delete this intake :I241013024520
 * Description - I241013024520:Please Delete this Intake.
 * 
 */

update intakedastaging 
set activeflag =0, updatedby ='CDM-41090', updatedon =now()
where intakenumber ='I241013024520' and activeflag =1;

update intakeservicerequest 
set activeflag =0, updatedby ='CDM-41090', updatedon =now()
where intakenumber ='I241013024520' and activeflag =1;

update intakedastatus 
set activeflag =0, updatedby ='CDM-41090', updatedon =now()
where intakenumber ='I241013024520' and activeflag =1;

update intakesnapshot  
set activeflag =0, updatedby ='CDM-41090', updatedon =now()
where intakenumber ='I241013024520' and activeflag =1;

update routing  
set activeflag =0, updatedby ='CDM-41090', updatedon =now()
where objectid ='I241013024520' and activeflag =1;