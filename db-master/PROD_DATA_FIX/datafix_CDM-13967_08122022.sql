-- CDM-13967 - Incorrect Employee
/*
-- Issue Description: 
  Incorrcet user names on Child Account Disbursement user notifications 
  
-- Category/ Module: User Notifications (Case Management) 
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Requested by Barbara Kutchman (e5f2d788-5de8-4fa0-86f6-564ab972a7a5)

-- 1)
select securityusersid, subject, "body", updatedby, updatedon
	from usernotification
where usernotificationid = '12df5a4e-19aa-4db4-aced-24c94fdb0eae'
	and activeflag = 1 ;

update usernotification 
set subject = 'Special Needs Trust Disbursement transaction Financial Approval Request for Client Name - "ALYONA OPEL" (Client Account "00000000000004795728")  has been assigned by  "Barbara Kutchman"',
	"body" = 'Special Needs Trust Disbursement transaction Financial Approval Request for Client Name - "ALYONA OPEL" (Client Account "00000000000004795728")  has been assigned by  "Barbara Kutchman"',
	updatedby = 'CDM-22127',
	updatedon = now()	
where usernotificationid = '12df5a4e-19aa-4db4-aced-24c94fdb0eae'
	and activeflag = 1 ;

select fromsecurityusersid, tosecurityusersid, updatedby, updatedon
	from usernotificationmap
where usernotificationid = '12df5a4e-19aa-4db4-aced-24c94fdb0eae'
	and activeflag = 1 ;
	
update usernotificationmap 
set fromsecurityusersid = 'e5f2d788-5de8-4fa0-86f6-564ab972a7a5', -- Barbara Kutchman 
	updatedby = 'CDM-13967',
	updatedon = now()
where usernotificationid = '12df5a4e-19aa-4db4-aced-24c94fdb0eae'
	and activeflag = 1 ;


-- 2) 
select securityusersid, subject, "body", updatedby, updatedon
	from usernotification
where usernotificationid = '5175146b-4f6f-4c32-894c-a028fd65d61d'
	and activeflag = 1 ;

update usernotification 
set subject = 'Special Needs Trust Disbursement transaction Financial Approval Request for Client Name - "ALYONA OPEL" (Client Account "0004795728")  has been assigned by  "Barbara Kutchman"',
	"body" = 'Special Needs Trust Disbursement transaction Financial Approval Request for Client Name - "ALYONA OPEL" (Client Account "0004795728")  has been assigned by  "Barbara Kutchman"',
	updatedby = 'CDM-22127',
	updatedon = now()	
where usernotificationid = '5175146b-4f6f-4c32-894c-a028fd65d61d'
	and activeflag = 1 ;

select fromsecurityusersid, tosecurityusersid, updatedby, updatedon
	from usernotificationmap
where usernotificationid = '5175146b-4f6f-4c32-894c-a028fd65d61d'
	and activeflag = 1 ;
	
update usernotificationmap 
set fromsecurityusersid = 'e5f2d788-5de8-4fa0-86f6-564ab972a7a5', -- Barbara Kutchman 
	updatedby = 'CDM-13967',
	updatedon = now()
where usernotificationid = '5175146b-4f6f-4c32-894c-a028fd65d61d'
	and activeflag = 1 ;
