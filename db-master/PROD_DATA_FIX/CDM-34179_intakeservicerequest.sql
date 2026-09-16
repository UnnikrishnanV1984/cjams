/*
   Issue Description: CDM-34179
   Category/ Module: servicerequest
   Root cause: Case disappeared
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
*/

UPDATE cjams.intakeservicerequest
SET activeflag=1, updatedby='CDM-34179', updatedon=now()
WHERE intakeserviceid='37fae2f5-729b-43aa-b1b0-56919c63d116'::uuid and servicerequestnumber='231020710745' and intakenumber='I231010786626';
