/*
Issue Description:CJAMS-68892-Remove person
Category/Module: persons tab
Root cause: user has requested to remove the person LYONNAH ISAAC, CJAMS PID 4260016 from case
Fix provided: Data fix has been done to remove the person from case  LYONNAH ISAAC, CJAMS PID 4260016
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update actor
set
    activeflag = 0,
    updatedby = 'CJAMS-68892',
    updatedon = now ()
where
    actorid = '7107b745-e9ee-4430-bb74-75c238e42cde'
    and personid = 'd46a5146-fa6d-48e4-b7d9-b6a009d2a640'
    and activeflag = 1;

update intakeservicerequestactor
set
    activeflag = 0,
    updatedby = 'CJAMS-68892',
    updatedon = now ()
where
    intakeservicerequestactorid = '2e811e93-37d5-4893-9b83-421133d16455'
    and actorid = '7107b745-e9ee-4430-bb74-75c238e42cde'
    and activeflag = 1;

update personrole
set
    activeflag = 0,
    updatedby = 'CJAMS-68892',
    updatedon = now ()
where
    personroleid = '96198e2a-93c3-4a9f-85af-4e711398b1fd'
    and personid = 'd46a5146-fa6d-48e4-b7d9-b6a009d2a640'
    and activeflag = 1;
   

update personroletype
set
    activeflag = 0,
    updatedby = 'CJAMS-68892',
    updatedon = now ()
where
    personroleid = '96198e2a-93c3-4a9f-85af-4e711398b1fd'
    and personroletypeid = '40dd2bb0-8d6c-4d0f-ab37-e710d6ccf13f'
    and activeflag = 1;

update actorrelationship
set
    activeflag = 0,
    updatedby = 'CJAMS-68892',
    updatedon = now ()
where
    intakeservicerequestactorid = '2e811e93-37d5-4893-9b83-421133d16455'
    and activeflag = 1;

update personprogramarea
set
    activeflag = 0,
    updatedby = 'CJAMS-68892',
    updatedon = now ()
where
    personid = 'ce32633d-d283-4c37-b4ed-7117b1daeb9d'
    and personprogramid = '14af28de-14c5-478f-b5bf-85f8a969ef0e'
    and activeflag = 1;
   
 -- Removing  person  in Who is the subject of the contact?  
update progressnote
set focusperson = $json${
  "focuspersonjson": [
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "03849678-bc61-42d8-b05f-e09975536a83",
      "participantid": "03849678-bc61-42d8-b05f-e09975536a83",
      "firstname": "SADE",
      "lastname": "YOUNG",
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
      "intakeservicerequestactorid": "2580c9eb-751c-464a-b54e-7f2a41dadd50",
      "participantid": "2580c9eb-751c-464a-b54e-7f2a41dadd50",
      "firstname": "CHIONNAH",
      "lastname": "ISAAC",
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
      "intakeservicerequestactorid": "0d5ccf93-a22b-4daa-9600-7d0f81bd2de2",
      "participantid": "0d5ccf93-a22b-4daa-9600-7d0f81bd2de2",
      "firstname": "I'Yonnah",
      "lastname": "Isaac",
      "address1": null,
      "address2": null,
      "city": null,
      "state": null,
      "zipcode": null,
      "email": null,
      "phonenumber": null
    }

  ]
}$json$,
updatedby ='CJAMS-68892',
updatedon =now()
WHERE progressnoteid = '9cf7a1ba-524c-4a12-bede-1675fa88c595';


-----Removing person from 	Person Contacted

update contactparticipant 
set activeflag =0,
updatedby ='CJAMS-68892',
updatedon =now()
where contactparticipantid ='6f0d5ea6-9a7e-4b35-80b6-6b742514cc41' and activeflag =1;