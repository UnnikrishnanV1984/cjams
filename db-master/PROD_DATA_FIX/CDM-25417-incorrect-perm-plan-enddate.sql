/*
   Issue Description: CDM-25417
   Category/ Module  : permanency plan
   Root cause: user wants to change the enddate of permanencyplan
   Pull request# for code fix: 6541
  explanantion: user wants to remove
  */

  update permanencyplan 
  set enddate = null,
  updatedby = 'CDM-25417', 
  updatedon = now()  
  where permanencyplanid = '52f136da-9099-4964-9a0e-6276f010b2f8';