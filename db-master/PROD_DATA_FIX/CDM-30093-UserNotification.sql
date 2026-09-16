/*
 Issue Description: CDM-30093
 Category/ Module: user notification
 Root cause: User name was not coming correctly 
 Pull request: 8557
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: data fix
 */
update cjams.usernotification 
set insertedby ='74542e14-b26d-4824-ac24-dae0b75fc8e0', updatedby ='CDM-30093'
where usernotificationid ='e5642016-4153-4130-80c3-d3a312425bb8';

update cjams.usernotificationmap 
set insertedby ='74542e14-b26d-4824-ac24-dae0b75fc8e0', 
	fromsecurityusersid ='991e43ab-c06b-4195-b446-c4f80ef8433a',
	updatedby ='CDM-30093',
	updatedon =now()
where usernotificationid ='e5642016-4153-4130-80c3-d3a312425bb8';

UPDATE cjams.usernotification
SET subject='Case Special Needs Trust Disbursement transaction Payment Approval Request for Client Name - "DREZDEN MOORE" (Client Account "0004795728") has been approved by Kelsie Hardesty' 
WHERE usernotificationid='e5642016-4153-4130-80c3-d3a312425bb8'::uuid;