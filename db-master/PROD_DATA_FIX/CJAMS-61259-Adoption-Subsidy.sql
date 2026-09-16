/*
   Issue Description: CJAMS-61259
   Category/ Module  : bug
   Root cause: User Request, the adoption agreement can not be extended as the Bio Placement Exit Date is overlapping with the adoption agreement start date.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
--select enddate ,agreementtyperefid ,childplacedby ,parent2providerid ,parent2signdate ,adoptiveparent2signature, * from adoptioncaseagreement where adoptioncaseid = 'e0b72a6c-806d-44d5-a57a-ae9ca4ae840b'

update adoptioncaseagreement 
set enddate = '2028-10-22 00:00:00',
	parent2providerid = null,--5015102
	parent2signdate = null,--2008-10-08 00:00:00.000
    agreementtyperefid = 'TIAAA',
	childplacedby = 'iveag',
	updatedby = 'CJAMS-61259',
	updatedon = now()
where adoptionagreementid='30e8c9a7-67f6-46b2-8a12-18576d8c0f48'
and activeflag = 1;

--select * from adoptioncaseagreementrate where adoptionagreementid='30e8c9a7-67f6-46b2-8a12-18576d8c0f48'
--and activeflag = 1 order by updatedon desc;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-61259'
where adoptionagreementrateid = '2a1bd8e4-18ae-4577-8e8e-d283bab6bafc'
and activeflag = 1;   

update adoptioncase 
set enddate = '2028-10-22 00:00:00',
	updatedby = 'CJAMS-61259',
	updatedon = now()
where adoptioncaseid ='e0b72a6c-806d-44d5-a57a-ae9ca4ae840b'
and activeflag = 1;