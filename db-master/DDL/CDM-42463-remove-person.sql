/*
   Issue Description: CDM-42463 - Remove the client ID # 204005998 (Elisha Johns) from the CPS AR case # 241022936352,
   Category/ Module  : Delete Person from case
   Root cause: User wants to remove the person from the case
   Fix Provided :Data fix has been promoted to delete persons card, contacts, assessements, payments, Program assignments etc.
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

-- select activeflag, * from actor where actorid ='131217a4-5e6b-4505-9523-c8520b85608e';

update actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-42463'
where actorid = '131217a4-5e6b-4505-9523-c8520b85608e';

-- select activeflag, * from intakeservicerequestactor i where intakeservicerequestactorid ='c9643acf-375e-4f0e-bdff-c314156e2cc5';

update intakeservicerequestactor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-42463'
where intakeservicerequestactorid = 'c9643acf-375e-4f0e-bdff-c314156e2cc5';

-- select activeflag, * from personrole p where personroleid ='6a315ed8-744f-4994-822b-87c17822d4b3' and personid ='ce4e15d5-2a40-447d-a930-e084d7fda13a';

update personrole 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-42463'
where personroleid = '6a315ed8-744f-4994-822b-87c17822d4b3';

-- select activeflag, * from personroletype p2 where personroleid ='6a315ed8-744f-4994-822b-87c17822d4b3';

update personroletype
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-42463'
where personroleid = '6a315ed8-744f-4994-822b-87c17822d4b3';

-- select focusperson,* from progressnote where progressnoteid='43997452-d3f4-4b8e-9b64-693a39729339';

update progressnote set focusperson = '{
  "focuspersonjson": [
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "3cf55b20-96f3-4c12-a7be-cd108ee3d0d4",
      "participantid": "3cf55b20-96f3-4c12-a7be-cd108ee3d0d4",
      "firstname": "QUWAN",
      "lastname": "jOHNS",
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
      "intakeservicerequestactorid": "7d4390b9-0865-4922-bee7-91c7a71253d6",
      "participantid": "7d4390b9-0865-4922-bee7-91c7a71253d6",
      "firstname": "Faithion",
      "lastname": "johns",
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
      "intakeservicerequestactorid": "0f2a70ca-8b86-4f5a-8293-d1386b915a89",
      "participantid": "0f2a70ca-8b86-4f5a-8293-d1386b915a89",
      "firstname": "Ron",
      "lastname": "Johns",
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
      "intakeservicerequestactorid": "6c688d30-3ec8-4f40-85df-1cd77d1a6632",
      "participantid": "6c688d30-3ec8-4f40-85df-1cd77d1a6632",
      "firstname": "ANNABELLA",
      "lastname": "JOHNS",
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
      "intakeservicerequestactorid": "67171fac-f37a-4b31-aaaa-47fd3183f07d",
      "participantid": "67171fac-f37a-4b31-aaaa-47fd3183f07d",
      "firstname": "ISAIAH",
      "lastname": "JOHNS",
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
      "intakeservicerequestactorid": "d083aaad-78e9-4ccc-b4fe-89975d803574",
      "participantid": "d083aaad-78e9-4ccc-b4fe-89975d803574",
      "firstname": "BRANDON",
      "lastname": "JOHNS",
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
      "intakeservicerequestactorid": "b8ae569f-c431-4eda-a253-e31fd882d03e",
      "participantid": "b8ae569f-c431-4eda-a253-e31fd882d03e",
      "firstname": "jANE",
      "lastname": "jOHNS",
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
      "intakeservicerequestactorid": "aebf3836-4e95-4f17-b330-ae0a5f6a2fc9",
      "participantid": "aebf3836-4e95-4f17-b330-ae0a5f6a2fc9",
      "firstname": "Elli",
      "lastname": "Johns",
      "address1": null,
      "address2": null,
      "city": null,
      "state": null,
      "zipcode": null,
      "email": null,
      "phonenumber": null
    }
  ]
}'::json where progressnoteid='43997452-d3f4-4b8e-9b64-693a39729339';