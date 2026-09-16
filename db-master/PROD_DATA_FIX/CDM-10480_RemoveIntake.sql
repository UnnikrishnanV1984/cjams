-- CDM-10480 - Remove Intake

update intakedastaging set activeflag=0 where intakenumber='I202100529003' and activeflag=1;
update intakedastatus set activeflag=0 where intakenumber='I202100529003' and activeflag=1;