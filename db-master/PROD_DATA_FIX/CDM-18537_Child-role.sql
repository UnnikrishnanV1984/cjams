/*
   Issue Description: CDM-18537  
   Category/ Module  : Child's role in Household
   Root cause: Unknown
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/  

update personrole
set activeflag = 0, updatedon = now(), updatedby ='CDM-18537'
 where personroleid IN ('610a95e3-d88e-4888-b2f3-6c19d32e6d87',
'88bcddf3-d217-4f24-9c6f-650cb45506dc',
'48590f9b-4c43-46df-a66e-40ea52fc415c',
'2e20480a-c1b1-4b49-9bb7-b67ebd8dd072')
and personid = '7bd3e5ee-e0a3-40ec-8804-d582af7668e0';


update personroletype 
set personroleid = '835123a7-2faa-4ffb-af0e-925c1f1a3692', updatedon = now(), updatedby ='CDM-18537'
where personroletypeid IN ('89b7cfdb-767c-4068-ba1e-a67282829920'::uuid);