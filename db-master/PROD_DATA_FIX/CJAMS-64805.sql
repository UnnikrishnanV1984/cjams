/*
Issue Description:CJAMS-64805 Sup was reviewing contact notes on case CW2763520 and it opened a program assignment for the head of household of that case. 
								CJAMS is not letting me close the program assignment
Category/Module: Program Assignment 
Root cause: User requested to remove the Program assignment as it is incorrect
Fix provided: Data fix has been done to remove Program Assignment from below CJAMSPID 3433344
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error and requested to remove the program assignment.
*/

update cjams.personprogramarea
    set activeflag = 0,
        updatedon = now(),
        updatedby = 'CJAMS-64805'
    where personprogramid in ('5e03955d-6747-4430-8808-e894f8092fe6')
    and activeflag = 1; 