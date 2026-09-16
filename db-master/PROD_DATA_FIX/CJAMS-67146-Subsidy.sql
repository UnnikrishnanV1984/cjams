/*
Issue: CJAMS-67146- Subsidy
Category/Module: GAP / Suspension
Root cause:Need technical investigation if there are 2 active records in routing table with approved and rejected status - Due to rejected status application is not allowing to proceed further in agreement tab.

If yes, please proceed with data fix to remove the rejected record to proceed further

Case ID: 3256299
Client ID: 200161766 (Dionne Thompson)
Fix provided:  Data fix has been done to remove rejected record.
Data/Code fix ticket#:
Regression Impacts: N/A
Is Code fix Required?: Yes , Already we have a codefix
Code fix ticket#:  CIDM-11273
*/


update routing 
set activeflag = 0, updatedon= now(), updatedby='CJAMS-67146'
where routingid='e345838c-6905-40cf-9d58-72443d570451' and activeflag = 1;