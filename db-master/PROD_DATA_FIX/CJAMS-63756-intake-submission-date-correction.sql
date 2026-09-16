/*
Issue Description:Intake previously approved - reappeared
Category/Module: Intake
Root cause: Intake has incorrectly appeared in the pending dashboard and data fix needed to correct it submission history as requested by the user.
            User has screened In and approved the intake on 10/20/2025 but somehow the status turned back to review. 
            The intake has been approved again on 12/2/2025. Please do a data fix to update the Approved on date in the intake submission history from 12/02/2025 to 10/20/2025.
Fix provided: Data fix has been done to update the Approved on date in the intake submission history from 12/02/2025 to 10/20/2025.
Data/Code fix ticket#: CJAMS-63756
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data fix is needed as per the system design.
*/

-- not updating the audit columns as it is impacting the data in decision table
update routing
set updatedon = '2025-10-20 09:56:35'
where objectid = 'I251013381396'
and activeflag =1;    
    
