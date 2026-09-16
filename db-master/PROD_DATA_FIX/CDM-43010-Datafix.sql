/*
  Issue Description:  CDM-43010
   Category/ Module  :  SDM
   Root cause: User request to uncheck the SEN and update the narrative accordingly
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: NA
*/

update
	intakesnapshot
set
	jsondata = jsonb_set(jsondata, '{General}', jsonb_set(jsondata->'General', '{Narrative}', '"<p>Initially screened as a SEN and service case assigned. The LDSS engaged with the family to complete the SEN service assessment. Additional information was received from hospital after being screened in, and the LDSS had already engaged with the family, indicating the newborn does not meet SEN criteria (no positive tox result, no effects of prenatal substance exposure, or fetal alcohol spectrum disorder/FASD). Service case#2410304315781 contact note and toxicology results with negative results support Grace Williams PID#204035025 does not meet SEN criteria. The SEN box for Grace Williams PID#204035025 unchecked and resolves CJAMS service ticket#S20240338063152.</p>"')),
	updatedby = 'CDM-43010',
	updatedon = now()
where
	intakenumber = 'I241013183725'
	and activeflag = 1;


update
	intakedastaging
set
	narrative  = '<p>Initially screened as a SEN and service case assigned. The LDSS engaged with the family to complete the SEN service assessment. Additional information was received from hospital after being screened in, and the LDSS had already engaged with the family, indicating the newborn does not meet SEN criteria (no positive tox result, no effects of prenatal substance exposure, or fetal alcohol spectrum disorder/FASD). Service case#2410304315781 contact note and toxicology results with negative results support Grace Williams PID#204035025 does not meet SEN criteria. The SEN box for Grace Williams PID#204035025 unchecked and resolves CJAMS service ticket#S20240338063152.</p>'
	,updatedby = 'CDM-43010',
	updatedon = now()
where
	intakenumber = 'I241013183725'
	and activeflag = 1;


update
	intakeservicerequest
set
	narrative  = '<p>Initially screened as a SEN and service case assigned. The LDSS engaged with the family to complete the SEN service assessment. Additional information was received from hospital after being screened in, and the LDSS had already engaged with the family, indicating the newborn does not meet SEN criteria (no positive tox result, no effects of prenatal substance exposure, or fetal alcohol spectrum disorder/FASD). Service case#2410304315781 contact note and toxicology results with negative results support Grace Williams PID#204035025 does not meet SEN criteria. The SEN box for Grace Williams PID#204035025 unchecked and resolves CJAMS service ticket#S20240338063152.</p>'
	,updatedby = 'CDM-43010',
	updatedon = now()
where
	intakenumber = 'I241013183725';

    update person 
	set substanceexposednewbornflag = null, 
		substanceclasses = null, 
		substanceexposednewbornsourceid = null,
		substanceexposednewbornsourcetypekey = null, 
		substanceexposednewborntimetamp = null, 
		othersubstances = null,
		senstatusflag = null,
		updatedby = 'CDM-43010',
		updatedon = now() 
	where personid = 'a47d6edf-5b81-4da4-98f8-5987cad91317';