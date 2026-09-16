
/*
   Issue Description: CJAMS-61774
   Category/ Module  :  updating primary caregiver 
   Root cause: User Request, Old migrated data missing the primary caregiver info.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval
set primarycaregiverid = 201507114,
	primarycaregiveractorid = 'fc537a23-926e-4039-92c3-419a46e65260',
	updatedby = 'CJAMS-61774',
	updatedon =  now()
where intakeservreqchildremovalid = '983755b8-6590-4c27-bd5e-2ea0eb32b374';