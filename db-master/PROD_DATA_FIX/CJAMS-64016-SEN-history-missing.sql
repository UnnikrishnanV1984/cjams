/*
Issue: CJAMS-64016 SEN history missing wont allow him to be added to case
Category/Module: Person profile
Root cause: There's a SEN History with blank substance class so system will not allow the user to save the person profile as that field is mandatory. 
            Data fix is needed to update the substance class for the below adopted client
            Please update 'Baby - Heroin' as a substance class for the client (both bio and adopted)
            200891838 (Adopted client) - 221040015226 (Adoption case)
            4013921 (bio client) - 3221830 (Bio case)
Fix provided:Data fix has been done  to update the substance class for the below adopted client
            Please update 'Baby - Heroin' as a substance class for the client (both bio and adopted)
            200891838 (Adopted client) - 221040015226 (Adoption case)
            4013921 (bio client) - 3221830 (Bio case)
Data/Code fix ticket#: CJAMS-64016
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is as per the system design and data fix is needed to correct the SEN information.
*/
--4013921(cjamspid)	    4b611796-5aa9-4336-b3ec-5316ff452949 (personid)
--200891838(cjamspid)	535e9468-9536-4420-b00a-4473bd808df9 (personid)

update person
set substanceclasses = '["BHOI"]',
	updatedby = 'CJAMS-64106', 
	updatedon = now()
where personid in ('535e9468-9536-4420-b00a-4473bd808df9','4b611796-5aa9-4336-b3ec-5316ff452949') 
	and activeflag = 1;