-- CDM-10821 - remove intake

update intakedastatus set activeflag=0, updatedby ='CDM-10821', updatedon = now() where intakedastatusid='9b0ece92-31bd-4305-b94a-a755b3543a1b' and activeflag=1;
update intakesnapshot set activeflag=0, updatedby ='CDM-10821', updatedon = now() where intakesnapshotid ='ae8214eb-cfcf-4708-aa60-f9aaf2b3456e' and activeflag=1;
update intakeservicerequest set activeflag=0, updatedby ='CDM-10821', updatedon = now() where intakeserviceid ='60c8954a-ff84-442f-875e-1a3cf99607a3' and activeflag=1;
