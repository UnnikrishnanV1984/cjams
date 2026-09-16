/*
   Issue Description: CDM-44194
   Category/ Module  : Removing person from case
   Root cause: 241022962344,User is requested to remove client ID # 2794756,This person card was put into this case in error. 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
--update intake
/*
select * from person where cjamspid = '2794756';--wrongP: 39e2dca9-b20a-4a0c-8991-5a1c271929d1
select * from person where cjamspid = '204071210';--rightP: 25cd8e7e-614d-4363-be66-5102ee37ac3a
-- update wrong person with right person

select * from intakeservicerequestactor 
where personid = '25cd8e7e-614d-4363-be66-5102ee37ac3a' 
and intakenumber = 'I241013186909'
and activeflag = 1;

*/

update intakeservicerequestactor 
set updatedby = 'CDM-44194',
	updatedon = now(),
	personid = '25cd8e7e-614d-4363-be66-5102ee37ac3a'-- right
where personid = '39e2dca9-b20a-4a0c-8991-5a1c271929d1' 
and intakenumber = 'I241013186909'
and activeflag = 1;


update actor 
set updatedby = 'CDM-44194',
	updatedon = now(),
	personid = '25cd8e7e-614d-4363-be66-5102ee37ac3a'-- right
where personid = '39e2dca9-b20a-4a0c-8991-5a1c271929d1' 
and intakenumber = 'I241013186909'
and activeflag = 1;

--adding role as it was missing in intake Paternal Uncle <---> Paternal Niece
INSERT INTO cjams.intakeservicerequestactor
(intakeservicerequestactorid, actorid,
 intakeservicerequestpersontypekey, rapersontypekey,
  insertedby, insertedon, 
  updatedby, updatedon,
   expirationdate, "timestamp", intakeserviceid,
    routingaddressid, employeetypeid,
	 employeetypename, medicaideligibility, 
	 blockgranteligibility, livingarrangementtypekey,
	  guardianname, guardianinfo, 
	  ramentalhealth, ramentalretarted, 
	  ramentalretartedtype, refusessn, 
	  refusedob, activeflag, reported, isprimary, personid, old_id, ismaltreator, rcprimaryroletypekey, ncpspriorhistoryflag, householdnumber, ssnverifytypekey, rchandicapflag, rchomelessflag, lvgarrangementtypekey, livingprefixtypekey, lvgfirstname, lvgmiddlename, lvglastname, lvgsuffixtypekey, lvgrelationshiptypekey, lvgcomments, rchouseholdflag, rcchildflag, nonparticipatingflag, householdheadflag, rcinsertedon, rcinsertedby, rcupdatedon, rcupdatedby, rcactiveflag, livingwith, rcreporteranonymousflag, rcreporternoletterflag, clientflag, rcexpungementflag, rcdatavalidflag, rcclientmergeid, arclientid, arsummaryid, altrespclientid, participatingchildflag, aractiveflag, screeningpersonid, prexpungementflag, prdatavalidflag, prinsertedby, prupdatedby, practiveflag, referralclientid, caseclientid, crexpungementflag, crdatavalidflag, crinsertedby, crupdatedby, sphouseholdmemberflag, spchildflag, spreporteranonymousflag, spreporternoletterflag, spexpungementflag, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag, otherdrugs, unknownreporterflag, spproviderid, fk_id, isvictim, servicecaseid, fk_cl_id, intakenumber, isheadofhousehold, etl_userid, etl_load_date, objectid, objecttype)
VALUES(cjams.gen_random_uuid(), 'af2a247f-3f63-4ab8-b1e5-ead289313625', 
'RELATIVE', NULL, 
'ec9cc7d9-2bda-435d-800e-a08e572ad221', '2024-12-05 13:47:16.145', 
'CDM-44194', '2025-02-19 09:06:40.324',
 NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, true, true, '25cd8e7e-614d-4363-be66-5102ee37ac3a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I241013186909', false, NULL, NULL, NULL, NULL);


INSERT INTO cjams.actorrelationship
(actorrelationshipid,
 relationshiptypekey,
  insertedby,
   insertedon, 
   updatedby, 
   updatedon,
    "timestamp",
	 effectivedate, 
	 expirationdate, activeflag, intakeservicerequestactorid, old_id, client1id, client2id, caregiverflag, paternityestdflag, paternityestddate, paternitycourtorderflag, maternityestdflag, maternityestddate, maternitycourtorderflag, "comments", startdate, enddate, sysgenflag, origclientid, caseid, referralid, expungementflag, datavalidflag, clientmergeid, fk1_id, fk2_id, fk3_id, person1id, person2id, servicecaseid, intakeserviceid, intakenumber, etl_userid, etl_load_date)
