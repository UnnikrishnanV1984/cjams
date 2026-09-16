/*
Issue Description: Please do data fix for these cases Reporting mart still showing case status as open but application these three cases are closed.
Please update audit columns to pickup in the reports. 251023035116, 251023035118, 251023033056
Category/ Module: CJAMS
Root cause: There was partial transection on the routing table and to complete that CJAMS-60733 was promoted without the audit column being updated
and it worked fine with the application side but got the issue on the milestone report.
Fix provided: Yes, wrote DB query.
Code fix ticket#: N/A
Reason why no related code fix: this is data issue.
*/

update routing 
set updatedby ='CIDM-10810',
    updatedon =now()
where routingid in ('641eb274-3bc1-45ac-8298-33f589558ff6','897dcb9a-e36d-4ac3-be3e-d5f4f34a9eeb','e49ae4b0-3cc2-4f90-9ada-d5300b91f547')
and activeflag =1;