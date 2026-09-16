UPDATE Intakeservreqchildremoval
SET activeflag = 0, 
	updatedby = 'CDM-15097',
	updatedon = now() 
WHERE intakeservreqchildremovalid = '62b94cea-334f-4fe5-9f7e-26135576c959';