/*
   Issue Description: CDM-43397
   Category/ Module  : Remove person from case and replace contact notes with correct cjamsPID.
   Root cause: User Error, Need to remove a person who was added wrongly.
   -- Duplicate Person to Original Person Mapping is listed below
    -- 4295102   ---> 204048564
    * FROM personid = 460af92a-a98f-4a8a-b890-960992307d9b
    NAME: NANCY SEGOVIA, CJAMSPID: 4295102
    casenumber '241022960703'
    israID:a3164921-22ef-4fa0-b342-2d5689919bc1

    * TO personid = 0566e5b3-5e41-498e-a51f-e46aba96cf5f
    name: Nancy Segovia, CJAMSPID: 204048564
    intakeservicerequestactorid = '214af443-3b49-43c4-a4e0-797d8e72c6e9'

   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

--select * from person where cjamspid in ('4295102','204048564');--460af92a-a98f-4a8a-b890-960992307d9b,0566e5b3-5e41-498e-a51f-e46aba96cf5f
--remove 4295102, 460af92a-a98f-4a8a-b890-960992307d9b

/*
select * from person where personid = '460af92a-a98f-4a8a-b890-960992307d9b' and activeflag = 1;
*/

--Deactivating client from intakeservicerequestactor
/*
select intakeserviceid,intakeservicerequestactorid,actorid,activeflag,* from intakeservicerequestactor where personid = '460af92a-a98f-4a8a-b890-960992307d9b'
and intakeserviceid = '5210b990-249f-4fd9-9d7f-ef7cd9541c9c' and activeflag = 1;
*/

update intakeservicerequestactor
set activeflag = 0, updatedby = 'CDM-43397', updatedon = now()
where intakeservicerequestactorid = 'a3164921-22ef-4fa0-b342-2d5689919bc1' and activeflag = 1;

--Deactivating client from actor
/*
select * from actor where personid = '460af92a-a98f-4a8a-b890-960992307d9b' and actorid = '8c6096f3-8c7e-4ba3-97a7-324297551719' and activeflag = 1;
*/

update actor
set activeflag = 0, updatedby = 'CDM-43397', updatedon = now()
where actorid = '8c6096f3-8c7e-4ba3-97a7-324297551719' and activeflag = 1;


--Deactivating client from actorrelationship
/*
select intakeservicerequestactorid,* from actorrelationship where intakeservicerequestactorid = 'a3164921-22ef-4fa0-b342-2d5689919bc1' and activeflag = 1;
*/

update actorrelationship
set activeflag = 0, updatedby = 'CDM-43397', updatedon = now()
where intakeservicerequestactorid = 'a3164921-22ef-4fa0-b342-2d5689919bc1' and activeflag = 1;

--Deactivating client from personrole
/*
select * from personrole where personid = '460af92a-a98f-4a8a-b890-960992307d9b' 
and intakeserviceid = '5210b990-249f-4fd9-9d7f-ef7cd9541c9c' and  activeflag = 1;
*/

update personrole
set activeflag = 0, updatedby = 'CDM-43397', updatedon = now()
where personroleid = '7b3995e7-9bc1-479d-b13e-7e8eaad7f76c' and activeflag = 1;


--- update the contact notes 
--- from : 4295102, 460af92a-a98f-4a8a-b890-960992307d9b
--- To: 204048564, 0566e5b3-5e41-498e-a51f-e46aba96cf5f
/*
select intakeserviceid,intakeservicerequestactorid,actorid,activeflag,* from intakeservicerequestactor where personid = '0566e5b3-5e41-498e-a51f-e46aba96cf5f'
and intakeserviceid = '5210b990-249f-4fd9-9d7f-ef7cd9541c9c' and activeflag = 1;
*/
/*
select intakeservicerequestactorid,* from contactparticipant where progressnoteid = '9be99205-721a-4ea3-be1d-3d20cc0ffd3a' 
and contactparticipantid = 'ff7fba38-4c6b-409d-a3f9-6259eac87549'and activeflag = 1;
*/

--a3164921-22ef-4fa0-b342-2d5689919bc1 ---> 214af443-3b49-43c4-a4e0-797d8e72c6e9

/*
 select contactparticipantid, intakeservicerequestactorid, activeflag, updatedby, updatedon,*
 	from contactparticipant
 where contactparticipantid
 	in ( select cp.contactparticipantid
 			from progressnote p 
 				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
 					-- and cp.activeflag = 1
 				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
 		where p.activeflag = 1
 			and insr2.personid = '460af92a-a98f-4a8a-b890-960992307d9b' --wrong personid 
 			and p.witsid in (14667185,
 							14651297						
 							)
			
 	   ); --isrID: a3164921-22ef-4fa0-b342-2d5689919bc1*/

update contactparticipant
set intakeservicerequestactorid = '214af443-3b49-43c4-a4e0-797d8e72c6e9', -- from earlier itsra = 'a3164921-22ef-4fa0-b342-2d5689919bc1'
	updatedby = 'CDM-43397',
	updatedon = now()
where contactparticipantid
	in ( select cp.contactparticipantid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
					-- and cp.activeflag = 1
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
		where p.activeflag = 1
			and insr2.personid = '460af92a-a98f-4a8a-b890-960992307d9b'
			and p.witsid in (14667185,
 							14651297						
 							)  --isrID: a3164921-22ef-4fa0-b342-2d5689919bc1
	   ) ;

	  
------ update the focusperson --------
-- for Contact ID: 14654872
/*
select focusperson,* from progressnote where progressnoteid = 'c9fb1a67-d523-4fe9-b56b-d622e4a1db22';
*/
update progressnote set 
focusperson= '{
  "focuspersonjson": [
    {
	  "participanttypekey": "IP",
	  "intakeservicerequestactorid": "214af443-3b49-43c4-a4e0-797d8e72c6e9",
	  "participantid": "3214af443-3b49-43c4-a4e0-797d8e72c6e9",
	  "firstname": "Nancy",
	  "lastname": "Segovia",
	  "address1": null,
	  "address2": null,
	  "city": null,
	  "state": null,
	  "zipcode": null,
	  "email": null,
	  "phonenumber": null
	},
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "42063f26-c936-4c73-9b7f-8d9a6c860508",
      "participantid": "42063f26-c936-4c73-9b7f-8d9a6c860508",
      "firstname": "Bentley",
      "lastname": "Segovia",
      "address1": null,
      "address2": null,
      "city": null,
      "state": null,
      "zipcode": null,
      "email": null,
      "phonenumber": null
    },
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "5e1abf7d-aca0-4b7b-b175-da4214c11843",
      "participantid": "5e1abf7d-aca0-4b7b-b175-da4214c11843",
      "firstname": "Jeffrey",
      "lastname": "Tate",
      "address1": null,
      "address2": null,
      "city": null,
      "state": null,
      "zipcode": null,
      "email": null,
      "phonenumber": null
    }
  ]
}',
updatedon = now(),
updatedby = 'CDM-43397'
where progressnoteid = 'c9fb1a67-d523-4fe9-b56b-d622e4a1db22';