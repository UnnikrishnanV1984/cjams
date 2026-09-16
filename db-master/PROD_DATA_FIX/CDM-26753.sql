update intakedastaging set activeflag = 0,
updatedby = 'CDM-26753', updatedon = now()
where intakenumber = 'I221010272762' and activeflag = 1;

update intakedastatus set activeflag = 0,
updatedby = 'CDM-26753', updatedon = now()
where intakenumber = 'I221010272762' and activeflag = 1;

/** No Service Case **/
select * from intakeservicerequest
where intakenumber = 'I221010272762';