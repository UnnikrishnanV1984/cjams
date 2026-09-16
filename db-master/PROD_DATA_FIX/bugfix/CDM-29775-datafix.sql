/*
   Issue Description: CDM-29775
   Category/ Module  : Approval inbox
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion: user wants to delete the approval record which is already approved
*/


update routing  set activeflag = 0 , updatedby ='CDM-29775',updatedon = now() 
	where routingid in ('cf44cf3d-e7a6-43e4-9e60-fd458599f18b',
    '5799fa4a-86b4-4c87-aa76-c929fc87d73b',
    '451e929e-a680-4640-a4b6-4bcf9c5558bc',
    '89b978b3-4ea0-4536-ad35-928507fb1526',
    '84e5f648-439b-4506-8654-acd2e2719496', 
    '9be8afcc-dca7-4bc0-a27e-27d8c746de96',
    'a147269a-681a-4a37-95ec-b3d066bcdddc',
    'd2eb20f1-9b54-4c78-b45f-f4099b21c350');