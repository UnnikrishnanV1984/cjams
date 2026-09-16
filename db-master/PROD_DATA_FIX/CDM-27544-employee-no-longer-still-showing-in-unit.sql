/*
   Issue Description: CDM-27544
   Category/ Module  : Employee no longer -still showing in unit
   Root cause: user requested to delete user and change unit name
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


UPDATE
    team
SET
    teamname = 'Foster Care',
    updatedby = 'CDM-27544',
    updatedon = now()
WHERE
    countyid = 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a'
    AND teamname = 'Foster Care/Family Preservation'
    AND activeflag = 1;

UPDATE
    team
SET
    teamname = 'In Home Services Unit',
    updatedby = 'CDM-27544',
    updatedon = now()
WHERE
    countyid = 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a'
    AND teamname = 'In Home Services Unit 2'
    AND activeflag = 1;


update
    teammember
set
    activeflag = '0',
    updatedby = 'CDM-27544',
    updatedon = now()
where
    teammemberid = '0716ca1d-3835-4cde-ac0e-be4b1403b728';

update
    teammemberassignment
set
    activeflag = '0',
    updatedby = 'CDM-27544',
    updatedon = now()
where
    securityusersid = '67f2f120-39f6-484b-b0a5-56e6440b7ce3';

update
    muser
set
    activeflag = '0',
    updatedby = 'CDM-27544',
    updatedon = now()
where
    securityusersid = '67f2f120-39f6-484b-b0a5-56e6440b7ce3';

update
    userprofile
set
    activeflag = '0',
    updatedby = 'CDM-27544',
    updatedon = now()
where
    securityusersid = '67f2f120-39f6-484b-b0a5-56e6440b7ce3';

update
    rolemapping
set
    activeflag = '0',
    updatedby = 'CDM-27544',
    updatedon = now()
where
    principalid = '4149';

update
    securityusers
set
    activeflag = '0',
    updatedby = 'CDM-27544',
    updatedon = now()
where
    securityusersid = '67f2f120-39f6-484b-b0a5-56e6440b7ce3';