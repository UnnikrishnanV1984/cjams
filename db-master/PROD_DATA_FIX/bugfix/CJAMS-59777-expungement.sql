/*
   Issue Description: CJAMS-59777 - CW2049098: Please expunge Person ID# 1182636 from file in CPS-IR-CW 2049098 and in Referral# CW 2049098.Re: Expungement of 2005 Indicated fileInboxJonathan Moore -DHS-May 15, 2025, 5:13PM (5 days ago)to me, Aleata, Emily, Tanisha, TaraHi Wanda,I just spoke with Emily to confirm the specific request that you should include in your ticket.Please submit a ticket to MDTHINK requesting that they remove the Alleged Maltreator role from Person ID #1182636 in CPS-IR #CW2049098 and the associated Intake Referral #CW2049098. When you submit the ticket, please send me the support number and I will email MDTHINK to approve and expedite the request.When the role of Alleged Maltreator is removed, she will no longer be identified as responsible for maltreatment in the centralized confidential database. If you have any questions, please let me know. 
   Category/ Module  :Investigation Findings
   Root cause: Wrong Role was added to different client
   Fix Provided: Data fix has been done by creating new person card with name Unknownn unknown and alleged maltreator role was removed from the client# 1182636 and alleged maltreatofr rcard details updated in the investigation finding tab
   Data/Code fix ticket#: CJAMS-59777
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: 
*/

insert into person
	(personid, activeflag, firstname, lastname, dangerlevel, updatedby, updatedon, insertedby, insertedon, effectivedate, dob,
	maritalstatustypekey, gendertypekey, refusessn, refusedob, dangertoself, isdraft, expungementflag, dobflag,
	nameunknownflag, adoptedflag, everbeenadoptedflag, sysdetadptflag, clientflag, approximateageno, criminalrecordflag,
	providerid, datavalidflag, outofstateflag, disabilityflag, afcarsageoutflag, fetalalcoholspctrmdisordflag,
	substanceexposednewbornflag, isapproxdob, citizenalenageflag, safehavenbabyflag, batchrunflag, isuscitizen)
values (gen_random_uuid(), 1, 'Unknown', 'Unknown', 0, 'CJAMS-59777', now(), 'CJAMS-59777', now(), now(), '1900-01-01 00:00:00', 99, 'U', false,
	false, 2, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
	

insert into actor
	(actorid, activeflag, personid, actortype, insertedby, insertedon, updatedby, updatedon, manualupdateflag, intakeserviceid,
	iscollateralcontact, ismentalillness, ismentalimpair, ishouseholdmember, isdangertoworker, sphouseholdmemberflag, spchildflag,
	spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag,
	probationsearchconductedflag, sexoffenderregisteredflag, unknownreporterflag, intakenumber)
values (gen_random_uuid(), 1, (select personid from person p where p.insertedby = 'CJAMS-59777'), 'AM', 'CJAMS-59777', now(), 'CJAMS-59777', now(),
	'N', 'c6414694-8967-4434-8386-27d5497aa210', 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'CW2049098');
	

UPDATE cjams.intakeservicerequestactor
set actorid = (select actorid from actor a where a.personid = (select personid from person p where p.insertedby = 'CJAMS-59777')),
	personid = (select personid from person p where p.insertedby = 'CJAMS-59777'),
	updatedby = 'CJAMS-59777', updatedon = now()
WHERE intakeservicerequestactorid='334f7ec0-e02b-4ddb-a286-f2ff66bae493'::uuid;