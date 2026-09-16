/*
   Issue Description: CJAMS-65822-Service-Plan-Approval-Dates
   Category/ Module  : 
   Root cause: user want to update service plan approved by
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 

update snapshothist 
set approvaldate = '2026-02-23', updatedon= now(), updatedby='CJAMS-65822' 
where objectid='8d9baa31-0b69-4580-90a2-9218eebd2c15' and id='d6148ce9-558e-4676-b1cc-b563066e66cf' and activeflag = 1;