/*
   Issue Description: CDM-37150 - Case # 3272649
   The case of Theresa Hodges has been on my tree for a an approval for over 6 months and needs to be removed. It will continue to show that I have unapproved items in my inbox if not removed, causing a report error.
   Category/ Module  : Approval Inbox
   Root cause: Approved case is showing in Case pending Approval Dashboard
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix: Data fix to remove the approval request record.
*/

update routing 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37150'
    where routingid = '62c68277-2389-4f43-ad2f-8bc6355ac0a2'
    	and activeflag = 1;