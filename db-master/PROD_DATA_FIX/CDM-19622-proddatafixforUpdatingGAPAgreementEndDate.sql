
/*
   Issue Description: CDM-19622
   Category/ Module  : Updating GAP Agreement End date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

  
  -- 2021-11-03 04:00:00
update gapagreement set enddate = '2022-11-03 04:00:00', updatedon = now(), updatedby = 'CDM-19622' where gapagreementid = 'ac403637-11b2-482f-9f3d-901047c47427';
update gapagreementrevision set enddate = '2022-11-03 04:00:00',approvaldate = now() , updatedon = now(), updatedby = 'CDM-19622' where gapagreementid = 'ac403637-11b2-482f-9f3d-901047c47427' and activeflag = 1;


-- 071292d0-5a51-4837-be16-10e0485bab14     
update routing set fromsecurityusersid = 'ba2dbc8f-3213-4b1b-9905-d643e1692db1', updatedon = now(), updatedby = 'CDM-19622' where routingid = 'e8f328d1-deb2-44c2-9576-7ab2e3377953';
  
-- 7259e8f8-d99b-4254-a797-cc93328e1391 , 2020-10-23 03:34:14    
update routing set fromsecurityusersid = 'd2757853-26b7-4656-9189-c890ef76cbcb', insertedon = '2022-01-11 11:00:00' , updatedon = now(), updatedby = 'CDM-19622' where routingid = '071292d0-5a51-4837-be16-10e0485bab14';
