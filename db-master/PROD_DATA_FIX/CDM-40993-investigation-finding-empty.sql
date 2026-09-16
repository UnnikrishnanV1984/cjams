/*
   Issue Description: CDM-40993 investigation approval information not shown 
   Category/ Module  :Case Closure
   Root cause: User error as incorrect Investigation finding record has been updated for the Investigation approval record information and the old record has become inactive .
   Fix provided : Data fix has been promoted to patch the correct investigation data for the case 241022430159
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update Investigationallegationmaltreators
set intakeservicerequestactorid = '73e150b1-b0d9-4aad-a63b-c5c2281372ea',
    updatedby = 'CDM-40993',
    updatedon = now()
where investigationallegationid ='fa312974-b6a8-4a58-9152-5cdbfd809e11';

update Investigationallegationmaltreators
set activeflag = 0,
    updatedby = 'CDM-40993',
    updatedon = now()
where investigationallegationid ='d21025c4-327e-4bc1-a065-de4780b7bb54';


update investigationallegation
set activeflag = 0,
    updatedby = 'CDM-40993',
    updatedon = now()
where investigationallegationid = 'd21025c4-327e-4bc1-a065-de4780b7bb54';
  