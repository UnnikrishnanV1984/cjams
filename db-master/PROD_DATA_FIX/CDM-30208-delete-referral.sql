
/*
   Issue Description: CDM-30208
   Category/ Module  :intake referral
   Root cause: User wants to remove  referral
   Reason why no related code fix:  Data fix
   PR # : 
*/
update
	intakedastaging
set
	activeflag = 0,
	updatedby = 'CDM-30208',
	updatedon = now()
where
	intakenumber = 'I221010264391'
	and activeflag = '1';

update
	intakedastatus
set
	activeflag = 0,
	updatedby = 'CDM-30208',
	updatedon = now()
where
	intakenumber = 'I221010264391'
	and activeflag = '1'
	and intakedastatusid = 'ea5ab65c-5af4-47c5-970e-ef30f16a479c';