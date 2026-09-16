
/*
   Issue Description: CDM-33473
   Category/ Module  : Person
   Root cause:  User request to replace person
   Fix Provide: Did data fix to replace person in all tabs 
*/


update cjams.actor set personid ='9ce949b4-4114-4036-a0f4-31fc0ba7ef49', updatedby ='CDM-33473', updatedon = now()
where actorid ='91f3d39c-ad97-4b40-bf38-bb61edd2a4fc';

update cjams.intakeservicerequestactor set personid ='9ce949b4-4114-4036-a0f4-31fc0ba7ef49',updatedby ='CDM-33473', updatedon = now()
where actorid ='91f3d39c-ad97-4b40-bf38-bb61edd2a4fc';

update cjams.personrole set personid ='9ce949b4-4114-4036-a0f4-31fc0ba7ef49',updatedby ='CDM-33473', updatedon = now()
where personroleid ='dd060d85-7da6-4ee8-9dc4-206b6521d782';


   	update assessment 
    set submissiondata = replace(submissiondata::text, 'Christen Taylor Bozman', 'CHRISTEN MICHELLE SMITH')::json
	WHERE assessmentid = 'f7be68b1-d468-4750-bdd8-2c8076b26e79' AND activeflag = 1;

   	update assessment 
    set submissiondata = replace(submissiondata::text, 'Christen Bozman', 'CHRISTEN SMITH')::json
	WHERE assessmentid = 'f7be68b1-d468-4750-bdd8-2c8076b26e79' AND activeflag = 1;


   	update assessment 
    set submissiondata = replace(submissiondata::text, 'Christen Taylor Bozman', 'CHRISTEN MICHELLE SMITH')::json
	WHERE assessmentid = 'dd2ec445-ec9f-4508-a153-0f5a44a07319' AND activeflag = 1;

   	update assessment 
    set submissiondata = replace(submissiondata::text, 'Christen Taylor Bozman', 'CHRISTEN MICHELLE SMITH')::json
	WHERE assessmentid = '4613546b-30f9-4044-ab00-1b8f035f09ce' AND activeflag = 1;

   	update assessment 
    set submissiondata = replace(submissiondata::text, 'Christen Taylor Bozman', 'CHRISTEN MICHELLE SMITH')::json
	WHERE assessmentid = 'eb6cec2a-2b03-45c5-817e-8fd4c2d7bdfe' AND activeflag = 1;

     	update assessment 
    set submissiondata = replace(submissiondata::text, 'Christen Bozman', 'CHRISTEN SMITH')::json
	WHERE assessmentid = '4613546b-30f9-4044-ab00-1b8f035f09ce' AND activeflag = 1;

     	update assessment 
    set submissiondata = replace(submissiondata::text, '30,', '32,')::json
	WHERE assessmentid = '4613546b-30f9-4044-ab00-1b8f035f09ce' AND activeflag = 1;

     	update assessment 
    set submissiondata = replace(submissiondata::text, '"30",', '"32",')::json
	WHERE assessmentid = '4613546b-30f9-4044-ab00-1b8f035f09ce' AND activeflag = 1;

    	update assessment 
    set submissiondata = replace(submissiondata::text, '1992-09-03T04:00:00.000Z', '1990-06-10T04:00:00.000Z')::json
	WHERE assessmentid = '04064f70-0323-4a1c-a8d4-98c8b35aee56' AND activeflag = 1;

     	update assessment 
    set submissiondata = replace(submissiondata::text, '1992-09-02T04:00:00.000Z', '1990-06-10T04:00:00.000Z')::json
	WHERE assessmentid = 'f7be68b1-d468-4750-bdd8-2c8076b26e79' AND activeflag = 1;

     	update assessment 
    set submissiondata = replace(submissiondata::text, '30 Yrs', '32 Yrs')::json
	WHERE assessmentid = 'f7be68b1-d468-4750-bdd8-2c8076b26e79' AND activeflag = 1;

     	update assessment 
    set submissiondata = replace(submissiondata::text, '1992-09-03T04:00:00.000Z', '1990-06-10T04:00:00.000Z')::json
	WHERE assessmentid = 'dd2ec445-ec9f-4508-a153-0f5a44a07319' AND activeflag = 1;


update progressnote set 
focusperson = '{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"32192cad-0716-4cea-9d0c-d762126c8ab7","participantid":"32192cad-0716-4cea-9d0c-d762126c8ab7","firstname":"CHRISTEN","lastname":"SMITH","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP","intakeservicerequestactorid":"cd15ce14-c682-4f24-b492-f6abc2fd9292","participantid":"cd15ce14-c682-4f24-b492-f6abc2fd9292","firstname":"Carson","lastname":"Waltemeyer","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP","intakeservicerequestactorid":"b108817c-e39a-4b89-a25d-ba8c79c80453","participantid":"b108817c-e39a-4b89-a25d-ba8c79c80453","firstname":"Rowen","lastname":"Waltemeyer","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}',
updatedon = now(),
updatedby = 'CDM-33473'
where progressnoteid = 'b2a8d7e5-96ab-4023-83d6-2ec6032f4137';



