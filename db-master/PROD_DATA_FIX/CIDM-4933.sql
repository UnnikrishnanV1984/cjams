 /*
  Issue Description: Null service request number CIDM-4933
   Category/ Module  :  CPS investigaion case
   Root cause:
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/
update intakeservicerequest 
SET servicerequestnumber = '221020220143',
    updatedon = now(),
    updatedby = 'CIDM-4933'
WHERE intakenumber = 'I221010279849' and intakeserviceid='7b9765b5-1f9d-4720-8310-6beec7e02267';