
/*
-- Issue Description: 
	221020231240:I entered a contact note on 7.23.22 at 8:51pm for case M. Rogers (CJAMS #221020231240). I selected the participant Melissa Rogers 
    (parent) but it autofilled the name Dana Carter, who was the parent in a referral that I took over the weekend. 
	
-- Root cause: 
---Fix : This case is updated as with personprogram id so that it shown with his own name 

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakeservicerequestactor set personid='fac23693-0399-4a7e-a866-6b37ca0bf8c5',
updatedby = 'CDM-24114',
 updatedon = now()
where intakeservicerequestactorid='427b18ca-f13b-4006-aa92-0d5cd55f6124';


update progressnote set focusperson='{
  "focuspersonjson": [
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "427b18ca-f13b-4006-aa92-0d5cd55f6124",
      "participantid": "427b18ca-f13b-4006-aa92-0d5cd55f6124",
      "firstname": "Melissa",
      "lastname": "Rogers",
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
updatedby = 'CDM-24114',
 updatedon = now() where  progressnoteid='9942b7ea-b25e-4ea7-a271-8278778c0a42';