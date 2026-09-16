-- CDM-10582 - Remove case and associated Intake

update intakesnapshot set activeflag=0, updatedby = 'CDM-10582', updatedon = now() where intakesnapshotid='ab7e7011-f42f-4fde-ad7f-077d90c8ce61' and activeflag =1;
update intakedastaging set activeflag=0, updatedby = 'CDM-10582', updatedon = now() where intakenumber='I202000456725' and activeflag =1;
update intakeservicerequest set activeflag=0, updatedby = 'CDM-10582', updatedon = now() where intakeserviceid='180d7014-c70e-466e-9b98-371762da5bc3' and activeflag =1;
   