
/*
   Issue Description: CDM-21351
   Category/ Module  : Gap Rate Approval Issue fix
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- d03ab753-b5bf-43d4-958b-def531c005d6	381f1793-744c-4c4f-a409-809a260dcc45	eca6f2d2-e3c6-474c-8c4a-d4ee53381883
update routing set fromsecurityusersid = 'f821da39-5af0-41d8-ad72-6ced253583ca',teamid = 'b50f2419-42ba-4ab6-84ab-5172917d2d77', tosecurityusersid = '3ca8e63d-f885-445b-aab9-24456e91ad4a', updatedby = 'CDM-21351', updatedon = now() 
where routingid = 'c38158a2-f4f8-481d-9ae1-81c561a182cd';