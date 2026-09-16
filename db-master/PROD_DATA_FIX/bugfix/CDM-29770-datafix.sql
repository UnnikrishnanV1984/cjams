
/*
   Issue Description: CDM-29770
   Category/ Module  : Approval inbox
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion: user wants to delete the approval record which is already approved
*/


  update routing  set activeflag = 0 , updatedby ='CDM-29770',updatedon = now() 
	where routingid in ('bfc29867-77c5-4196-be14-ccac5faf1b68', 
    '4ac5fe4d-2a45-481d-832f-ebd2c58b02e3',
    '780b36ee-cfbb-4ac3-850c-83252245c49c',
    '6414e815-bd04-4061-820a-ae898eab6109',
    '0ea575f2-17bc-4b12-ac33-1a6b205950c0',
    'a6d3c216-ccee-4251-a935-5091cf530128',
    '6cd849c5-f4b5-47f0-821c-bb40a006b5e0',
    '353d0f61-d334-409f-a3d7-587f34851500',
    '1028d0b9-5651-42f9-89ed-416d37b24c1b',
    'd14eabb6-3f8e-447f-a81c-59a78a5af6bf',
    'a1180e99-b928-49d8-8de3-d234ee0fad73');