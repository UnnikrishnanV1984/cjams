/*
 Issue Description:  CDM-44112
 Category/ Module:  Person Programs
 Root cause: end date the adoption subsidy agreement
 Pull request# for code fix: NA
 Reason why no related code fix: NA
 Status of the code fix if already submitted and expected prod fix date: NO
 Backup before update/ delete: NA
 */

 update adoptioncase
set enddate = '2026-05-29 04:00:00',
	updatedon = now(), 
	updatedby = 'CDM-44112'
where adoptioncaseid = '84ee6d56-e0d9-48cc-ae84-30ab0ea20db5';


update adoptioncaseagreement
set enddate = '2026-05-29 04:00:00',
	updatedon = now(), 
	updatedby = 'CDM-44112'
where adoptioncaseid = '84ee6d56-e0d9-48cc-ae84-30ab0ea20db5';