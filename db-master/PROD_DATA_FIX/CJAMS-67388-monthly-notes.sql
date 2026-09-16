/*
   Issue Description: CJAMS-67388
   Category/ Module  : Contact notes
   Root cause: Requested to add Carter or Chance Wright in the subject section.
   Fix provided: Data fix is done to add Carter or Chance Wright in the subject section.
   Pull request# for code fix: 
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update progressnote 
set focusperson ='{
    "focuspersonjson": [
        {
        "participanttypekey": "IP",
        "intakeservicerequestactorid": "aa4ea90f-c239-4592-b5bc-9d4afb331c1f",
        "participantid": "aa4ea90f-c239-4592-b5bc-9d4afb331c1f",
        "firstname": "LUCIA",
        "lastname": "MOSLEY",
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
        "intakeservicerequestactorid": "e8097b60-feeb-450a-b7fd-19c526e527b5",
        "participantid": "e8097b60-feeb-450a-b7fd-19c526e527b5",
        "firstname": "Carter",
        "lastname": "Wright",
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
        "intakeservicerequestactorid": "34abb7a0-2dc7-48fb-b790-0dbb4c72cbd1",
        "participantid": "34abb7a0-2dc7-48fb-b790-0dbb4c72cbd1",
        "firstname": "Chance",
        "lastname": "Wright",
        "address1": null,
        "address2": null,
        "city": null,
        "state": null,
        "zipcode": null,
        "email": null,
        "phonenumber": null
        }
    ]
}', updatedby ='CJAMS-67388', updatedon =now()
where progressnoteid ='7b18312d-23d3-4ca7-9141-68324b03c902';