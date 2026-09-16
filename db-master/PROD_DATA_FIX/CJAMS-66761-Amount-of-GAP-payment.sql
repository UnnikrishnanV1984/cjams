/*
   Issue Description: CJAMS-66761
   Category/ Module  : Prod data fix to update gap rate amount
   Root cause: Need to provide the data fix to update the rate amount 33.66 to 1009.8 for the below case ID.
Case ID: 231030147416
Client ID: 200806401 (Logan Evering)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update gapagreementrate
set paymentamout='1009.80', updatedon = now(), updatedby ='CJAMS-66761'
where gapagreementrateid='153cdcb6-30ff-4936-ab6b-5d2a8f00fbb8' and gapagreementid='36a3adcb-47c7-4366-88fb-5659f6e7a432' and activeflag = 1;

update gapratesrevision 
set paymentamt = '1009.80', approvaldate = now() , updatedby = 'CJAMS-66761', updatedon = now() 
where gaprateid = '153cdcb6-30ff-4936-ab6b-5d2a8f00fbb8' and activeflag = 1;
   