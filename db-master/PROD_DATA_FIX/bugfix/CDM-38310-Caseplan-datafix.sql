/*
  Issue Description:  CDM-38310
   Category/ Module  :  CasePlan 
   Root cause: Case plan in Approved status but the record should be in Draft status
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


update snapshothist set approvalstatus= null, updatedby='38310', updatedon=now()
where id = 'cc7877e0-9f52-4d68-a571-156de2136677' and objectid = 'eb409627-bd72-43b7-887c-eb2e97ae40df' and approvalstatus = 'Approved' and activeflag = 1;

update snapshothist set approvalstatus= null, updatedby='38310', updatedon=now()
where id = '8fb7a11a-7148-41ae-8db7-7f59b8cf8af7' and objectid = 'eb409627-bd72-43b7-887c-eb2e97ae40df' and approvalstatus = 'Approved' and activeflag = 1;

update snapshothist set approvalstatus= null, updatedby='38310', updatedon=now()
where id = '0c9fef97-2cdf-4646-8a3b-3db676665053' and objectid = 'eb409627-bd72-43b7-887c-eb2e97ae40df' and approvalstatus = 'Approved' and activeflag = 1;