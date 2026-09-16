/*
   Issue Description: 3293542:The service log with the authorization number #1778614 needs to be closed as soon as possible. I have contacted the person the request was sent to as well as finance but have not been able to close this service log. 
   Category/ Module  :  Service log
   Root Cause: User Request, User requested  to re-route the Purchase Auth# 1778614 to Finance user "Naomi Gaskins".
    Fix provided: datafix done to re-route the Purchase Auth# 1778614 to Finance user "Naomi Gaskins".
    Regression Impacts: service log
    Is Code fix Required?: No
    Code fix ticket#: NA
    Reason why no related code fix: need datafix to re-route the PA request.
*/

update routing
set tosecurityusersid = '3d708382-5afa-44bd-9941-1511cf0123f4',--df4e91fc-5824-45b0-baae-788cacf3bc79
	updatedby = 'CJAMS-62701',
	updatedon = now()
where routingid = '306e89cc-aba3-4a91-ba70-f8ba6e225aa2' 
	and activeflag = 1;