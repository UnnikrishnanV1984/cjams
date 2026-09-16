/*
Issue Description: CIDM-11617 - Intake Referral I261013913305 
Category/Module: Child Welfare / Intake Referral / Dashboard
Root cause: The PENDING tab of the worker's "My Intakes" dashboard only lists intakes whose
            intakedastaging row has status = 'pending' and ispreintake = false.
            This referral's row was saved with status = 'Complete' and ispreintake = true,
            so the dashboard filtered it out and the worker could never open it.
Fix provided: Update the referral's active intakedastaging row to set status = 'pending' and
            ispreintake = false, so it shows in the PENDING section of the worker's dashboard.
Data/Code fix ticket#: CIDM-11617
Regression Impacts: N/A
Is Code fix Required?: N 
Code fix ticket#: N/A
Reason why no related code fix: Data issue on a single referral. The listintakedetails filtering
            is by design.
*/


UPDATE cjams.intakedastaging
   SET status      = 'pending',
       ispreintake = false,
       updatedon   = now(),
       updatedby   = 'CIDM-11617'
 WHERE intakenumber = 'I261013913305'
   AND teamtypekey  = 'CW' AND status='Complete'
   AND activeflag   = 1;


