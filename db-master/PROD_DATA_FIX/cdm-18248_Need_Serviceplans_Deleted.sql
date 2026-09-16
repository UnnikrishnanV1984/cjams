/*
   Issue Description: CDM-18248
   Category/ Module  :  case approval
   Root cause: user wants to Delete
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

update serviceplan s 
        set s.activeflag = 0,updatedon = now(), updatedby = 'CDM-18248'
        where s.serviceplanid in ('084ff28b-0b40-47eb-b3ef-841e0f1a9f0e','add9975d-b4ba-43b5-9927-188914ef6043');