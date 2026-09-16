/*
   Issue Description: CDM-28493
   Category/ Module  :Contact notes
   Root cause: ::intakeservicerequestactorid not updated correctly 
   Reason why no related code fix:  Data fix
*/

---intakeservicerequestactorid was incorrect so updating correct one 
update cjams.contactparticipant set intakeservicerequestactorid ='03ecfa97-0693-4364-bbb5-267e6dc2c6b2', updatedby ='CDM-31479', updatedon = now()
where contactparticipantid ='1613718a-c2cd-47cc-ae7b-1e88c3dbe65a';
---42f05951-2bb2-454a-8ce3-54aa1a841039