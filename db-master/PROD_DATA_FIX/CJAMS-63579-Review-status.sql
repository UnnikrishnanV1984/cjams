/*
   Issue Description: CJAMS-63579, CPS IR # 231020618422 has been closed on 08/30/2023,
   Supervisor approved for completion of the case CPS-IR : 231020618422, Status in Decision tab for supervisor still showing Review, please data fix it to accepted
   Category/ Module  : decision
   Root cause: Supervisor approved for completion of the case CPS-IR : 231020618422, Status in Decision tab for supervisor still showing Review, please data fix it to accepted
   Fix Provided: Data fix has been promoted to fix for the partial transection.
*/

update intakeservicerequestdispositioncode
set intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',--0fb08074-540f-47a6-87ed-1622288996d1
    servicerequesttypeconfigiddispostionid = '9a333c30-8043-4732-9f9a-622b8d8038da',
    description = 'Accepted',
    updatedby = 'CJAMS-63579',
    updatedon = now()
WHERE intakeserviceid = '9180e631-e32f-4c10-86fe-8ccac8146ded'
	and intakeservicerequestdispositioncodeid = '0cb632a7-2882-4cb4-8c32-7ecbfc7a2c96';