VALUES(cjams.gen_random_uuid(),
 'PRNTLNC',
  NULL, 
  '2024-12-05 13:57:17.000',
   'CDM-44194',
    '2025-02-19 11:34:59.770',
	 NULL, 
	 '2024-12-05 13:57:17.000', 
	 NULL, 1, '7f503937-cc34-4609-975a-6cfb9779705b', NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '0961cfd8-3037-4632-a8bd-df84cf7b32da', '25cd8e7e-614d-4363-be66-5102ee37ac3a', NULL, NULL, NULL, NULL, NULL);

-- adding relationship
update actorrelationship  
set  person1id = '25cd8e7e-614d-4363-be66-5102ee37ac3a', --'39e2dca9-b20a-4a0c-8991-5a1c271929d1' wrong one
	 updatedby = 'CDM-44194',
	 relationshiptypekey = 'PRNTLUE',
	 updatedon = now()
where actorrelationshipid ='e7126552-d275-4016-b176-820d075c98ea'
and intakeservicerequestactorid = '7f503937-cc34-4609-975a-6cfb9779705b' ;


--update CPS-IR case
/*
select intakeservicerequestactorid,intakenumber, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon 
	from intakeservicerequestactor
where  intakeserviceid = '66847454-bd00-4753-885f-ef992383d378' 
and activeflag = 1 
and personid = '39e2dca9-b20a-4a0c-8991-5a1c271929d1';
*/

/*
select * from intakeservicerequestactor 
where personid = '25cd8e7e-614d-4363-be66-5102ee37ac3a' 
and intakeserviceid = '66847454-bd00-4753-885f-ef992383d378' 
and activeflag = 1;
*/

update intakeservicerequestactor	
set activeflag = 0,
	updatedby = 'CDM-44194', 
	updatedon = now()
where  intakeserviceid = '66847454-bd00-4753-885f-ef992383d378' 
and activeflag = 1 and personid = '39e2dca9-b20a-4a0c-8991-5a1c271929d1';


/*
select actorid, actortype, activeflag, updatedby, updatedon 
	from actor 
where  intakeserviceid = '66847454-bd00-4753-885f-ef992383d378' 
and activeflag = 1 and personid = '39e2dca9-b20a-4a0c-8991-5a1c271929d1';
*/
	

update actor
set activeflag = 0,
	updatedby = 'CDM-44194', 
	updatedon = now()
where  intakeserviceid = '66847454-bd00-4753-885f-ef992383d378' 
and activeflag = 1 and personid = '39e2dca9-b20a-4a0c-8991-5a1c271929d1';

/*
select personroleid, activeflag, updatedby, updatedon
	from personrole
where  intakeserviceid = '66847454-bd00-4753-885f-ef992383d378' 
--and activeflag = 1 
and personid = '39e2dca9-b20a-4a0c-8991-5a1c271929d1';
*/
	

update personrole
set activeflag = 0,
	updatedby = 'CDM-44194', 
	updatedon = now()
where  intakeserviceid = '66847454-bd00-4753-885f-ef992383d378' 
and activeflag = 1 and personid = '39e2dca9-b20a-4a0c-8991-5a1c271929d1';
	
/*
select * from personroletype p 
where personroleid = '1acea192-ba33-4c8f-be9c-fdf713a32658' and activeflag = 1;
*/

update personroletype 
set  activeflag = 0,
	 updatedby = 'CDM-44194',
	 updatedon = now()
where personroleid = '1acea192-ba33-4c8f-be9c-fdf713a32658'
and activeflag =1; 


/*
select * from actorrelationship a 
where intakeservicerequestactorid in
	(select intakeservicerequestactorid 
		from intakeservicerequestactor
	where  intakeserviceid = '66847454-bd00-4753-885f-ef992383d378' 
	and activeflag = 0 and personid = '39e2dca9-b20a-4a0c-8991-5a1c271929d1')
and intakeserviceid ='66847454-bd00-4753-885f-ef992383d378'
and activeflag =1;
*/

update actorrelationship  
set  activeflag = 0,
	 updatedby = 'CDM-44194',
	 updatedon = now()
where intakeservicerequestactorid in
	(select intakeservicerequestactorid 
		from intakeservicerequestactor
	where  intakeserviceid = '66847454-bd00-4753-885f-ef992383d378' 
	and activeflag = 1 and personid = '39e2dca9-b20a-4a0c-8991-5a1c271929d1')
and intakeserviceid ='66847454-bd00-4753-885f-ef992383d378'
and activeflag =1;