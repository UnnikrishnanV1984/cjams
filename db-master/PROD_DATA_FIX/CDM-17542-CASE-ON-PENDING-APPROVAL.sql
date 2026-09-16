/*
   Issue Description: CDM-17542
      Category/ Module  :case approval
   Pull request# for code fix: 
  explanantion: case on pending approval

  */


  update routing 
set 
	activeflag = 0,
	updatedby = 'CDM-17542',
	updatedon = now()
where routingid = '139f1be6-39f5-4eb5-aaa0-7d4db7a73615';