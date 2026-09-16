/*
   Issue Description: CDM-19806
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix:4664
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update routing 
	set updatedby = 'CDM-19806', updatedon = now(), activeflag = 0
	where  routingid in ('606cb7bd-5981-4c13-a9a5-41940f7db8b3', '376d606c-3e0d-4e5d-815c-d3b06a91306d');