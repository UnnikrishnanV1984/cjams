

/*
Issue Description: Please remove stuck approvals from the supervisor Monet Brown. 
Category/Module: case management 
Root cause: Please remove stuck approvals from the supervisor Monet Brown case pending approval dashboardas there are no pending approval available on each cases.
Fix provided: Data fix done to remove stuck approvals.
Data/Code fix ticket#: CJAMS-68048
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User request
*/
update routing set activeflag =0, updatedon =now()
where routingid  in ('cf2224fd-0db7-4c30-8389-ba8fa26b1711', '7f1bb396-a9ca-4ec8-9cef-243b0f717479', 'eb4df585-ebf6-4e22-b6d7-15ad9706b208', '47ac10fa-a7c8-49be-b623-ece2a47fab12');