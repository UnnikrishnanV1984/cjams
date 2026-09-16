/*
Issue Description: User entered incorrect person with same name and now wants to remove incorrect person and add original person and also update same person in contact notes, and service case andother places.
Category/ Module: Removal
Root cause: Persons were added in error and need to be removed.
Fix provided: Yes, wrote DB query.
Code fix ticket#: CDM-37247
Reason why no related code fix: Status of the code fix already submitted 
Status of the code fix if already submitted and expected prod fix date: 
void the rejected provider placement from backend
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

/**Replaced Duplicate person with original person **/

update actor 
set personid='946c447d-ce47-49b8-8c23-27dd0aafbc45', updatedby ='CDM-37247', updatedon =now()
where personid='729820e8-a8f3-41b2-a8bf-7204706d26ea' and intakeserviceid ='9b6ccab5-9a7f-4e4b-81d4-1631fd4734b6' and activeflag =1;

update intakeservicerequestactor
set personid='946c447d-ce47-49b8-8c23-27dd0aafbc45',updatedby ='CDM-37247',updatedon =now()
where personid ='729820e8-a8f3-41b2-a8bf-7204706d26ea' and actorid ='b4eaddd1-63f6-49b0-b0be-b887db61275a' and activeflag =1;

update personrole
set personid='946c447d-ce47-49b8-8c23-27dd0aafbc45',updatedby ='CDM-37247',updatedon =now()
where personid ='729820e8-a8f3-41b2-a8bf-7204706d26ea' and intakeserviceid ='9b6ccab5-9a7f-4e4b-81d4-1631fd4734b6' and activeflag =1;

/***Update person name as duplicate**/

update person
set lastname='EnnalsDuplicate', updatedby='CDM-37247', updatedon =now()
where personid='729820e8-a8f3-41b2-a8bf-7204706d26ea' and activeflag=1;

/**** Remove Duplicate from intake **/

update actor
set personid='946c447d-ce47-49b8-8c23-27dd0aafbc45',updatedby ='CDM-37247', updatedon =now()
where intakeserviceid='10d0e6ee-14f9-47e8-a6de-9ecff0429a5e' and personid='729820e8-a8f3-41b2-a8bf-7204706d26ea' and activeflag=1;

update intakeservicerequestactor
set personid='946c447d-ce47-49b8-8c23-27dd0aafbc45',updatedby ='CDM-37247', updatedon =now()
where actorid='a091b745-64ec-4b09-91df-99fd1d12cf50' and personid='729820e8-a8f3-41b2-a8bf-7204706d26ea'  and activeflag = 1;

update personrole
set personroleid='946c447d-ce47-49b8-8c23-27dd0aafbc45',updatedby = 'CDM-37247',updatedon = now()
where personid='729820e8-a8f3-41b2-a8bf-7204706d26ea' and intakeserviceid='10d0e6ee-14f9-47e8-a6de-9ecff0429a5e' and activeflag = 1;


update progressnote
set 
focusperson='{
  "focuspersonjson": [
    {
      "participanttypekey": "IP",
      "intakeservicerequestactorid": "ad15708e-8b05-4f08-bac1-a56b3b5cec7c",
      "participantid": "ad15708e-8b05-4f08-bac1-a56b3b5cec7c",
      "firstname": "Amber",
      "lastname": "Satchell",
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
      "intakeservicerequestactorid": "80f9e7f1-ad2d-43f0-adff-98d9d6258423",
      "participantid": "80f9e7f1-ad2d-43f0-adff-98d9d6258423",
      "firstname": "Za''kari",
      "lastname": "Ennals",
      "address1": null,
      "address2": null,
      "city": null,
      "state": null,
      "zipcode": null,
      "email": null,
      "phonenumber": null
    }
  ]
}',updatedby ='CDM-37247', updatedon =now()
where witsid=12691552 and activeflag=1;