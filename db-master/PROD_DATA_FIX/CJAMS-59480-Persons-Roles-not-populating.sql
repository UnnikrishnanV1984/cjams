-- CJAMS-59480 - person role not populating
/*
-- Issue Description: 
--  251023047204:In this case, whenever I try to change the roles of the household members,
    it either acts like it saves and then refreshes and reverts the changes immediately, or it will only populate with ICC and not the other roles that should be there.

-- Category/ Module: Person profile
-- Root cause: wrong actorid was mapped
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 1712393 Head of Household, Initial Contact Caregiver, Alleged Maltreater, Legal Guardian, Relative

update actor 
set activeflag = 0,
	updatedby = 'CJAMS-59480',
	updatedon = now() 
where actorid = 'c62d6610-419c-4ed9-9bbd-267acfb67323'
and activeflag  = 1;


update intakeservicerequestactor 
set updatedby = 'CJAMS-59480',
	actorid = '2ab5c935-3edc-4954-8e5c-45eccb9d15a1',
	updatedon = now() 
where personid = '77893ad2-0e75-4d93-a8fc-7088d5ebca59' and activeflag =1
and intakeserviceid ='8ded6326-6e28-4f47-9e7d-8e815a89cd70' and actorid = 'c62d6610-419c-4ed9-9bbd-267acfb67323';

-- 1865418 - Alleged Maltreater, Legal Guardian, Initial Contact Caregiver
update actor 
set activeflag = 0,
	updatedby = 'CJAMS-59480',
	updatedon = now() 
where actorid = 'c43ab44b-ad94-412b-95a7-8d75bc2d8cb6'
and activeflag  = 1;

update intakeservicerequestactor 
set updatedby = 'CJAMS-59480',
	actorid = '506177e8-f779-4c1b-83fe-7f1efbcf440f',
	updatedon = now() 
where personid = 'dd271280-5146-4980-9991-4c8bc21215ed' and activeflag =1 
	and intakeserviceid ='8ded6326-6e28-4f47-9e7d-8e815a89cd70' and actorid = 'c43ab44b-ad94-412b-95a7-8d75bc2d8cb6';
