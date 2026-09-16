/*
   Issue Description: CJAMS-64228
   Category/ Module  : Prod data fix to update service plan approval data 
   Root cause:  
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/





-- 2025-12-22 02:05:04.041
update snapshothist set approvaldate = '2025-12-21 20:53:32.000', updatedby = 'CJAMS-64228', updatedon = now()
where objectid = '3a3e2bb6-1661-4745-9958-4167f481d022' and activeflag  = 1 ;
