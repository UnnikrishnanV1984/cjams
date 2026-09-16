/*
   Issue Description: CDM-18351
			This case has been closed but still appears on the workers tree
      Category/ Module  : case closure, decision
   Root cause: closed case status shows open in ribbon
   Pull request# for code fix: 
  explanantion: closed case status servicerequestnumber = '202101250107196'

  */
  
	
	update cjams.intakeservicerequest
	set intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a',
	updatedby = 'CDM-18351',
	updatedon = now()
	where servicerequestnumber = '202101250107196';