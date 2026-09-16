/*
   Issue Description: CDM-37750
   Category/ Module  :Person Contacted Needs to be Changed
   Root cause: remove the client Marleigh Munoz and add Giovanna Reyes in the field " Person Contacted"
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update contactparticipant set intakeservicerequestactorid ='d59d6be2-585f-42ce-9438-463219a83e4f', updatedby ='CDM-37750', updatedon=now()
where contactparticipantid ='722a82eb-5b5a-4b67-9ec1-4c3b281b3808'
and progressnoteid ='809d64a2-8fcb-4f72-938b-1f268bb1cf0d' and activeflag=1;