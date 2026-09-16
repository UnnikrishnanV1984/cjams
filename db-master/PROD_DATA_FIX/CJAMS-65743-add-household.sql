/*
   Issue Description: CJAMS-65743
   Category/ Module  : persons
   Root cause:Requested to remove quick card (Rina Lopez) asked to add same person as household CJAMS PID 201751366
   Fix type: Data fix is done to remove quick card (Rina Lopez) and added same person as household CJAMS PID 201751366
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:   
*/

update quickperson 
set activeflag =0, updatedby ='CJAMS-65743', updatedon =now()
where quickpersonid ='285febb5-eae3-4c1e-9671-c98c1e77659e';

insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag, intakenumber)
values (gen_random_uuid(), 1, 'c02edbd7-89c2-4c87-bed2-c4ea6bbd8abf', 'PARENT', 'CJAMS-65743', now(), 'CJAMS-65743', now(),
	'N', 'e4d76e11-307c-41f5-b7c3-8374c68ceb57', 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'I261013911344');


insert into intakeservicerequestactor (
    intakeservicerequestactorid,
    actorid,
    personid,
    intakenumber,
    intakeserviceid,
    intakeservicerequestpersontypekey,
    isheadofhousehold,
    activeflag
)
values (
    gen_random_uuid(),
    '5cbe137d-1064-4e5b-b6ec-91ba49107f99',
    'c02edbd7-89c2-4c87-bed2-c4ea6bbd8abf',
    'I261013911344',
    'e4d76e11-307c-41f5-b7c3-8374c68ceb57',
    'PARENT',  -- or 'AV'
    false,
    1
);