/*
 * CDM-37328 - Wrong client selected for Subject of Contact
 * Customer Email ID:kathleen.plant@maryland.gov
 * Customer Name: Kathleen Plant 
 * Focus Area:Assessments: Other
 * Description - For Contact note, Contact ID: 12700389, the wrong child was chosen. Need to remove Marleigh Munoz and add Giovanna Reyes instead. All other participants are correct. 
 * Update and Replace the  person contacted : 12700389
 * 
 */

select focusperson ,* from progressnote where progressnoteid = 'd3f40fd4-2e68-4136-9671-58d4f62d650d';

update progressnote set 
focusperson = '{
  "focuspersonjson": [
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "5d54e4e5-8272-42a1-8baf-94b12f7afb57",
      "participantid": "5d54e4e5-8272-42a1-8baf-94b12f7afb57",
      "firstname": "KAYLA",
      "lastname": "MCNAIR",
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
      "intakeservicerequestactorid": "d59d6be2-585f-42ce-9438-463219a83e4f",
      "participantid": "d59d6be2-585f-42ce-9438-463219a83e4f",
      "firstname": "GIOVANNA",
      "lastname": "REYES",
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
updatedby = 'CDM-37328'
where progressnoteid = 'd3f40fd4-2e68-4136-9671-58d4f62d650d';


select * from cjams.contactparticipant where progressnoteid = 'd3f40fd4-2e68-4136-9671-58d4f62d650d' and activeflag = 1;

update cjams.contactparticipant set participantid = 'd59d6be2-585f-42ce-9438-463219a83e4f', intakeservicerequestactorid = 'd59d6be2-585f-42ce-9438-463219a83e4f',
updatedon = now(), updatedby = 'CDM-37328'
where contactparticipantid = '3d925ddd-75a9-4b70-b9a6-12fdc701ebb2';