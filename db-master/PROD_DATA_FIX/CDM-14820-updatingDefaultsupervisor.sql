-- 5611b96f-733e-47a7-878b-f40b92d39f7c, 2021-03-10 11:39:25, ADMIN
update cjams.userprofile  
set supervisorid = '527e483b-5108-4906-b2bb-6fdbc317f03e', 
	updatedon = now(), 
	updatedby = 'CDM-14820'
where securityusersid = '7c58470b-e4b5-466e-80a9-99856fd9ca35'
	 and activeflag  = 1 ;