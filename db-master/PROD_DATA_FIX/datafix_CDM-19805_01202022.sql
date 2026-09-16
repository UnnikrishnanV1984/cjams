-- CDM-19805 - CHILD ACCOUNT ISSUE
/*
-- Issue Description: 
   Child account disbursement the request is not going to the supervisor for approval.

-- Client ID: 3137175 (ASIA	MOAHE PRATHER) - 7d247a2b-7d93-4d4e-8ad0-ee973e9419b7
-- Foster Care Youth Saving Account ID: 1015903 (#F606061)
   
-- Category/ Module: Child Accounts (Finance Management) 
-- Root cause: Routingconfig set up issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to add new Routing Config values for Event: Final Disbursement transaction (FINALDIS)
-- CWCW FNSFS
INSERT INTO cjams.routingconfig
	(	routingconfigid, eventcode, targetrolekey, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		effectivedate, expirationdate, targetteamtypekey, sourcerolekey, 
		old_id, routingstatustypekey, principaltype, resourceid
	)
VALUES
	(	gen_random_uuid(), 'FINALDIS', 'FNSFS', 1, 
		'CDM-19805', now(), 'CDM-19805', now(), 
		now(), NULL, NULL, 'CWCW', 
		NULL, NULL, NULL, NULL
	);

-- CWSP FNSFS
INSERT INTO cjams.routingconfig
	(	routingconfigid, eventcode, targetrolekey, activeflag, 
		insertedby, insertedon, updatedby, updatedon, 
		effectivedate, expirationdate, targetteamtypekey, sourcerolekey, 
		old_id, routingstatustypekey, principaltype, resourceid
	)
VALUES
	(	gen_random_uuid(), 'FINALDIS', 'FNSFS', 1, 
		'CDM-19805', now(), 'CDM-19805', now(), 
		now(), NULL, NULL, 'CWSP', 
		NULL, NULL, NULL, NULL
	);
