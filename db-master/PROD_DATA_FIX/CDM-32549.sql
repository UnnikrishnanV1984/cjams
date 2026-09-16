/*
   Issue Description: CDM-32549
   Category/ Module  : 
   Root cause: user want update county and case worker name 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 
update routing set fromsecurityusersid='6f181006-23d7-4915-8f4e-6ccc1678479d',teamid='3bd59c7f-1970-4b98-8a34-e4c162ddf3c4',
tosecurityusersid='cf1efb9e-4629-4858-b57d-282bca838560',updatedby='CDM-32549',updatedon=now()
where routingid='19f7c8bd-15d3-427d-81b4-52ea0ea8912a';