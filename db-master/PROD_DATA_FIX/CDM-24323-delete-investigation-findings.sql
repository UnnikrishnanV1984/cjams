/*
   Issue Description: CDM-24323
   Category/ Module  : Investigation finding
   Root cause: User requested to remove the wrong investigation findings
   Pull request# for code fix: 7473
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   need to do data fix
*/
update Investigationmaltreatment 
SET activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-24323' 
where maltreatmentid in ('de98955a-1964-45e7-9ec2-deb9f40df5c3', '5bcb047d-cbae-4a65-b5b7-1aa85fc8a16b');