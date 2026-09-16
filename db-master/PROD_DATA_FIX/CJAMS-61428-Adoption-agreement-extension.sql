/*
Issue Description:CJAMS-61428 3166976:Need to extend subsidy date to 7/31/28 Screen URL:
Category/Module: Adoption Subsidy 
Root cause: The agreement end date need to be updated as 07/31/2028.
            We have implemented the user story "B-195079 - Maintenance Payments" to production. 
            As per system design, the adoption agreement can not be updated/edited if the bio child placement exit date is overlapping with the adoption agreement start date. 
            In this case, the adoption agreement start date is entered prior to the bio placement exit date.
            This is a know in issue and a user story is created for the same.
Fix provided: Data fix has been done to update the adotion subsidy end date as 07/31/2028 for the case 3166976.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is a know issue and User story is created to address it.
*/

update adoptioncaseagreement 
set enddate = '2028-07-31 00:00:00',
    agreementtyperefid = 'STAAA',
    parent1providerid = 5020885,
    parent1providername = 'Kelly Jones',
    parent2providerid = '5020885',
    parent2providername = 'Matt  Jones',
    childplacedby = 'iveag',
	updatedby = 'CJAMS-61428',
	updatedon = now()
where adoptionagreementid='a79d194f-83ad-4e73-8070-812ae9c040ad'
and activeflag = 1;

-- To Trigger the payments batch
update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-61428'
where adoptionagreementrateid = '508dfae0-c414-4638-bd6f-10dd5e65a9b3'
and activeflag = 1;    


update adoptioncase
set enddate = '2028-07-31 00:00:00',
	updatedby = 'CJAMS-61428',
	updatedon = now()
where adoptioncaseid='a79d194f-83ad-4e73-8070-812ae9c040ad'
and activeflag = 1;