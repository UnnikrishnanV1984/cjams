
/*
   Issue Description: CDM-18479
   Category/ Module  : Removing the Intake Referrals
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


UPDATE IntakeDAStaging SET activeflag = 0,updatedby = 'CDM-18479',updatedon = now()
WHERE intakenumber in
('I211010213093',
'I211010210095',
'I211010161505',
'I202100448273',
'I202000493588') and activeflag = 1;


UPDATE intakesnapshot 
	SET updatedby = 'CDM-18479', updatedon = now(), activeflag = 0
	WHERE intakenumber in
('I211010213093',
'I211010210095',
'I211010161505',
'I202100448273',
'I202000493588') and activeflag = 1;

	update intakeservicerequest 
	set activeflag = 0, 
		updatedby = 'CDM-18479', 
		updatedon = now() 
	where intakenumber in
('I211010213093',
'I211010210095',
'I211010161505',
'I202100448273',
'I202000493588') and activeflag = 1;


	update intakedastatus 
	set 
		activeflag = 0,
		updatedby = 'CDM-18479',
		updatedon = now()
	where intakenumber in
('I211010213093',
'I211010210095',
'I211010161505',
'I202100448273',
'I202000493588') and activeflag = 1;

update routing 
	set 
		activeflag = 0,
		updatedby = 'CDM-18479',
		updatedon = now()
	where objectid in
('I211010213093',
'I211010210095',
'I211010161505',
'I202100448273',
'I202000493588') and activeflag = 1;

