/*
  Issue Description: CDM-31111-the checkbox is not checked in overdue reason.
  Root cause: Contact with alleged victim is made timely, but the checkbox is not checked in overdue reason.
  Fix provided : Upon pasing the required param to the creteservice able to 
  see the service case in jump server
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/
update cpsresponsetimeractions set allegedvictimcontact = 'true', updatedby='CDM-31111',updatedon=now() where cpsresponsetimeractionsid ='b33fb4e6-e0e0-4711-88e2-5280ce53fc74';
