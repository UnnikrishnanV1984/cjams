/*
   Issue Description: CIDM-10461
   Category/ Module  : User
   Root cause: As a part of generic fix for teamtypekey getting null issue CDM-41787, some of the duplicate role was created.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update rolemapping
set activeflag = 0,
	updatedby = 'CIDM-10461',
	updatedon = now()
where principalid
in ('10118',
'15041',
'36251',
'42631',
'52085',
'53150',
'7074',
'9502',
'9864',--not by CDM-41787
'9914',
'9956'
)
and activeflag = 1 and teamtypekey = 'CW' and updatedby = 'CDM-41787';