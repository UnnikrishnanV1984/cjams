-- CDM-22127 - Not Employee at GCDSS
/*
-- Issue Description: 
  Incorrcet user names on Chidl Account Disbursement user notifications 
  
-- Category/ Module: User Notifications (Case Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Requested by Sarah Grove
select securityusersid, subject, "body", updatedby, updatedon
	from usernotification
where usernotificationid = '962c1a98-9eca-4434-b523-86eabd991ae9'
	and activeflag = 1 ;

update usernotification 
set subject = 'Special Needs Trust Disbursement transaction Financial Approval Request for Client Name - "CADEN BROWER" (Client Account "0004795728")  has been assigned by  "Sarah Grove"',
	"body" = 'Special Needs Trust Disbursement transaction Financial Approval Request for Client Name - "CADEN BROWER" (Client Account "0004795728")  has been assigned by  "Sarah Grove"',
	updatedby = 'CDM-22127',
	updatedon = now()	
where usernotificationid = '962c1a98-9eca-4434-b523-86eabd991ae9'
	and activeflag = 1 ;

select fromsecurityusersid, tosecurityusersid, updatedby, updatedon
	from usernotificationmap
where usernotificationid = '962c1a98-9eca-4434-b523-86eabd991ae9'
	and activeflag = 1 ;
	
update usernotificationmap 
set fromsecurityusersid = '2744efa4-8129-48fb-b292-7c4351f66f89', -- Sarah Grove
	updatedby = 'CDM-22127',
	updatedon = now()
where usernotificationid = '962c1a98-9eca-4434-b523-86eabd991ae9'
	and activeflag = 1 ;

	
-- Approved by Amber Kamp
select securityusersid, subject, "body", updatedby, updatedon
	from usernotification
where usernotificationid in ('2fee51eb-d7ce-4c08-a93f-c5e3cd110298', 'f63b6cb0-dfe2-4808-a8c5-72aef90c33d0')
	and activeflag = 1 ;

update usernotification 
set subject = 'Special Needs Trust Disbursement transaction Payment Approval Request for Client Name - "CADEN BROWER" (Client Account "0004795728")  has been approved by  "Amber Kamp"',
	"body" = 'Special Needs Trust Disbursement transaction Payment Approval Request for Client Name - "CADEN BROWER" (Client Account "0004795728")  has been approved by  "Amber Kamp"',
	updatedby = 'CDM-22127',
	updatedon = now()
where usernotificationid in ('2fee51eb-d7ce-4c08-a93f-c5e3cd110298', 'f63b6cb0-dfe2-4808-a8c5-72aef90c33d0')
	and activeflag = 1 ;

-- fromsecurityusersid = 	
select fromsecurityusersid, tosecurityusersid, updatedby, updatedon
	from usernotificationmap
where usernotificationid in ('2fee51eb-d7ce-4c08-a93f-c5e3cd110298', 'f63b6cb0-dfe2-4808-a8c5-72aef90c33d0')
	and activeflag = 1 ;

update usernotificationmap 
set fromsecurityusersid = '37db969b-0878-4897-910c-8ebed1fc75c0',  --Amber Kamp
	updatedby = 'CDM-22127',
	updatedon = now()
where usernotificationid in ('2fee51eb-d7ce-4c08-a93f-c5e3cd110298', 'f63b6cb0-dfe2-4808-a8c5-72aef90c33d0')
	and activeflag = 1 ;

