-- Program assignment validated


update intakeservreqchildremoval 
set exitdate = '2021-02-19 16:30:00', 
	removalexitreason = 'RUF', 
	updatedby = 'CDM-15040', 
	updatedon = now() 
where intakeservreqchildremovalid = 'beb890b6-1165-4b13-800b-aaab711f3939';