update progressnote set 
focusperson = '{
  "focuspersonjson": [
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "0e60540e-54d8-4f7f-8333-eeb7358b7913",
      "participantid": "0e60540e-54d8-4f7f-8333-eeb7358b7913",
      "firstname": "Brandon",
      "lastname": "Waltimeyer",
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
      "intakeservicerequestactorid": "32192cad-0716-4cea-9d0c-d762126c8ab7",
      "participantid": "32192cad-0716-4cea-9d0c-d762126c8ab7",
      "firstname": "CHRISTEN",
      "lastname": "SMITH",
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
      "intakeservicerequestactorid": "e7467a93-e8ef-4ead-a44b-2a61d336249e",
      "participantid": "e7467a93-e8ef-4ead-a44b-2a61d336249e",
      "firstname": "Mylah",
      "lastname": "Smith",
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
      "intakeservicerequestactorid": "e1595162-7298-4eaf-a864-955019d09f25",
      "participantid": "e1595162-7298-4eaf-a864-955019d09f25",
      "firstname": "Calee",
      "lastname": "Smith",
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
      "intakeservicerequestactorid": "be4be295-f458-40f3-8921-0f145bcf5b95",
      "participantid": "be4be295-f458-40f3-8921-0f145bcf5b95",
      "firstname": "Aylin",
      "lastname": "Smith",
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
      "intakeservicerequestactorid": "b108817c-e39a-4b89-a25d-ba8c79c80453",
      "participantid": "b108817c-e39a-4b89-a25d-ba8c79c80453",
      "firstname": "Rowen",
      "lastname": "Waltemeyer",
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
      "intakeservicerequestactorid": "cd15ce14-c682-4f24-b492-f6abc2fd9292",
      "participantid": "cd15ce14-c682-4f24-b492-f6abc2fd9292",
      "firstname": "Carson",
      "lastname": "Waltemeyer",
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
updatedby = 'CDM-33473'
where progressnoteid = '7f7e0989-6125-443c-96cc-ffcb825a4f48';


update progressnote set 
focusperson = '{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"32192cad-0716-4cea-9d0c-d762126c8ab7","participantid":"32192cad-0716-4cea-9d0c-d762126c8ab7","firstname":"CHRISTEN","lastname":"SMITH","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null},{"participanttypekey":"IP","intakeservicerequestactorid":"b108817c-e39a-4b89-a25d-ba8c79c80453","participantid":"b108817c-e39a-4b89-a25d-ba8c79c80453","firstname":"Rowen","lastname":"Waltemeyer","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}',
updatedon = now(),
updatedby = 'CDM-33473'
where progressnoteid = '49db8ca0-7dce-400a-be3c-5d3dddb09703';





update progressnote set 
focusperson = '{
  "focuspersonjson": [
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "0e60540e-54d8-4f7f-8333-eeb7358b7913",
      "participantid": "0e60540e-54d8-4f7f-8333-eeb7358b7913",
      "firstname": "Brandon",
      "lastname": "Waltimeyer",
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
      "intakeservicerequestactorid": "32192cad-0716-4cea-9d0c-d762126c8ab7",
      "participantid": "32192cad-0716-4cea-9d0c-d762126c8ab7",
      "firstname": "CHRISTEN",
      "lastname": "SMITH",
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
      "intakeservicerequestactorid": "e7467a93-e8ef-4ead-a44b-2a61d336249e",
      "participantid": "e7467a93-e8ef-4ead-a44b-2a61d336249e",
      "firstname": "Mylah",
      "lastname": "Smith",
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
      "intakeservicerequestactorid": "e1595162-7298-4eaf-a864-955019d09f25",
      "participantid": "e1595162-7298-4eaf-a864-955019d09f25",
      "firstname": "Calee",
      "lastname": "Smith",
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
      "intakeservicerequestactorid": "be4be295-f458-40f3-8921-0f145bcf5b95",
      "participantid": "be4be295-f458-40f3-8921-0f145bcf5b95",
      "firstname": "Aylin",
      "lastname": "Smith",
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
      "intakeservicerequestactorid": "cd15ce14-c682-4f24-b492-f6abc2fd9292",
      "participantid": "cd15ce14-c682-4f24-b492-f6abc2fd9292",
      "firstname": "Carson",
      "lastname": "Waltemeyer",
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
      "intakeservicerequestactorid": "b108817c-e39a-4b89-a25d-ba8c79c80453",
      "participantid": "b108817c-e39a-4b89-a25d-ba8c79c80453",
      "firstname": "Rowen",
      "lastname": "Waltemeyer",
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
updatedby = 'CDM-33473'
where progressnoteid = 'e3d05d4b-3bcf-485a-a703-e3615cf77b76';
