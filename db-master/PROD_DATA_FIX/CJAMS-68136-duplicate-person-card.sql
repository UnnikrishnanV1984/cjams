/*
   Issue Description: CJAMS-68136 
   Category/ Module: person & Contacts
   Root cause: User requested to data fix to remove client# 204909195 (Sarah Lynn Edwards) from CPS IR & CPS Intake cases, in all persons,Contacts and assessment tabs
   Fix Provided: Data fix was done by removing client# 204909195 (Sarah Lynn Edwards) from CPS IR & CPS Intake cases, in all persons,Contacts and assessment tabs
   Code Fix: Not Needed
*/



update actor 
set activeflag=0, updatedby='CJAMS-68136', updatedon=now()
where actorid in ('bbeec8c8-3d4d-4907-8abe-7ecf3e6ac468', 'da8641a6-a588-423a-8fa4-2e1664ff202d') and activeflag=1;

update intakeservicerequestactor 
set activeflag=0, updatedby='CJAMS-68136', updatedon=now()
where intakeservicerequestactorid in ('940ad2ce-79dc-4d8d-9975-6ddd0c52df73', '1542f8be-2b95-4afb-92a2-21804978f4a9', '4362fb4d-a887-4297-a32e-8d2e8f616930', 'fc41d4e6-85a4-4fd3-83cb-889df4b82e26') and activeflag=1;

update personrole
set activeflag=0, updatedby='CJAMS-68136', updatedon=now()
where personroleid in ('ee14949e-8f8a-4b55-8458-c17cdc85cb7c', '15642963-d1cc-48f6-a2d5-d66874b1ae98') and activeflag=1;

update personroletype
set activeflag=0, updatedby='CJAMS-68136', updatedon=now()
where personroletypeid in ('afdaa8b0-dc08-4c66-8c44-07f6f7ff4fd8', 'e852a87f-602f-481c-8ab7-c0304b7192c5', '37d31597-0af2-4568-92b0-f71e6073e4ba', '40a75e3f-a943-41f8-a3f7-3aac77b8a497') and activeflag=1; 

update personprogramarea
set activeflag=0, updatedby='CJAMS-68136', updatedon=now()
where personprogramid='ce01f46c-1674-447e-8b44-8ccaea2aa3af' and activeflag=1;

update actorrelationship
set activeflag=0, updatedby='CJAMS-68136', updatedon=now()
where actorrelationshipid in ('ed2c35b9-7c9d-4f0d-a592-aba267fd5020', '373bb864-53be-4809-95cf-af137aaa0d06') and activeflag=1;

update contactparticipant 
set activeflag=0, updatedby='CJAMS-68136', updatedon=now()
where contactparticipantid in('162978be-a13b-43e4-bd30-aecf5d3b4f2e', '531e9c39-96be-4006-9210-d6d4183705cd', 'd0051d69-1d3f-4cef-a558-42e820d81d0b', 'edc06063-1ccb-4572-a128-a904fdff5d4b', '058f19c6-dc70-4b6a-8396-5b159c0ecd57', 'c17d385f-e4b0-4f71-a527-31d47f79cea6') and activeflag=1;

update progressnote
set focusperson='{
  "focuspersonjson": [
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "4ae028b9-277b-4288-9287-9a9e51d73bda",
      "participantid": "4ae028b9-277b-4288-9287-9a9e51d73bda",
      "firstname": "Joshua",
      "lastname": "Jones",
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
      "intakeservicerequestactorid": "732c84f2-ea98-4c88-a880-b9eb24411b27",
      "participantid": "732c84f2-ea98-4c88-a880-b9eb24411b27",
      "firstname": "Sarah",
      "lastname": "Worsley Edwards",
      "address1": null,
      "address2": null,
      "city": null,
      "state": null,
      "zipcode": null,
      "email": null,
      "phonenumber": null
    }
  ]
}', updatedby='CJAMS-68136', updatedon=now()
where progressnoteid='8f648cd1-7c38-4aee-91fd-88acea1755cd' and activeflag=1;

update progressnote
set focusperson ='{
  "focuspersonjson": [
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "4ae028b9-277b-4288-9287-9a9e51d73bda",
      "participantid": "4ae028b9-277b-4288-9287-9a9e51d73bda",
      "firstname": "Joshua",
      "lastname": "Jones",
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
      "intakeservicerequestactorid": "732c84f2-ea98-4c88-a880-b9eb24411b27",
      "participantid": "732c84f2-ea98-4c88-a880-b9eb24411b27",
      "firstname": "Sarah",
      "lastname": "Worsley Edwards",
      "address1": null,
      "address2": null,
      "city": null,
      "state": null,
      "zipcode": null,
      "email": null,
      "phonenumber": null
    }
  ]
}', updatedby='CJAMS-68136', updatedon=now()
where progressnoteid='0c2324c4-3e59-42b7-9087-79cdb225e474';

update progressnote
set focusperson='{
  "focuspersonjson": [
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "732c84f2-ea98-4c88-a880-b9eb24411b27",
      "participantid": "732c84f2-ea98-4c88-a880-b9eb24411b27",
      "firstname": "Sarah",
      "lastname": "Worsley Edwards",
      "address1": null,
      "address2": null,
      "city": null,
      "state": null,
      "zipcode": null,
      "email": null,
      "phonenumber": null
    }
  ]
}', updatedby='CJAMS-68136', updatedon=now()
where progressnoteid='54507b7f-b734-4178-a8f5-3671fb0390ad' and activeflag=1;

update progressnote
set focusperson='{
  "focuspersonjson": [
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "732c84f2-ea98-4c88-a880-b9eb24411b27",
      "participantid": "732c84f2-ea98-4c88-a880-b9eb24411b27",
      "firstname": "Sarah",
      "lastname": "Worsley Edwards",
      "address1": null,
      "address2": null,
      "city": null,
      "state": null,
      "zipcode": null,
      "email": null,
      "phonenumber": null
    }
  ]
}', updatedby='CJAMS-68136', updatedon=now()
where progressnoteid='7ed4f8ac-c9c6-41bb-b40a-e9b27f14f325' and activeflag=1;

