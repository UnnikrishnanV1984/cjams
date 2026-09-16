/*
  Issue Description: CDM-13971 Wrong Assignment Name
   Category/ Module  :  wrong name on notificatoin
   Root cause: code fix already made.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/
update
	usernotification set
		securityusersid = '37db969b-0878-4897-910c-8ebed1fc75c0'
		,subject = 'Special Needs Trust Disbursement transaction Payment Approval Request for Client Name - "ALYONA OPEL" (Client Account "0004795728")  has been assigned by  "Janie Leydig"'
		,"body" = 'Special Needs Trust Disbursement transaction Payment Approval Request for Client Name - "ALYONA OPEL" (Client Account "0004795728")  has been assigned by  "Janie Leydig"'
		,updatedby = 'CDM-13971'
		,updatedon = now()
	where
		usernotificationid = '42e642a1-fa95-4bbd-bb90-40d89a3e372d';
update usernotificationmap 
set fromsecurityusersid = 'e68284b1-b8c5-4091-94e3-2894b0ebafbc'
		,updatedby = 'CDM-13971',
		updatedon = now()
	where
		usernotificationid = '42e642a1-fa95-4bbd-bb90-40d89a3e372d';

update
	usernotification set
		subject = 'Special Needs Trust Disbursement transaction Payment Approval Request for Client Name - "ALYONA OPEL" (Client Account "00000000000004795728")  has been assigned by  "Barbara Kutchman"'
		,"body" = 'Special Needs Trust Disbursement transaction Payment Approval Request for Client Name - "ALYONA OPEL" (Client Account "00000000000004795728")  has been assigned by  "Barbara Kutchman"'
		,updatedby = 'CDM-13971'
		,updatedon = now()
	where
		usernotificationid = '3b76aa52-9b11-40cd-a116-9e7b103bf31b';
update usernotificationmap 
set fromsecurityusersid = 'e5f2d788-5de8-4fa0-86f6-564ab972a7a5'
		,updatedby = 'CDM-13971',
		updatedon = now()
	where
		usernotificationid = '3b76aa52-9b11-40cd-a116-9e7b103bf31b';
		
