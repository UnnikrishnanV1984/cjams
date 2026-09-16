/*
   Issue Description: CJAMS-66383 - Remove the client ID # 204826354 from the CPS AR case # 261023684637,
   Category/ Module  : Delete Person from case
   Root cause: User wants to remove the person from the case
   Fix Provided :Data fix has been promoted to delete person from case
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update actor
set activeflag=0, updatedby='CJAMS-66383', updatedon=now()
where actorid in('9636d368-846c-46a8-baaf-5316efd86897', '43929f90-dafb-4784-8b22-5ec8883e02a4') and activeflag=1;

update intakeservicerequestactor
set activeflag=0, updatedby='CJAMS-66383', updatedon=now()
where intakeservicerequestactorid in ('c25de58b-adbb-4bc4-bde1-2b9659a999cd','df3747ae-c08b-4b38-9a56-c60d09996145', '7076214a-0c29-4d01-89bb-a6a24ec83406', 'bcd8c692-a813-40d1-af0d-9d330fc0d6bc') and activeflag=1;

update personrole
set activeflag=0, updatedby='CJAMS-66383', updatedon=now()
where personroleid='a48785fa-3854-4c0e-a08e-8b80c4194be6' and personid='634967f7-db72-455b-8b22-6a1856316dd4' and activeflag=1;

update personroletype 
set activeflag =0, updatedby='CJAMS-66383', updatedon=now()
where personroletypeid ='c807a69a-347c-454b-896f-a6bd053b141b' and activeflag=1;

update personprogramarea 
set activeflag =0, updatedby='CJAMS-66383', updatedon=now()
where personid='634967f7-db72-455b-8b22-6a1856316dd4' and personprogramid='996603aa-dcb6-4982-b541-ae4196b8be82' and activeflag=1;

update actorrelationship 
set activeflag =0, updatedby='CJAMS-66383', updatedon=now()
where intakeservicerequestactorid in ('df3747ae-c08b-4b38-9a56-c60d09996145', '7076214a-0c29-4d01-89bb-a6a24ec83406', 'bcd8c692-a813-40d1-af0d-9d330fc0d6bc') and activeflag=1;

UPDATE progressnote
SET focusperson = '{
  "focuspersonjson": [
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "29fafee0-a3a1-4ba1-aead-05d8588ca2eb",
      "participantid": "29fafee0-a3a1-4ba1-aead-05d8588ca2eb",
      "firstname": "ZOEY",
      "lastname": "GILLIAM",
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
      "intakeservicerequestactorid": "84cacb86-2976-43bd-bac3-bfad027108ba",
      "participantid": "84cacb86-2976-43bd-bac3-bfad027108ba",
      "firstname": "Kingston",
      "lastname": "Gilliam",
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
      "intakeservicerequestactorid": "0d81063d-54d8-4bd9-9e9e-fe38c6e32a63",
      "participantid": "0d81063d-54d8-4bd9-9e9e-fe38c6e32a63",
      "firstname": "ANTONIO",
      "lastname": "GOODS",
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
      "intakeservicerequestactorid": "5b304379-f525-4315-93cc-2c192af6fc0f",
      "participantid": "5b304379-f525-4315-93cc-2c192af6fc0f",
      "firstname": "Antonio",
      "lastname": "Goods",
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
      "intakeservicerequestactorid": "34f373e4-9e8d-46aa-a4e0-6d7f6adb1870",
      "participantid": "34f373e4-9e8d-46aa-a4e0-6d7f6adb1870",
      "firstname": "DAYKEIA",
      "lastname": "GILLIAM",
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
      "intakeservicerequestactorid": "591a11cf-5eb6-4a40-980a-83041f91fae4",
      "participantid": "591a11cf-5eb6-4a40-980a-83041f91fae4",
      "firstname": "Day''Lin",
      "lastname": "Goods",
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
      "intakeservicerequestactorid": "dc38b96a-d518-4b6a-837a-f11a20c8edef",
      "participantid": "dc38b96a-d518-4b6a-837a-f11a20c8edef",
      "firstname": "Madisyn",
      "lastname": "Goods",
      "address1": null,
      "address2": null,
      "city": null,
      "state": null,
      "zipcode": null,
      "email": null,
      "phonenumber": null
    }
  ]
}', updatedby = 'CJAMS-66383', updatedon = NOW()
WHERE progressnoteid = 'b631ccc0-4efa-463f-bafa-4317f10067d6';

update progressnote
set focusperson ='{
  "focuspersonjson": [
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "29fafee0-a3a1-4ba1-aead-05d8588ca2eb",
      "participantid": "29fafee0-a3a1-4ba1-aead-05d8588ca2eb",
      "firstname": "ZOEY",
      "lastname": "GILLIAM",
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
      "intakeservicerequestactorid": "84cacb86-2976-43bd-bac3-bfad027108ba",
      "participantid": "84cacb86-2976-43bd-bac3-bfad027108ba",
      "firstname": "Kingston",
      "lastname": "Gilliam",
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
      "intakeservicerequestactorid": "0d81063d-54d8-4bd9-9e9e-fe38c6e32a63",
      "participantid": "0d81063d-54d8-4bd9-9e9e-fe38c6e32a63",
      "firstname": "ANTONIO",
      "lastname": "GOODS",
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
      "intakeservicerequestactorid": "5b304379-f525-4315-93cc-2c192af6fc0f",
      "participantid": "5b304379-f525-4315-93cc-2c192af6fc0f",
      "firstname": "Antonio",
      "lastname": "Goods",
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
      "intakeservicerequestactorid": "34f373e4-9e8d-46aa-a4e0-6d7f6adb1870",
      "participantid": "34f373e4-9e8d-46aa-a4e0-6d7f6adb1870",
      "firstname": "DAYKEIA",
      "lastname": "GILLIAM",
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
      "intakeservicerequestactorid": "591a11cf-5eb6-4a40-980a-83041f91fae4",
      "participantid": "591a11cf-5eb6-4a40-980a-83041f91fae4",
      "firstname": "Day''Lin",
      "lastname": "Goods",
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
      "intakeservicerequestactorid": "dc38b96a-d518-4b6a-837a-f11a20c8edef",
      "participantid": "dc38b96a-d518-4b6a-837a-f11a20c8edef",
      "firstname": "Madisyn",
      "lastname": "Goods",
      "address1": null,
      "address2": null,
      "city": null,
      "state": null,
      "zipcode": null,
      "email": null,
      "phonenumber": null
    }
  ]
}', updatedby = 'CJAMS-66383', updatedon = NOW()
where progressnoteid='3df9454f-d2b2-4472-be2d-533b3e27b05f';

update contactparticipant
set activeflag=0, updatedby = 'CJAMS-66383', updatedon = NOW()
where contactparticipantid='c1109329-394e-48b7-b4cb-dfa544a0cefa' and intakeservicerequestactorid='df3747ae-c08b-4b38-9a56-c60d09996145';

update progressnote
set focusperson = '{
  "focuspersonjson": [
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "29fafee0-a3a1-4ba1-aead-05d8588ca2eb",
      "participantid": "29fafee0-a3a1-4ba1-aead-05d8588ca2eb",
      "firstname": "ZOEY",
      "lastname": "GILLIAM",
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
      "intakeservicerequestactorid": "84cacb86-2976-43bd-bac3-bfad027108ba",
      "participantid": "84cacb86-2976-43bd-bac3-bfad027108ba",
      "firstname": "Kingston",
      "lastname": "Gilliam",
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
      "intakeservicerequestactorid": "5b304379-f525-4315-93cc-2c192af6fc0f",
      "participantid": "5b304379-f525-4315-93cc-2c192af6fc0f",
      "firstname": "Antonio",
      "lastname": "Goods",
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
      "intakeservicerequestactorid": "591a11cf-5eb6-4a40-980a-83041f91fae4",
      "participantid": "591a11cf-5eb6-4a40-980a-83041f91fae4",
      "firstname": "Day''Lin",
      "lastname": "Goods",
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
      "intakeservicerequestactorid": "dc38b96a-d518-4b6a-837a-f11a20c8edef",
      "participantid": "dc38b96a-d518-4b6a-837a-f11a20c8edef",
      "firstname": "Madisyn",
      "lastname": "Goods",
      "address1": null,
      "address2": null,
      "city": null,
      "state": null,
      "zipcode": null,
      "email": null,
      "phonenumber": null
    }
  ]
}', updatedby = 'CJAMS-66383', updatedon = NOW()
where progressnoteid='4364f939-6fe0-4584-a906-3b4baf945a23';