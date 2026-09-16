/*
   Issue Description: CDM-17431
      Category/ Module  : Duplicate removal
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion: user wants to reopen  AR case

  */

  UPDATE personprogramarea 
	SET updatedby = 'CDM-17431', 
		updatedon = now(), 
		activeflag = 0
	WHERE personprogramid = 'd580fadb-7637-4779-a337-514d1c260c4b' AND activeflag=1;