-- CDM-41710 -  There's a duplicate PID# for Jonathan West. The incorrect PID # 203984224
/*
-- Issue Description: 
SSA/Product Owner approved with below data fixes;

1) Remove PID#203984224 from Contact ID#14474392
2) Add PID#200961341 to Contact ID#14474392
3) Remove PID#203984224 from IHSP Case #221030018769

-- Category/ Module: Person
-- Root cause: User Request
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/


-- update focus person
/*
select focusperson ,* from progressnote where progressnoteid = '6e9cd863-5376-42b6-a0c0-ba7f2ba53b9f';
*/

update progressnote set 
focusperson = '{
  "focuspersonjson": [
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "23470114-5e8c-45ed-8b99-4481a6c61f59",
      "participantid": "23470114-5e8c-45ed-8b99-4481a6c61f59",
      "firstname": "Jonathan",
      "lastname": "Donaldson West",
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
      "intakeservicerequestactorid": "757c52b0-5c28-4ee0-8724-fa01856667f6",
      "participantid": "757c52b0-5c28-4ee0-8724-fa01856667f6",
      "firstname": "KATHERINE",
      "lastname": "BILBROUGH",
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
      "intakeservicerequestactorid": "d227a4e3-0edb-49de-a2d0-5ad84b8e1e75",
      "participantid": "d227a4e3-0edb-49de-a2d0-5ad84b8e1e75",
      "firstname": "James",
      "lastname": "West",
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
updatedby = 'CDM-41710'
where progressnoteid = '6e9cd863-5376-42b6-a0c0-ba7f2ba53b9f';


-- update personcontacted
/*
select * from cjams.contactparticipant where progressnoteid = '6e9cd863-5376-42b6-a0c0-ba7f2ba53b9f' and activeflag = 1;
*/

update cjams.contactparticipant 
set participantid = '23470114-5e8c-45ed-8b99-4481a6c61f59', 
intakeservicerequestactorid = '23470114-5e8c-45ed-8b99-4481a6c61f59',
updatedon = now(), updatedby = 'CDM-41710'
where contactparticipantid = 'e914f306-dab1-4b64-9be3-97789370b794';

-- Task2: remove PID 203984224(Jonathan West) from IHSP Case #221030018769 
/*
select activeflag,intakeservicerequestactorid,personid,* from intakeservicerequestactor i where personid = '515490d1-d946-4631-99ff-263c4fa9ed0a'
*/

UPDATE cjams.intakeservicerequestactor
SET updatedby='CDM-41710', updatedon=now(), activeflag = 0
WHERE intakeservicerequestactorid='a9c668c1-e98d-4ad9-a83e-1dc36bd3e8ac' and personid='515490d1-d946-4631-99ff-263c4fa9ed0a';

UPDATE cjams.actor
SET updatedby='CDM-41710', updatedon=now(), activeflag = 0
WHERE actorid='bc2924b8-14f2-475d-b6ca-19faeeae235e' and personid='612767b4-4b6e-483a-a710-ffc35671a819';

/*
select * from personrole where personid = '515490d1-d946-4631-99ff-263c4fa9ed0a' and activeflag =1;
*/

update cjams.personrole  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-41710'
where personroleid = '3ad1b68f-39d3-4f02-a589-9cd010e34f2c';

/*
select * from cjams.actorrelationship where intakeservicerequestactorid = 'a9c668c1-e98d-4ad9-a83e-1dc36bd3e8ac' and activeflag = 1;
*/
update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-41710'
where actorrelationshipid = '8ca6cb61-a368-44c4-b1b1-d64f8688cbad';