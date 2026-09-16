/*
 Issue Description:  CDM-43015
 Category/ Module:  Person Programs
 Root cause: end date the adoption subsidy agreement
 Pull request# for code fix: NA
 Reason why no related code fix: NA
 Status of the code fix if already submitted and expected prod fix date: NO
 Backup before update/ delete: NA
 */


update adoptioncase
set enddate = '2024-12-04 04:00:00.000',
	updatedon = now(), 
	updatedby = 'CDM-43015'
where adoptioncaseid = 'df2230f0-450e-4071-9467-39a2354aa77e' ;


update adoptioncaseagreement
set enddate = '2024-12-04 04:00:00.000',
	updatedon = now(), 
	updatedby = 'CDM-43015'
where adoptioncaseid = 'df2230f0-450e-4071-9467-39a2354aa77e' ;