/*
   Issue Description: CDM-36304 - Unable to send case for closure
   Category/ Module  :AR Summary 
   Root cause: assessmentactor record is missing for the child name Carlos Mazariegos
   Fix: Data fix to insert assessmentactor record
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

INSERT INTO cjams.assessmentactor
(assessmentid, intakeservicerequestactorid, issafe, activeflag, insertedby, updatedby, effectivedate, insertedon, updatedon)
VALUES('aa573ee7-a2f2-4870-83de-e3e69a3d14f9', '28ea7964-6ec3-4791-a527-0d0b5e8538fb', 1, 1, 'CDM-36304', 'CDM-36304', now(), now(), now());
