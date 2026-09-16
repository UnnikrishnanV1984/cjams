update
	intakeservreqchildremoval
set
	exitdate = '2021-02-03 15:15:00',
	returndate = '2021-02-03 15:15:00',
	returntime = '2021-02-03 15:15:00',
	removalexitreason = 'REUNIF',
	updatedon = now(),
	updatedby = 'CDM-13833'
where removalid in ('195990','195982');


update placement set enddatetime = '2021-02-03 15:15:00', updatedby = 'CDM-13833', updatedon = now() where placementid in ('f6cf878f-35eb-431d-a3ab-b208a63910aa','54e333c0-4cc0-4ca3-bbd8-49086eea17ad') and activeflag = 1;
update placementrevision set exitdate = '2021-02-03 15:15:00', updatedby = 'CDM-13833', updatedon = now() where placementid in ('f6cf878f-35eb-431d-a3ab-b208a63910aa','54e333c0-4cc0-4ca3-bbd8-49086eea17ad') and activeflag = 1;
