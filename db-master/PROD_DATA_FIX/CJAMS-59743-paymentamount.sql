/*
   Issue Description: CJAMS-59743- 3145181:Client Dallas Bennett- 3264741 Has the wrong subsidy rate dates and amount that need to be fixed.The rate year 3/11/25-3/11/25 needs to be corrected. The rate start date should be 3/11/25 the rate end date should be 9/24/25. The amount should be $621.Can all of this be updated.
   Category/ Module  : subsidy amount
   Root cause:User entered wrong subsidy amount and requested to update
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update gapagreementrate 
set paymentamout =621, enddate = '2025-09-24T00:00:00', updatedon =now(), updatedby ='CJAMS-59743'
where gapagreementrateid ='d9858d2f-8321-46ad-8666-86a2ad6a9eed';

update gapratesrevision 
set paymentamt =621, rateenddate = '2025-09-24T00:00:00', approvaldate = now(), updatedon =now(), updatedby ='CJAMS-59743'
where gaprateid ='d9858d2f-8321-46ad-8666-86a2ad6a9eed';