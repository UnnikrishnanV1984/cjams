/*
   Issue Description: CDM-40645
   Category/ Module  : Remove person from case
   Root cause: Need to remove a person who was added duplicate.
   -- Duplicate Person to Original Person Mapping is listed below
    -- 3598890   ---> 2480651
    * FROM personid = ac4bd6a4-4667-4b86-968c-857257fe9709
    NAME: KRISTEN KOHEE, CJAMSPID: 3598890
    casenumber '3169401'
    service case id:44875a42-413b-42c9-9451-fa75ad663bfc
    servicerequestnumeber:241022496903

    * TO personid = 85e2869a-9cdd-4105-a53e-fa6d3d5d933d
    name: KRISTEN L COHEE, CJAMSPID: 2480651
    intakeservicerequestactorid = 'c938dfbf-7f7f-42db-95e5-b52a65923413'

   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

-- Delete Actor From Persons Tab

-- select actorid, actortype, activeflag, updatedby, updatedon, intakeserviceid,*
-- 	from actor
-- where personid = 'ac4bd6a4-4667-4b86-968c-857257fe9709'
-- 	and actorid = '7a9207e4-71f9-49bb-a088-f9cdc9930e67'
-- 	and activeflag = 1 ;


update actor
set activeflag = 0,
	updatedby = 'CDM-40645',
	updatedon = now()
where personid = 'ac4bd6a4-4667-4b86-968c-857257fe9709'
	and actorid = '7a9207e4-71f9-49bb-a088-f9cdc9930e67'
	and activeflag = 1 ;

-- Delete Person Role(s)
-- select personroleid, activeflag, updatedby, updatedon, intakeserviceid, servicecaseid,*
-- 	from personrole
-- where personid = 'ac4bd6a4-4667-4b86-968c-857257fe9709' and activeflag = 1
-- 	and servicecaseid = '44875a42-413b-42c9-9451-fa75ad663bfc';

update personrole
set activeflag = 0,
	updatedby = 'CDM-40645',
	updatedon = now()
where personid = 'ac4bd6a4-4667-4b86-968c-857257fe9709' and activeflag = 1
and servicecaseid = '44875a42-413b-42c9-9451-fa75ad663bfc';
	

-- Delete Intakeservicerequestactor
-- select intakeserviceid, servicecaseid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
-- 	from intakeservicerequestactor
-- where personid = 'ac4bd6a4-4667-4b86-968c-857257fe9709' and activeflag = 1
-- and servicecaseid = '44875a42-413b-42c9-9451-fa75ad663bfc';

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-40645',
	updatedon = now()
where personid = 'ac4bd6a4-4667-4b86-968c-857257fe9709' and activeflag = 1
and servicecaseid = '44875a42-413b-42c9-9451-fa75ad663bfc';


-- Delete personroletype
-- select *
-- from personroletype p
-- where personroleid --= '311e9c91-8ec9-4fc7-bf5c-76c266cb8737'
-- in
--   (select personroleid
--   from personrole
--   where personid = 'ac4bd6a4-4667-4b86-968c-857257fe9709' 
--   and intakenumber = '3169401'
--   and activeflag = 1
--   )
-- and activeflag = 1;	

UPDATE cjams.personroletype
SET activeflag=0, updatedby = 'CDM-40645', updatedon = now()
WHERE personroletypeid in ('4e30da07-4544-45e1-a216-1f307b9e7134'::uuid, '3863f3b2-3b09-48ef-8673-83c7b7078c40'::uuid);



--CONTACT NOTES (update contact participate)
-- select contactparticipantid, intakeservicerequestactorid, activeflag, updatedby, updatedon,*
-- 	from contactparticipant
-- where contactparticipantid
-- 	in ( select cp.contactparticipantid
-- 			from progressnote p 
-- 				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
-- 					-- and cp.activeflag = 1
-- 				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
-- 		where p.activeflag = 1
-- 			and insr2.personid = 'ac4bd6a4-4667-4b86-968c-857257fe9709' 
-- 			and p.witsid in (13986121,
-- 							13921591,
-- 							13784897,
-- 							13721056,
-- 							13716310,
-- 							13710220,
-- 							13707091,
-- 							13607718,
-- 							13594257
						
-- 							)
			
-- 	   ); --isrID: da39532b-70f6-4276-9a0c-8a0d9ab4a37e
	   
	   
/*contactpartID, intakeservicerequestactorid   FROM personid
08a0914a-bba3-48f4-9798-ca8fab03a3f9	da39532b-70f6-4276-9a0c-8a0d9ab4a37e
1a356b6f-4731-4bee-b5c9-ba42f6890d0c	da39532b-70f6-4276-9a0c-8a0d9ab4a37e
bc08d34d-d2b7-481e-a2c1-6d601d440995	da39532b-70f6-4276-9a0c-8a0d9ab4a37e
b42fa323-e33c-44b3-a166-fa02aba7653f	da39532b-70f6-4276-9a0c-8a0d9ab4a37e
f226bf53-a6d8-42cd-8b19-6f171bfbca75	da39532b-70f6-4276-9a0c-8a0d9ab4a37e
1f36fab1-20c2-4632-b336-a41728d6c41f	da39532b-70f6-4276-9a0c-8a0d9ab4a37e
a83dba59-848d-4f01-950d-519239ff8457	da39532b-70f6-4276-9a0c-8a0d9ab4a37e*/
--already KLC (13784897,13594257)


