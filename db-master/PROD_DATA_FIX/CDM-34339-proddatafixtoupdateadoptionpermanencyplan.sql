/*
   Issue Description: CDM-34339
   Category/ Module  : Prod data fix to update the intakeservicerequestactor id
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- 76386d20-9059-40bd-b40b-b55a766f28e0
update permanencyplan set intakeservicerequestactorid = '63e0d85a-5f5a-4228-ab65-b76e17cb2a78', updatedby = 'CDM-34339', updatedon = now()
where permanencyplanid in ('66a63f0e-ca05-4870-8274-46a5f1e5037b',
'188a1dcd-0b08-44c6-bbee-65982cc23650',
'acead5f9-d7ed-4428-8d6e-9e6e31faf05d',
'140b29b1-d2d8-4be9-b578-ba2af452f144',
'2d1a44d5-a222-498a-a65b-0eece792f6ba') and intakeservicerequestactorid = '76386d20-9059-40bd-b40b-b55a766f28e0';


-- '2d1a44d5-a222-498a-a65b-0eece792f6ba'
update tprrecommendation set intakeservicerequestactorid = '63e0d85a-5f5a-4228-ab65-b76e17cb2a78', permanencyplanid = '0b1252dc-9e20-4755-9b0c-efa67044b9b3',
updatedby = 'CDM-34339', updatedon = now()
where tprrecommendationid = '749217c9-71c1-4f99-8b87-7c30587d0d71';