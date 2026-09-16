/*
Root cause: The review request is not available under the default supervisor
Fix provided:  Datafix done to show under supervisor case pending approval.
Data/Code fix ticket#: CDM-43885
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: N/A
*/

update routing
set tosecurityusersid ='b89bcad8-25d0-471a-bd84-47f42d81164e' ,
	updatedon = now(), 
	updatedby = 'CDM-43885'
where objectid = '29367ab8-6026-4340-8dfc-b00c4aa5427f'
	and eventcode = 'GARR'
	and activeflag = 1 ;