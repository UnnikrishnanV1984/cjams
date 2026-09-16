/*
Issue: CJAMS-64530 Service Log no end date
Category/Module: Purchase Authorization
Root cause:  Purchase Authorizations (3738553 & 3738555) need to be re-routed to the Program Manger (Deborah Ramelmeier) as requested by the user. 
Fix provided:  Data fix has been done to re-route the purchase authorization request to Deborah Ramelmeier
Data/Code fix ticket#: CJAMS-64530
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User requested to re-route the request as it has already been submitted and we need a data fix for this issue.
*/


--Re-routing the purchase authorization request 3738553 from NetriciaBarnett to DeborahRamelmeier

update routing
set tosecurityusersid = 'da3796ef-d2d4-421b-8e95-a4f68e8fc4ef',
    updatedon = now(),
    updatedby = 'CJAMS-64530'
where objectid = '3738553'
and routingid = '6345e347-8f87-41e8-85e0-61fa1ad351fb'
and tosecurityusersid = '43d77ebc-8755-4693-9eff-b8a6096d0233'
and activeflag =1;

--Re-routing the purchase authorization request 3738553 from NetriciaBarnett to DeborahRamelmeier

update routing
set tosecurityusersid = 'da3796ef-d2d4-421b-8e95-a4f68e8fc4ef',
    updatedon = now(),
    updatedby = 'CJAMS-64530'
where objectid = '3738555'
and routingid = '93473e5d-1bb6-425f-92a5-6e54f2ee683a'
and tosecurityusersid = '43d77ebc-8755-4693-9eff-b8a6096d0233'
and activeflag =1;