update cjams.usernotification 
set insertedby ='37db969b-0878-4897-910c-8ebed1fc75c0', updatedby ='CDM-12059'
where usernotificationid ='315ae533-62f7-44f7-9158-9847ff2a9d23';

update cjams.usernotificationmap 
set insertedby ='37db969b-0878-4897-910c-8ebed1fc75c0', 
	fromsecurityusersid ='37db969b-0878-4897-910c-8ebed1fc75c0',
	updatedby ='CDM-12059',
	updatedon =now()
where usernotificationid ='315ae533-62f7-44f7-9158-9847ff2a9d23';

update cjams.usernotification 
set insertedby ='e5f2d788-5de8-4fa0-86f6-564ab972a7a5', updatedby ='CDM-12059'
where usernotificationid ='2ea77da8-6f9b-4acf-9726-36e0731ff895';

update cjams.usernotificationmap 
set insertedby ='e5f2d788-5de8-4fa0-86f6-564ab972a7a5', 
	fromsecurityusersid ='e5f2d788-5de8-4fa0-86f6-564ab972a7a5',
	updatedby ='CDM-12059',
	updatedon =now()
where usernotificationid ='2ea77da8-6f9b-4acf-9726-36e0731ff895';

UPDATE cjams.usernotification
SET subject='Special Needs Trust Disbursement transaction Payment Approval Request for Client Name - "ALYONA OPEL" (Client Account "00000000000004795728")  has been approved by "Amber Kamp"', "body"='Special Needs Trust Disbursement transaction Payment Approval Request for Client Name - "ALYONA OPEL" (Client Account "00000000000004795728")  has been approved by  "Amber Kamp"'
WHERE usernotificationid='315ae533-62f7-44f7-9158-9847ff2a9d23'::uuid;
UPDATE cjams.usernotification
SET subject='Special Needs Trust Disbursement transaction Financial Approval Request for Client Name - "ALYONA OPEL" (Client Account "00000000000004795728")  has been assigned by "Barbara Kutchman"', "body"='Special Needs Trust Disbursement transaction Financial Approval Request for Client Name - "ALYONA OPEL" (Client Account "00000000000004795728")  has been assigned by  "Barbara Kutchman"'
WHERE usernotificationid='2ea77da8-6f9b-4acf-9726-36e0731ff895'::uuid;
