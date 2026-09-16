/*
   Issue Description: CDM-17580
      Category/ Module  :delete approval inbox
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion: delete approval inbox

  */


  
update routing 
set 
	activeflag = 0,
	updatedby = 'CDM-17580',
	updatedon = now()
where routingid in ('165ab875-b491-46dd-8e3b-71386a649d3b',
					'b1ad5350-bf88-4ff7-935c-2039e075610b',
					'd9302979-c330-4f7b-a0c0-5d1070fc2130');