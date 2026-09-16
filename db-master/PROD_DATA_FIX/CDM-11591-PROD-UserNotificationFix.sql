update cjams.usernotification 
set insertedby ='37db969b-0878-4897-910c-8ebed1fc75c0', updatedby ='CDM-11591'
where usernotificationid in ('fbed713d-2ece-4ca1-af13-117b24d44f22',
'edce20a7-820a-4e0d-982f-b52289d599f1',
'217e15f5-a24e-4259-899a-c6dd19752441');

update cjams.usernotificationmap 
set insertedby ='37db969b-0878-4897-910c-8ebed1fc75c0', 
	fromsecurityusersid ='37db969b-0878-4897-910c-8ebed1fc75c0',
	updatedby ='CDM-11591',
	updatedon =now()
where usernotificationid in ('fbed713d-2ece-4ca1-af13-117b24d44f22',
'edce20a7-820a-4e0d-982f-b52289d599f1',
'217e15f5-a24e-4259-899a-c6dd19752441');

update cjams.usernotification 
set insertedby ='e5f2d788-5de8-4fa0-86f6-564ab972a7a5', updatedby ='CDM-11591'
where usernotificationid in ('f5389cfd-f474-42a6-a8f5-10f7071a5457',
'c1d9ea7e-ca0c-428b-8bbe-82ecab3a29f4');

update cjams.usernotificationmap 
set insertedby ='e5f2d788-5de8-4fa0-86f6-564ab972a7a5', 
	fromsecurityusersid ='e5f2d788-5de8-4fa0-86f6-564ab972a7a5',
	updatedby ='CDM-11591',
	updatedon =now()
where usernotificationid in ('f5389cfd-f474-42a6-a8f5-10f7071a5457',
'c1d9ea7e-ca0c-428b-8bbe-82ecab3a29f4');

UPDATE cjams.usernotification
SET subject='Final Disbursement transaction Financial Approval Request for Client Name - "CHANDLER WOLFE" (Client Account "0004795728")  has been assigned by  "Barbara Kutchman"', "body"='Final Disbursement transaction Financial Approval Request for Client Name - "CHANDLER WOLFE" (Client Account "0004795728")  has been assigned by  "Barbara Kutchman"'
WHERE usernotificationid='c1d9ea7e-ca0c-428b-8bbe-82ecab3a29f4'::uuid;
UPDATE cjams.usernotification
SET subject='Final Disbursement transaction Financial Approval Request for Client Name - "TALLON RINGER" (Client Account "0004795728")  has been assigned by  "Barbara Kutchman"', "body"='Final Disbursement transaction Financial Approval Request for Client Name - "TALLON RINGER" (Client Account "0004795728")  has been assigned by  "Barbara Kutchman"'
WHERE usernotificationid='f5389cfd-f474-42a6-a8f5-10f7071a5457'::uuid;
UPDATE cjams.usernotification
SET subject='Final Disbursement transaction Payment Approval Request for Client Name - "CHANDLER WOLFE" (Client Account "0004795728")  has been approved by  "Amber Kamp"', "body"='Final Disbursement transaction Payment Approval Request for Client Name - "CHANDLER WOLFE" (Client Account "0004795728")  has been approved by  "Amber Kamp"' 
WHERE usernotificationid='217e15f5-a24e-4259-899a-c6dd19752441'::uuid;
UPDATE cjams.usernotification
SET subject='Final Disbursement transaction Payment Approval Request for Client Name - "TALLON RINGER" (Client Account "0004795728")  has been approved by  "Amber Kamp"', "body"='Final Disbursement transaction Payment Approval Request for Client Name - "TALLON RINGER" (Client Account "0004795728")  has been approved by  "Amber Kamp"'
WHERE usernotificationid='edce20a7-820a-4e0d-982f-b52289d599f1'::uuid;
UPDATE cjams.usernotification
SET subject='Special Needs Trust Disbursement transaction Payment Approval Request for Client Name - "ALYONA OPEL" (Client Account "0004795728")  has been approved by  "Amber Kamp"', "body"='Special Needs Trust Disbursement transaction Payment Approval Request for Client Name - "ALYONA OPEL" (Client Account "0004795728")  has been approved by  "Amber Kamp"'
WHERE usernotificationid='fbed713d-2ece-4ca1-af13-117b24d44f22'::uuid;