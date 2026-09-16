 /*
  Issue Description:CDM-24011
   Category/ Module  :  Two of the same person.
   Root cause:
   Pull request# for code fix: Fixed as part of user story
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update cjams.personrole set activeflag=0,
updatedby='CDM-24011',
updatedon=now()
where personid='d8e5bf99-4aaf-483d-8e6d-cc25348a906d' 
and activeflag=1
and intakeserviceid='3080f58f-e6a9-4b1e-a07a-bd68f6dc9e28' 
and personroleid='a8d9a80c-ddfa-4d6d-87da-1e29a57b01b7';