/*
Issue: CIDM-11043 Data fix for CDM-44642 - CW2036120
Category/Module: Program Assignment
Root cause:CW2036120 Incorrect program assignment is getting created when we are viewing a person profile for a closed CPS-IR cases due to issue in the code.
           This is happening due to code issue which is done as the part of CDM-44642
Fix provided:  Data fix is done as the part of this ticket to remove the incorrect program assignment.
Data/Code fix ticket#: CIDM-11043
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CDM-44642
Reason why no related code fix: N/A
*/

update personprogramarea
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CIDM-11043'
where objectid = '2fb7a8c5-f091-4bc3-a99d-32c02ac5db9e'
and enddate is null
and activeflag =1;  