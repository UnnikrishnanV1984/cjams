
update intakeservicerequest set activeflag = 0, updatedby = 'CDM-8970', updatedon = now() where intakenumber = 'I202100316599';

update intakedastatus set activeflag = 0, updatedon = now(), updatedby = 'CDM-8970' where intakenumber = 'I202100316599';
