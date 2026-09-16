/*
Issue:Duplicate CPS-IR case 251023133139 was created with the same CJAMSPID 204226017 that already exists in the valid CPS-IR case 251023133191.
Root Cause:The referral was accidentally duplicated during intake creation, causing the same person (CJAMSPID 204226017) to appear in two CPS-IR cases.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table  routing table..
Data/Code fix ticket#: CJAMS-62553
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

--select  activeflag, * from intakedastaging  where intakenumber ='I251013365851';
update intakedastaging
set jsondata = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsonb_set(
					jsonb_set(
						jsonb_set(
							jsonb_set(
								jsonb_set(jsondata ,'{DAType,DATypeDetail,0,DADisposition}','"ScreenOUT"',false ),
							'{DAType,DATypeDetail,0,supComments}','"duplicate to case #251023133191"',false ),
					'{DAType,DATypeDetail,0,supDisposition}','"ScreenOUT"',false),
					'{DAType,DATypeDetail,0,dispositioncode}','"ScreenOUT"',false),
				'{disposition,0,DADisposition}','"ScreenOUT"',false),
			'{disposition,0,supDisposition}','"ScreenOUT"',false),
		'{intakeDATypeDetails,0,DADisposition}','"ScreenOUT"',false),
	'{intakeDATypeDetails,0,supDisposition}','"ScreenOUT"',false),
	updatedby = 'CJAMS-62553', updatedon = now()
where intakenumber = 'I251013365851' and activeflag = 1;

--select  activeflag, * from intakesnapshot  where intakenumber ='I251013365851';
update intakesnapshot
set jsondata = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsonb_set(
					jsonb_set(
						jsonb_set(
							jsonb_set(
								jsonb_set(jsondata ,'{DAType,DATypeDetail,0,DADisposition}','"ScreenOUT"',false ),
							'{DAType,DATypeDetail,0,supComments}','"duplicate to case #251023133191"',false ),
					'{DAType,DATypeDetail,0,supDisposition}','"ScreenOUT"',false),
					'{DAType,DATypeDetail,0,dispositioncode}','"ScreenOUT"',false),
				'{disposition,0,DADisposition}','"ScreenOUT"',false),
			'{disposition,0,supDisposition}','"ScreenOUT"',false),
		'{intakeDATypeDetails,0,DADisposition}','"ScreenOUT"',false),
	'{intakeDATypeDetails,0,supDisposition}','"ScreenOUT"',false),
	updatedby = 'CJAMS-62553', updatedon = now()
where intakenumber = 'I251013365851' and activeflag = 1;


--select * from routing where objectid ='I251013365851';
update routing
set supervisordecision ='Screenout',updatedby = 'CJAMS-62553', updatedon = now()
where routingid ='f0074950-bace-4e29-81de-ba23228f139a' and activeflag =1;

--select * from person where cjamspid ='204226017';--3e26a5d8-a0ef-4cb4-bb24-b5bf249994a9
--select * from actor where intakeserviceid ='c7e6aa6b-e242-4b14-a9d3-c5a3619638f7' and personid ='3e26a5d8-a0ef-4cb4-bb24-b5bf249994a9';
update actor
set activeflag =0,updatedby = 'CJAMS-62553', updatedon = now()
where actorid ='96fe42ca-38e6-46c1-a181-820a73b9654c' and activeflag =1;

--select *from intakeservicerequestactor where intakeserviceid ='c7e6aa6b-e242-4b14-a9d3-c5a3619638f7' and personid ='3e26a5d8-a0ef-4cb4-bb24-b5bf249994a9';
update intakeservicerequestactor
set activeflag =0,updatedby = 'CJAMS-62553', updatedon = now()
where intakeservicerequestactorid in ('20cacdee-e4fd-42f3-80e0-614d9582664c','48b4c602-3699-45fb-9482-62284731cb08') and activeflag =1;

--select * from personprogramarea where objectid ='c7e6aa6b-e242-4b14-a9d3-c5a3619638f7' and personid ='3e26a5d8-a0ef-4cb4-bb24-b5bf249994a9';
update personprogramarea
set activeflag =0,updatedby = 'CJAMS-62553', updatedon = now()
where personprogramid ='64d5ebb4-8442-4aa2-8414-e0a02ba94068' and activeflag =1;

--select * from personrole where intakeserviceid ='c7e6aa6b-e242-4b14-a9d3-c5a3619638f7' and personid ='3e26a5d8-a0ef-4cb4-bb24-b5bf249994a9';
update personrole
set activeflag =0,updatedby = 'CJAMS-62553', updatedon = now()
where personroleid ='d7bbbacc-1c39-488d-8d04-0b6170eda158' and activeflag =1;

--select * from personroletype where personroleid ='d7bbbacc-1c39-488d-8d04-0b6170eda158';
update personroletype
set activeflag =0,updatedby = 'CJAMS-62553', updatedon = now()
where personroletypeid in ('d0867700-8ffb-4f23-b5ec-b9c39039e20e','82e70472-2e74-491a-90a5-a44dd739e49f') and activeflag =1;

update intakeservicerequest
set activeflag = 0, updatedby = 'CJAMS-62553', updatedon = now()
where intakenumber = 'I251013365851' and activeflag = 1;

