-- CDM-44016 - CJAMS pymt id # 4650397 did not interface into D365
/*
-- Issue Description: 
   CJAMS pymt id # 4650397 did not interface into D365
   
-- Payment Date: 01/17/2025
-- Payment IDs: 4650362, 4650363, 4650364 and 4650397

--	There is an issue in vendor address, the city name lenght 37 is an issue.
--	The allowed characters for this field is 30.
--	Current Value: Baltimore City Dept of Social Service
   
-- Category/ Module: D365 Interface (Finance Management) 
-- Root cause: 
	CJAMS – D365 payment interface batch has failed on 01/17/2025 due to one vendor's invalid tax id number 
	data issue. Partial transaction issue, the payment status was updated in CJAMS as Interfaced 
	but no file was generated to interface with D365 system. 
-- Fix Provided: 
	Data fix has been promoted to update the payment status back to Approved, 
	so the next CJAMS – D365 payment interface batch run will send these payments to the D365 system. 
-- Regression Impacts: N/A for CW side
-- Is Code fix Required?: Yes
    Code fix ticket#: (If Yes) CJAMS Provider Module ticket 
    Reason why no related code fix: The code fix has been done from the CJAMS provider module side to prevent saving of the invalid tax id numbers in DB.
*/

/*
LDSS 			Payment ID	Payment Date	Provider Name					Amount	Case ID			Client ID
-----------------------------------------------------------------------------------------------------------------
Anne Arundel	4650362		2025-01-17		Anne Arundel Co. DSS - Admin	831.78	3296524			4331697
Anne Arundel	4650363		2025-01-17		Anne Arundel Co. DSS - Admin	36.80	3170044			203941758
Anne Arundel	4650364		2025-01-17		Lakeside Neurologic				130.00	3275681			4077150
Prince George's	4650397		2025-01-17		Lead4Life, Inc.					644.23	231030140676	3765680
*/

-- Payment Status updated as Approved in CJAMS for D365 Interface batch to process these payments again.
update tb_payment_status 
set payment_status_cd = '1634', -- Approved
	update_ts = now(),
	update_user_id = 'CDM-44016'
where payment_id in ( 4650362, 4650363, 4650364, 4650397 )
	and delete_sw  = 'N' ;
