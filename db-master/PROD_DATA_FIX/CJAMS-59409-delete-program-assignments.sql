/*
Issue Description:CJAMS-59409 Intake/Administrative override
Category/Module: Living Arrangement 
Root cause: User requested to remove the Program assignment as it is incorrect
            This case# 251022989208 was showing up in both CPS Milestone report and ACQI report.  
            This case# is available in Kent County Milestone report and this case continues to be on this report in error.  The CPS case# 251022989208 was not showing up in client history screen, although in their persons tabs there continues to show open program assignments. 
            These needs to be taken out of their program assignments.
Fix provided: Data fix has been done to remove Program Assignment (CPS AR - 251022989208) from below CJAMSPIDs
           Client ID: 4060585 (Kendra Andrea Johnson)
           Client ID: 4479883 (Keenan Houston Jr.)
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error and requested to remove the program assignment.
*/

update personprogramarea
    set activeflag = 0,
        updatedon = now(),
        updatedby = 'CJAMS-59409'
    where personprogramid in ('a717a114-2dc3-409f-b500-0f6f9b20f2f3','7e719cba-8c8b-4f11-a84c-460866eeb308')
    and activeflag = 1;    