
--CDM-10956-Removal Type Change

update intakeservreqchildremoval set removaltypekey = 'SHB',  updatedby = 'CDM-10956', updatedon = now() 
	where intakeservreqchildremovalid = 'e3ab830a-2259-4df0-b9ea-9ca4c1aeb71a' and intakeservicerequestactorid = 'e84ded39-9a3e-4177-bef7-1236e03752ac';