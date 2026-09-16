/*
   Issue Description: CDM-32812
   Category/ Module  : Head of Household
   Root cause: 231030063367:Jessica Kazmaier needs to be added as head of household.
   Case Number: the client ID # 4396195 (JESSICA BROOKE KAZMAIER) is missing from Intake # I231010391328, CPS AR case # 231020328390 and Service Case # 231030063367.
   Pull request# for data fix: 
   Reason why no related code fix: 
   Description: 231030063367:Jessica Kazmaier needs to be added as head of household. When you search the case by the case number she shows up as head of household. 
   She is not listed in the persons tab so when I searched for her to add her she is showing already in case. 
   I need her to be the head of household and to pay for services. Screen URL: 
   https://cw.cjams.mdthink.maryland.gov/#/pages/case-worker/cf80c107-8550-4206-85cd-70228058f6d5/231030063367/dsds-action/person-cw/list
*/


select isprimary, * from intakeservicerequestactor where intakenumber = 'I231010391328' and activeflag = 1 and isprimary = false;

UPDATE cjams.intakeservicerequestactor
SET isprimary=true, updatedby='CDM-32812', updatedon=now()
WHERE intakeservicerequestactorid='3617d568-92c0-4654-9574-b58f163b5523' and intakenumber='I231010391328';
