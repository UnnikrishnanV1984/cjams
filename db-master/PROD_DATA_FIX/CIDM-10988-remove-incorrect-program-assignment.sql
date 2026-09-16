/*
Issue: CIDM-10988 - Need data fix to remove the incorrect program assignment
Category/Module: Program assignment
Root cause:  Program assignment getting created for SEN child when supervisor screenouts intake type Risk of Harm . This is a code issue when it was implemented as the part of  CIDM-10625 Plan Of Safe Care (POSC) Enhancements
             Code fix has been done as the part of CDM-44633 and data fix needed for this ticket.
             Case# 261030623358
             Client id# 204511870
Fix provided:  Data fix has been done to delete the incorrect program assignment created for the case 
Data/Code fix ticket#: CIDM-10988
Regression Impacts: N/A
Is Code fix Required?: yes
Code fix ticket#: CDM-44633
Reason why no related code fix: N/A
*/


update personprogramarea
set activeflag = 0,
    updatedby = 'CJAMS-64532',
    updatedon = now()
where personprogramid = 'd199eaf3-5e2a-43ad-a469-4b34be4bb966'
and personid = 'f9097b3e-5ede-446e-8d4a-045c2fde982e'
and activeflag = 1;