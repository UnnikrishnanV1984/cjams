/*
   Issue Description: CJAMS-67997
   Category/ Module  : person & Contacts
   Root cause: User requested to data fix for 
        1. remove Brian Weibell (CJAMS PID# 204903807) and Baby Weibell (CJAMS PID# 204903811) from Persons tab
        2. For Contact ID: 16228544, Remove Brian Weibell from Person Contacted and add Brian Moranchel in Person Contacted
        3. For Contact ID: Contact ID: 16228544, 16228567 remove Brian Weibell, Baby Weibell and Audrey Moranchel from Who is the subject of the contact and add Audrey Moranchel
   Fix Provided: Data fix was done by 
        1. removed Brian Weibell (CJAMS PID# 204903807) and Baby Weibell (CJAMS PID# 204903811) from Persons tab
        2. For Contact ID: 16228544, Removed Brian Weibell from Person Contacted and added Brian Moranchel in Person Contacted
        3. For Contact ID: Contact ID: 16228544, 16228567 removed Brian Weibell, Baby Weibell and Audrey Weibell from Who is the subject of the contact and added Audrey Moranchel
    Code Fix: Not Needed
*/

update actor
set activeflag=0, updatedby= 'CJAMS-67997', updatedon=now()
where actorid in ('cc03c229-a5c4-453c-8085-128d076ffc4b', '95dc455e-9b14-4d4f-b9f1-021b011b53cb') and activeflag=1;

update intakeservicerequestactor
set activeflag=0, updatedby= 'CJAMS-67997', updatedon=now()
where intakeservicerequestactorid in ('9bb4444b-df45-4ab5-870e-a0ab614fe3ae', '65e764d0-e0ca-49fd-9c44-dde24af68f72') and activeflag=1;

update personrole   
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-67997'
where personroleid in('e4694c2c-17ec-4e0d-8749-a35673854104', '19ff9a2a-a654-47a4-8b0e-cc9ea1bc3cfd') and activeflag=1;

update personroletype
set activeflag=0, updatedby= 'CJAMS-67997', updatedon=now()
where personroletypeid in ('bdd016ae-abe8-49ff-9eb8-ee8233687c01','a7272a4d-b6f2-47e9-ad1b-4415fa00eec2') and activeflag=1;

update actorrelationship
set activeflag=0, updatedby= 'CJAMS-67997', updatedon=now()
where actorrelationshipid='539d6ce3-d734-4bb8-89f2-66a7307aadfb' and activeflag=1;

update actor
set activeflag=0, updatedby= 'CJAMS-67997', updatedon=now()
where actorid in ('d93b7712-55c0-403a-83fd-0568dc8f0574', '0f166b27-1bb9-4e28-90f8-2cb5d218bd37') and activeflag=1;

update intakeservicerequestactor
set activeflag=0, updatedby= 'CJAMS-67997', updatedon=now()
where intakeservicerequestactorid in ('1072fa48-4a20-48fa-aa58-6625166c6a4f', '85d00df2-8e4a-4c5a-9b6e-cb9becd4ae94') and activeflag=1;

update personrole   
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-67997'
where personroleid in('fcc7a90e-7f1d-4829-b264-e92fc4ffaffe', '2f5ba093-6947-4c3e-86da-ee646aac42dc') and activeflag=1;

update personroletype
set activeflag=0, updatedby= 'CJAMS-67997', updatedon=now()
where personroletypeid in ('10b70206-1b7b-43ee-b0fa-55c0b5fc478e','89a75068-4e58-44b1-8c34-883bb914c583') and activeflag=1;

update actorrelationship
set activeflag=0, updatedby= 'CJAMS-67997', updatedon=now()
where actorrelationshipid='f4d9d459-048b-4a15-8274-9e1cbb3691c8' and activeflag=1;

update contactparticipant
set activeflag=0, updatedby= 'CJAMS-67997', updatedon=now()
where contactparticipantid='027fcb37-2cf6-4ea0-833a-3eb05f4e4861' and activeflag=1;

insert into contactparticipant
(contactparticipantid, progressnoteid, participanttypekey, intakeservicerequestactorid, activeflag, effectivedate, insertedby,
insertedon, updatedby, updatedon, participantid)
values (gen_random_uuid(), '5a941d0f-fb47-4335-92df-6588f54809cf', 'IP', 'a4ec4326-fd21-4493-832f-dbc45a746812', 1, now(),
'CJAMS-67997', now(), 'CJAMS-67997', now(), 'a4ec4326-fd21-4493-832f-dbc45a746812');

update progressnote
set focusperson ='{
  "focuspersonjson": [
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "53f61a78-8233-4132-ad6f-308786ce3e0b",
      "participantid": "53f61a78-8233-4132-ad6f-308786ce3e0b",
      "firstname": "Audrey",
      "lastname": "Moranchel",
      "address1": null,
      "address2": null,
      "city": null,
      "state": null,
      "zipcode": null,
      "email": null,
      "phonenumber": null
    }
  ]
}', updatedby= 'CJAMS-67997', updatedon=now()
where progressnoteid='3844ac28-e14d-41b0-b53c-c83a56ced7e4' and activeflag=1;

update progressnote
set focusperson ='{
  "focuspersonjson": [
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "53f61a78-8233-4132-ad6f-308786ce3e0b",
      "participantid": "53f61a78-8233-4132-ad6f-308786ce3e0b",
      "firstname": "Audrey",
      "lastname": "Moranchel",
      "address1": null,
      "address2": null,
      "city": null,
      "state": null,
      "zipcode": null,
      "email": null,
      "phonenumber": null
    }
  ]
}', updatedby= 'CJAMS-67997', updatedon=now()
where progressnoteid='5a941d0f-fb47-4335-92df-6588f54809cf' and activeflag=1;