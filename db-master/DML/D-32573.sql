update intakeservreqchildremoval
set removaltime = 	(concat(date(removaldate), ' ', substring(removaltime,11,9))) ::timestamp without time zone,
	updatedon = now(), updatedby = 'Datafix user as per D-32573'
where date(removaldate) <> date(removaltime) ;