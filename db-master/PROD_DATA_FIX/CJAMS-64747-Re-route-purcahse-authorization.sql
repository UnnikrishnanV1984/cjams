/*
Issue: CJAMS-64767 Outstanding end date of service log
Category/Module: Purchase Authorization 
Root cause: There is a pending funding approval that is assigned to Debra Dandridge. The Finance Supervisor has retired and Data fix needed to re-route the purchase authorization to 
            the  Finance Supervisor (Linnel Benton).
Fix provided:  Data fix has been done to re-route the purchase authorization from Debra Dandridge to Linnel Benton.
            Case: 3183659, Client ID: 3932999 (AKEEM CARROLL)
            Provider ID: 5036607 (Baltimore City Department of Social Services)
            Auth ID: 2736401 (Pending Funding Approval)
Data/Code fix ticket#: CJAMS-64767
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User has retired and we need data fix for this issue
*/

update routing 
set tosecurityusersid = 'b0fbf926-91a3-4a91-a6a4-62e458683797',
    updatedon = now(),
    updatedby ='CJAMS-64767'
where routingid = 'ea6dc424-b2ce-45e7-a8c6-f70022521cfc'
and activeflag =1;