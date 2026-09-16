/*
   Issue Description:A FM145R report (underpayment report) showed up in CJAMs and D365 for Harford County to pay but 
   our worker Rhonda Gardner said this is a Cecil County case. 
   The worker on the underpayment report is Latresha Cruz, who is not a Harford County worker.
   Is this worker's workplace location incorrect in CJAMs.
   Category/ Module  : Payment
   Root cause:The case was assigned to Cecil from Harford county. The report shows the payment county and not the case worker county. 
   The payment county is Harford County and the case worker county is Cecil County.  
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update tb_payment_detail
set county_cd = '1434',--1439  Harford
	update_ts = now(),
	update_user_id = 'CJAMS-62226'
where payment_detail_id in ('6100744','6104235')
	and delete_sw= 'N';