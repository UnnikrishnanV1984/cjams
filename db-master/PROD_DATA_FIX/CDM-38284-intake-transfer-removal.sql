/*
-- CDM-38284 - Remove cases referrals on dashboard that was assigned from other jurisdictions 
-- Issue Description: Please remove the case transfer approval as the referral has been closed by the Carrol county user.
-- Intake case number: I221010330837, I231010409130, I231010570168, I241012082296, I231011395253, I241011917040
-- Category/ Module: Decision
-- Root cause: User wants the cases to be removed from her Dashboard as they belong to other juridisdiction.
-- Fix Provided: Datafix has been provided to remove the Pending Transfer Request
-- Pull Request# N/A
*/
   
update intaketransfers
set    activeflag = 0,
       updatedby = 'CDM-38284',
       updatedon = now()
where  intaketransferid in ('84bcab1c-0ff7-48c9-b6fb-cd3dbc9b18b3','3a88feab-79ff-46ca-8c9d-b90ac984229a','8918535d-4850-4a16-b32d-8d3f68763721','ab1c7172-c199-4650-8bc9-fe10cae17ca1','783486ee-9f0c-4815-8199-b50e1c7ee49b','f620048d-be1a-4a0e-aa3d-91aa0d132181');

