
/*
Issue Description: Expungement Request
Category/Module: Expungement 
Root cause: User requested to change the maltrater to unnamed and expunge the case.
Fix provided: Data fix done to change the maltrater to unnamed and expunge the case.
Data/Code fix ticket#: CJAMS-64623
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/
--Inserting an unknown person in person
insert into person
	(personid, activeflag, firstname, lastname, dangerlevel, updatedby, updatedon, insertedby, insertedon, effectivedate, dob,
	maritalstatustypekey, gendertypekey, refusessn, refusedob, dangertoself, isdraft, expungementflag, dobflag,
	nameunknownflag, adoptedflag, everbeenadoptedflag, sysdetadptflag, clientflag, approximateageno, criminalrecordflag,
	providerid, datavalidflag, outofstateflag, disabilityflag, afcarsageoutflag, fetalalcoholspctrmdisordflag,
	substanceexposednewbornflag, isapproxdob, citizenalenageflag, safehavenbabyflag, batchrunflag, isuscitizen)
values (gen_random_uuid(), 1, 'Unnamed', 'Unnamed', 0, 'CJAMS-64623', now(), 'CJAMS-64623', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
	
--Inserting created unknown person into actor 
insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag, intakenumber)
values (gen_random_uuid(), 1, (select personid from person p where p.insertedby = 'CJAMS-64623'), 'AM', 'CJAMS-64623', now(), 'CJAMS-64623', now(),
	'N', '1965c9d0-d1ff-47b1-961b-9577cc7844df', 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, '241022939096');
	
--Inserting created unknown actor into intakeservicerequest
update intakeservicerequestactor
set
	actorid = (select actorid from actor a where a.personid = (select personid from person p where p.insertedby = 'CJAMS-64623')),
	personid = (select personid from person p where p.insertedby = 'CJAMS-64623'),
	updatedby = 'CJAMS-64623', updatedon = now()
	where intakeservicerequestactorid = 'cc349fb1-6a84-48ff-aa05-92f9053faf1a' and activeflag = 1;

select vl_sqlcode, vs_err_message
from cjams.expungcaserequest
	(	'IR'::character varying,
		'241022939096'::character varying,
		null::date
	) ;