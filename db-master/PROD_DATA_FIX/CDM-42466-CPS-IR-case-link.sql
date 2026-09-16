/*
  Issue Description:  CDM-42466
   Category/ Module  : Intake
   Root cause: Intake is missing subtype values
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup before update/ delete: NA
*/

--UPDATE Intake to CPS-IR

update routing 
set routingstatustypeid = 2, updatedon = now()
where routingid='2ded5419-719c-401d-a4f3-d7cc6972be1b';

update intakeservicerequest 
set actiontype = 'IR', intakeserreqstatustypeid= '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
intakeservicerequestclassid = '3e026a57-247c-4203-82b7-62749c98ccc5', 
updatedon = now(), updatedby = 'CDM-42466' 
where intakeserviceid = '5cbc6dea-9599-4763-83b4-d8b3d663f821';


UPDATE cjams.intakeservicerequestdispositioncode
SET  updatedby='CDM-42466', updatedon=now(), intakeserreqstatustypeid='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690'::uuid, 
servicerequesttypeconfigiddispostionid='9a333c30-8043-4732-9f9a-622b8d8038da'::uuid
WHERE intakeserviceid='5cbc6dea-9599-4763-83b4-d8b3d663f821'::uuid;


update personprogramarea
set subprogramkey='IR', updatedby='CDM-42466', updatedon=now()
where personid = '04693155-d44e-49e1-a0b4-d68b591a191b' and entityid='241022947166';

update personprogramarea
set subprogramkey='IR', updatedby='CDM-42466', updatedon=now()
where personid = '2c00f312-4139-437c-9962-5226830b97d9' and entityid='241022947166';

update personprogramarea
set subprogramkey='IR', updatedby='CDM-42466', updatedon=now()
where personid = '5db385f1-7548-4fbc-9fb1-12bcb7d45b5c' and entityid='241022947166';

update personprogramarea
set subprogramkey='IR', updatedby='CDM-42466', updatedon=now()
where personid = 'd39b4753-8369-4580-ba9c-d71b8bbf0b44' and entityid='241022947166';

update intakedastaging
set insertedon='2024-11-04 15:47:39', status='Complete', updatedon=now()
where intakenumber='I241013165811' and activeflag=1;