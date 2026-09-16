/*
   Issue Description: CDM-32556
   Category/ Module  :Contact notes
   Root cause: ::intakeservicerequestactorid not updated correctly 
   this is becuase once users added contact with old roles and after that user once updated the new role in the person tab
   Fix Provided; Did data fix to updated correct intakeservicerequestactorid  
   Reason why no related code fix:  Data fix
*/


---intakeservicerequestactorid was incorrect so updating correct one --bf742f6f-5c05-4349-bb1a-cac2a8368fd3
update cjams.contactparticipant set intakeservicerequestactorid ='aa273858-6d70-44bc-9aef-945e21017473', updatedby ='CDM-32556', updatedon = now()
where contactparticipantid ='90b3304f-4c78-4996-9193-0e9388df285b';