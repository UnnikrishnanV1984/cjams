/*
 * CDM-37336 - Stuck Service Log
 * Customer Email ID:lori.rush@maryland.gov
 * Description - Dashboard:Service log #3021824 for Client ID 200779576 (Isabella Philburn) did not appear on the Finance Funding page 
 * once it was approved. I got 2 ticklers that 2 different people approved at the Director's level (see attached) but it did not 
 * appear on the Finance Funding page. I have also attached the Service log screen that shows that Vicky Kretzer approved it at 
 * the Director's level on the bottom of the screen and it was forwarded to Finance.We need the service log to appear on the 
 * Funding screen in Finance so we can process the payment. 
 * Client ID: 200779576 (Isabella Philburn)
 * Purchase Auth# 3021824
 * 
 */

select activeflag , objectid, routingstatustypeid, eventcode, teamid, updatedon , * 
	from routing
	where routingid = 'b8e9b786-fabd-4870-9bd7-d6b03b138668';

UPDATE cjams.routing
	SET activeflag=1, 
		updatedby = 'CDM-37336', 
		updatedon = now() 
	WHERE routingid='b8e9b786-fabd-4870-9bd7-d6b03b138668';