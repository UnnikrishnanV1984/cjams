/*
  Issue Description:  CDM-43575
   Category/ Module  :  Placement
   Root cause: toroleid value was null in DB leading to fail to fetch the routingstatus from function getplacementbyservicecase 
   Pull request# for code fix: CIDM-9995
   Reason why no related code fix: 
*/

update routing 
set toroleid = 'CWSP',
	updatedby = 'CDM-43575',
	updatedon = now()
where routingid = '703172d3-50d5-46b6-917e-f00edc2678a3' and activeflag = 1