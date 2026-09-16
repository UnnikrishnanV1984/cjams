/*
   Issue Description: CDM-32452
   Category/ Module  : 
   Root cause: user want update county and case worker name 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update routing set fromsecurityusersid='335105c6-a48f-4f50-a0b6-91f673201c16',
tosecurityusersid='6e915a2a-98f9-4d63-9880-9aeff8d2179d',teamid='1e6bf2a6-2e10-4af5-8e31-93413a6243f9',
updatedby='CDM-32452',updatedon=now()
where routingid='8456e90c-b322-42f0-a46f-cd0c0494e450';