-- CDM-13889 3253678
update
	intakeservreqchildremoval
set
	exitdate = '2020-07-16 15:45:00',
	returndate = '2020-07-16 15:45:00',
	returntime = '2020-07-16 15:45:00',
	removalexitreason = 'REUNIF',
	updatedon = now(),
	updatedby = 'CDM-13889'
where removalid = 174562;

-- CDM-13890  3165019
update
	intakeservreqchildremoval
set
	exitdate = '2020-12-03 15:45:00',
	returndate = '2020-12-03 15:45:00',
	returntime = '2020-12-03 15:45:00',
	removalexitreason = 'REUNIF',
	updatedon = now(),
	updatedby = 'CDM-13890'
where removalid = 197502;