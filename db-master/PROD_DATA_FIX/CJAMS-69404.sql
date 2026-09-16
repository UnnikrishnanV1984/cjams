/*
  Issue Description: CJAMS-69404- Data fix needed to update the overdue reason
  Root cause: User requested to update overdue reasons as incorrect dropdown values are selected
  Fix provided : Data fix has been done to update the overdue reason as follows
                  Alleged victim Unavailable > Attempted Face to Face > 5 or more Attempts
  Regression Impacts: N/A
  Is Code fix needed: No
  Reason why no related code fix: It's a user input error and data fix should resolve it. 
*/



UPDATE cjams.cpsresponsetimeractions
	SET cpsresponsetimerreason1 = 'VAVU',	-- Alleged victim Unavailable
		cpsresponsetimerreason2 = 'VAFF',	-- Attempted Face to Face
		cpsresponsetimerreason3 = 'V5MF',	-- 5 or more Attempts
		updatedby ='CJAMS-69404',
		updatedon = now()
WHERE cpsresponsetimeractionsid = 'c87ad444-9649-4afd-a182-af4652d61e69'
	AND intakeserviceid = 'a19d1d22-8696-4e6f-a619-45b4c8ea6fce'
	AND activeflag = 1 ;