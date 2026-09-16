/*
   Issue Description: CDM-27147
   Category/ Module  : Dashboard
   Root cause: user wants remove the pending approval in inbox
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    
*/

update routing 
	set  updatedby = 'CIDM-27147',updatedon = now(), activeflag = 0
	where  routingid  in ('3e4705a9-7793-4093-b21f-6f0d7e29e74b','314dd1ea-058e-4d4d-8373-dedf9d3312b2','beeae04a-4f74-4770-a5e7-2db73d929af7','2623c5d8-5f96-4731-9a1b-4c711fbb166b');