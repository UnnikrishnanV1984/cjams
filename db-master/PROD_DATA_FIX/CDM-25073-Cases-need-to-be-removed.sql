
/*
   Issue Description: CDM-25073
   Category/ Module  : 211030010143 and 221030017333 in my "To Be Assigned" inbox in the "Assign Service Case" section. These cases have been in my inbox for months and do not need to be assigned. 
   They appear to be empty cases. I need these to be removed from my "To Be Assigned" inbox.
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix:  
   
*/



update routing set activeflag = 0, updatedby = 'CDM-25073', updatedon = now() where objectid in 
('be3eedac-9c3b-46eb-a001-0b4efc1062b8','812552c7-26ba-4c0d-a55f-03c1129baad3') and activeflag =1;
