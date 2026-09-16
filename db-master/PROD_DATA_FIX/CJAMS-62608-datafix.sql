/*
   Issue Description: CJAMS-62608
   Category/ Module  :  Service Log
   Root cause: User requested to Purchase Auth# 754575 needs to be re-routed to "Wanda Nolt" Directors approval Dashboard
   Fix provided:  Data fix has been promoted 
   Pull request# for code fix: 
   Reason why no related code fix: 
   user error - requested a data fix
*/

update routing
set tosecurityusersid = 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', 
	updatedby = 'CJAMS-62608', 
	updatedon = now()
where routingid = '2d23461a-cd63-4ee4-a3ef-fce802f5f927'
	and objectid = '754575'
	and activeflag = 1 ; 
    
--744698
update routing
set tosecurityusersid = 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', 
	updatedby = 'CJAMS-62608', 
	updatedon = now()
where routingid = 'f107763a-d71a-4442-af35-8b366fab8948'
	and objectid = '744698'
	and activeflag = 1 ; 