update contactparticipant
set intakeservicerequestactorid = 'c938dfbf-7f7f-42db-95e5-b52a65923413', -- HOH from earlier itsra = 'da39532b-70f6-4276-9a0c-8a0d9ab4a37e'
	updatedby = 'CDM-40645',
	updatedon = now()
where contactparticipantid
	in ( select cp.contactparticipantid 
			from progressnote p 
				inner join contactparticipant cp on cp.progressnoteid = p.progressnoteid 
					-- and cp.activeflag = 1
				inner join intakeservicerequestactor insr2 on insr2.intakeservicerequestactorid	= cp.intakeservicerequestactorid 
		where p.activeflag = 1
			and insr2.personid = 'ac4bd6a4-4667-4b86-968c-857257fe9709'
			and p.witsid in (13986121,
							13921591,
							13784897,
							13721056,
							13716310,
							13710220,
							13707091,
							13607718,
							13594257
							)    -- israID: da39532b-70f6-4276-9a0c-8a0d9ab4a37e
	   ) ;

	  
	  
----------- update the focusperson ----------------
-- for Contact ID: 14362536
update progressnote set 
focusperson= '{
                "focuspersonjson": [
                    {
                        "participanttypekey": "IP",
                        "intakeservicerequestactorid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "participantid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "firstname": "KRISTEN L",
                        "lastname": "COHEE",
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
                        "intakeservicerequestactorid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "participantid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "firstname": "DEVYN",
                        "lastname": "BIRCH",
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
                        "intakeservicerequestactorid": "00b1c26b-75ea-4cf1-b41f-dcd7ee22aaab",
                        "participantid": "00b1c26b-75ea-4cf1-b41f-dcd7ee22aaab",
                        "firstname": "BROOKLYN",
                        "lastname": "COHEE BIRCH",
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
updatedby = 'CDM-40645'
where progressnoteid = '6ed1d590-3e7f-43d3-b754-fe79984a5637';

-- for Contact ID: 14362469
update progressnote set 
focusperson= '{
                "focuspersonjson": [
                    {
                        "participanttypekey": "IP",
                        "intakeservicerequestactorid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "participantid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "firstname": "KRISTEN L",
                        "lastname": "COHEE",
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
                        "intakeservicerequestactorid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "participantid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "firstname": "DEVYN",
                        "lastname": "BIRCH",
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
                        "intakeservicerequestactorid": "00b1c26b-75ea-4cf1-b41f-dcd7ee22aaab",
                        "participantid": "00b1c26b-75ea-4cf1-b41f-dcd7ee22aaab",
                        "firstname": "BROOKLYN",
                        "lastname": "COHEE BIRCH",
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
updatedby = 'CDM-40645'
where progressnoteid = '011da7e8-1c08-4e9c-833a-1cd889af48f5';



-- For Contact ID: 13988659
update progressnote set 
focusperson= '{
"focuspersonjson": [
                    {
                        "participanttypekey": "IP",
                        "intakeservicerequestactorid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "participantid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "firstname": "KRISTEN L",
                        "lastname": "COHEE",
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
updatedby = 'CDM-40645'
where progressnoteid = '959b5cc8-5c58-4baf-9952-a218b5b4a5ab';


-- For Contact ID: 13986121
update progressnote set 
focusperson= '{
"focuspersonjson": [
                    {
                        "participanttypekey": "IP",
                        "intakeservicerequestactorid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "participantid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "firstname": "KRISTEN L",
                        "lastname": "COHEE",
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
updatedby = 'CDM-40645'
where progressnoteid = 'a3fdc413-2052-4026-a0d2-49d5722a4b60';



-- For Contact ID: 13921591
update progressnote set 
focusperson= '{
"focuspersonjson": [
                    {
                        "participanttypekey": "IP",
                        "intakeservicerequestactorid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "participantid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "firstname": "KRISTEN L",
                        "lastname": "COHEE",
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
updatedby = 'CDM-40645'
where progressnoteid = 'ea7bf338-dacd-4632-bcc2-38fa7366793f';


-- For Contact ID: 13845631
update progressnote set 
focusperson= '{
"focuspersonjson": [
                    {
                        "participanttypekey": "IP",
                        "intakeservicerequestactorid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "participantid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "firstname": "KRISTEN L",
                        "lastname": "COHEE",
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
                        "intakeservicerequestactorid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "participantid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "firstname": "DEVYN",
                        "lastname": "BIRCH",
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
                        "intakeservicerequestactorid": "00b1c26b-75ea-4cf1-b41f-dcd7ee22aaab",
                        "participantid": "00b1c26b-75ea-4cf1-b41f-dcd7ee22aaab",
                        "firstname": "BROOKLYN",
                        "lastname": "COHEE BIRCH",
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
updatedby = 'CDM-40645'
where progressnoteid = '684af609-024e-41d1-82d8-51633fcfabd2';


-- For Contact ID: 13784897
update progressnote set 
focusperson= '{
"focuspersonjson": [
                    {
                        "participanttypekey": "IP",
                        "intakeservicerequestactorid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "participantid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "firstname": "DEVYN",
                        "lastname": "BIRCH",
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
                        "intakeservicerequestactorid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "participantid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "firstname": "KRISTEN L",
                        "lastname": "KOHEE",
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
                        "intakeservicerequestactorid": "00b1c26b-75ea-4cf1-b41f-dcd7ee22aaab",
                        "participantid": "00b1c26b-75ea-4cf1-b41f-dcd7ee22aaab",
                        "firstname": "BROOKLYN",
                        "lastname": "COHEE BIRCH",
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
updatedby = 'CDM-40645'
where progressnoteid = '82dc24e8-2bac-45d7-a6fa-113ad8ca535f';

-- Contact ID: 13721056
update progressnote set 
focusperson= '{
"focuspersonjson": [
                    {
                        "participanttypekey": "IP",
                        "intakeservicerequestactorid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "participantid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "firstname": "KRISTEN L",
                        "lastname": "COHEE",
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
                        "intakeservicerequestactorid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "participantid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "firstname": "DEVYN",
                        "lastname": "BIRCH",
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
                        "intakeservicerequestactorid": "00b1c26b-75ea-4cf1-b41f-dcd7ee22aaab",
                        "participantid": "00b1c26b-75ea-4cf1-b41f-dcd7ee22aaab",
                        "firstname": "BROOKLYN",
                        "lastname": "COHEE BIRCH",
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
updatedby = 'CDM-40645'
where progressnoteid = 'e2b5ea8c-8e97-4036-96d6-cf5187acf467';


-- Contact ID: 13716310
update progressnote set 
focusperson= '{
"focuspersonjson": [
                    {
                        "participanttypekey": "IP",
                        "intakeservicerequestactorid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "participantid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "firstname": "DEVYN",
                        "lastname": "BIRCH",
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
                        "intakeservicerequestactorid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "participantid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "firstname": "KRISTEN L",
                        "lastname": "KOHEE",
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
                        "intakeservicerequestactorid": "00b1c26b-75ea-4cf1-b41f-dcd7ee22aaab",
                        "participantid": "00b1c26b-75ea-4cf1-b41f-dcd7ee22aaab",
                        "firstname": "BROOKLYN",
                        "lastname": "COHEE BIRCH",
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
updatedby = 'CDM-40645'
where progressnoteid = '5594b56e-3ea1-42ec-b051-f58206f64b7d';



-- Contact ID: 13710220
update progressnote set 
focusperson= '{
"focuspersonjson": [
                    {
                        "participanttypekey": "IP",
                        "intakeservicerequestactorid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "participantid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "firstname": "KRISTEN L",
                        "lastname": "COHEE",
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
                        "intakeservicerequestactorid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "participantid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "firstname": "DEVYN",
                        "lastname": "BIRCH",
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
                        "intakeservicerequestactorid": "00b1c26b-75ea-4cf1-b41f-dcd7ee22aaab",
                        "participantid": "00b1c26b-75ea-4cf1-b41f-dcd7ee22aaab",
                        "firstname": "BROOKLYN",
                        "lastname": "COHEE BIRCH",
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
updatedby = 'CDM-40645'
where progressnoteid = 'ac781e07-f423-4034-9a10-b1dd51957ddf';



-- Contact ID: 13707091
update progressnote set 
focusperson= '{
 "focuspersonjson": [
                    {
                        "participanttypekey": "IP",
                        "intakeservicerequestactorid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "participantid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "firstname": "DEVYN",
                        "lastname": "BIRCH",
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
                        "intakeservicerequestactorid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "participantid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "firstname": "KRISTEN L",
                        "lastname": "KOHEE",
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
updatedby = 'CDM-40645'
where progressnoteid = '663b25ba-19e3-494d-876a-ea4b96a4b708';


-- Contact ID: 13636560
update progressnote set 
focusperson= '{
"focuspersonjson": [
                    {
                        "participanttypekey": "IP",
                        "intakeservicerequestactorid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "participantid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "firstname": "KRISTEN L",
                        "lastname": "COHEE",
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
                        "intakeservicerequestactorid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "participantid": "cc9f1ac2-f947-41b7-81f2-24ec27569bc8",
                        "firstname": "DEVYN",
                        "lastname": "BIRCH",
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
updatedby = 'CDM-40645'
where progressnoteid = 'c2fc5c79-5f11-4588-a68e-e8f8909aca85';


-- Contact ID: 13607718
update progressnote set 
focusperson= '{
"focuspersonjson": [
                    {
                        "participanttypekey": "IP",
                        "intakeservicerequestactorid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "participantid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "firstname": "KRISTEN L",
                        "lastname": "COHEE",
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
updatedby = 'CDM-40645'
where progressnoteid = 'd500802d-3448-4da6-84e2-93ba6e3830de';

-- Contact ID: 13594257
update progressnote set 
focusperson= '{
"focuspersonjson": [
                    {
                        "participanttypekey": "IP",
                        "intakeservicerequestactorid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "participantid": "c938dfbf-7f7f-42db-95e5-b52a65923413",
                        "firstname": "KRISTEN L",
                        "lastname": "KOHEE",
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
updatedby = 'CDM-40645'
where progressnoteid = 'aa9e850a-b8ec-4b13-9385-c246492704f0';



--update assessment 
--CANSF
update assessment 
set submissiondata = replace(submissiondata::text, '"houseHoldName": "KRISTEN KOHEE",' , '"houseHoldName": "KRISTEN L KOHEE",')::json 
where assessmentid ='e3c43dd8-a980-4e27-8c45-c6d990395ab9';

--MIFRA
update assessment 
set submissiondata = replace(submissiondata::text, '"houseHoldHeadName": "KRISTEN KOHEE",' , '"houseHoldHeadName": "KRISTEN L KOHEE",')::json 
where assessmentid ='1c4c89de-6ae7-4558-b565-cb283b447ba3';

update assessment 
set submissiondata = replace(submissiondata::text, 'KRISTEN KOHEE' , 'KRISTEN L KOHEE')::json 
where assessmentid ='1c4c89de-6ae7-4558-b565-cb283b447ba3';
	   
--SAFEC
update assessment 
set submissiondata = replace(submissiondata::text, '"houseHoldHeadName": "KRISTEN KOHEE",' , '"houseHoldHeadName": "KRISTEN L KOHEE",')::json 
where assessmentid ='9e49388d-c024-4a48-b69d-3d77a7b42059';

update assessment 
set submissiondata = replace(submissiondata::text, 'KRISTEN KOHEE' , 'KRISTEN L KOHEE')::json 
where assessmentid ='9e49388d-c024-4a48-b69d-3d77a7b42059';