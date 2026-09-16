/*
Root Cause:user error,  user incorrectly select the Child Fatality & Near-Death/Serious Physical Injury incorrectly
Fix Provided (Data Fix Only): Data fix is done to update the child fatality from No to Yes and Near-Death/Serious Physical Injury from yes to NO.
Data/Code fix ticket#: CJAMS-66846
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: this was a one time data correction specific  to a single referral.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/


update cjams.intakeservicerequestsdm
set isseriousphysicalinjury = false, 
    ischildfatality = true,
    updatedby = 'CJAMS-66846',
    updatedon = now()
where intakeservicerequestsdmid = 'edab3205-1446-494f-a08d-a81bb764f53d'
    and intakeserviceid = '2da3de73-d086-43f2-841a-6dfe52805e80'; 