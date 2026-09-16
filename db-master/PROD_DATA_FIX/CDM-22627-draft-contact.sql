/*
   Issue Description: CDM-22627
   Category/ Module  : contact notes
   Root cause: user wants to change the draft in contact note
   Pull request# for code fix: 6547
  explanantion: user wants change the draft in contact note
  */

  update progressnote  
  set savemode  = true , 
  updatedby  ='CDM-22627',
  updatedon  = now()
  where contactdate  = '2022-02-10 00:00:00.000' and witsid ='9763161';
