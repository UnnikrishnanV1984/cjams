
/*
Category/Module: Support
Root cause: The user was incorrectly selected the person in the Person contacted, and requesting to remove/delete those selected person.

Contact ID: 16037013
Contact Date : 03/11/2026
Person Name: Graham Zirpolo, Theodore Zirpolo, Walker Zirpolo, August Zirpolo, Jordan Gemmill, and Ashley Citro

Fix provided: DB queries delete record in contactparticipant
Data/Code fix ticket#: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:
*/


update contactparticipant
  SET activeflag = 0, 
      updatedby = 'CJAMS-66944' , 
      updatedon = now()
WHERE progressnoteid = 'b0c624ed-198a-4eaf-9fd1-6b83f465c2fe' and intakeservicerequestactorid in ('1d6422e5-3e26-452d-9cb4-4e8d41a6cced',
'78a40847-4117-4359-8b8d-7afbcb253d6c',
'7d298612-95bb-4837-a395-2c0ba4a8ffd0',
'ac729de7-5193-4f66-b06a-3ce8e7314702',
'b06b50b1-73b2-4489-b7bf-1b686ef6645c',
'fec413b3-e0bb-4bf2-a5e0-a2d4b3c8ff47')
   and activeflag = 1;
  