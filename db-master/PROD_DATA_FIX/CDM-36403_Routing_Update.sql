/*
 * CDM-36403 - Unable to approve this for payment request
 * Customer Email ID:olufemi.opaleke@maryland.gov
 * Description - The authorization number 2909673 was approved by Merrick Smith at the funding level but never interface to the payment 
 * screen for final payment approval but instead was found under the funding approved screen in which i was unable to do the 
 * final payment. Under the funding Approved screen i we can only print out the authorization number but cant do the approval
 * authorization ID# : 2909673 
 * 
 */


UPDATE cjams.routing
	SET activeflag = 0,
		tosecurityusersid = 'f090b9ec-231c-4a5b-b1b4-8a446ade05d2',
		updatedby = 'CDM-36403',
		updatedon = now()
	WHERE routingid = 'c4c90729-771b-4ce3-9d85-46497eb94f75';


DELETE from routing where insertedby = 'CDM-36403';
INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, 
	insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
	remarks, routeddescription, servicerequestnumber, objecttypekey)
VALUES('PCAUTHR', 'f090b9ec-231c-4a5b-b1b4-8a446ade05d2', NULL, '31eabbb0-f686-41dc-94d3-a3c26b12043a'::uuid, 'FNSFS', 'FNSFS', '2909673', 41, 1, 
	'CDM-36403', now(), 'CDM-36403', now(), true, 
	'Forwarded to Payment Approval', 'Purchase Authorization Forwarded to Payment Approval', NULL, 'ServiceCase');
