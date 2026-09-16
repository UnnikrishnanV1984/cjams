/*
Issue Description:251023004819:On the response timer Over Due Reason box, the drop down options are no longer selected. Please correct the drop down reasons to: Child out of jurisdiction > ROA pending - in-state but other LDSS was unable to see alleged victim within mandate > Montgome
Category/Module: Overdue Reason
Root cause:Data Entry error and fix needed to correct the contact with alleged victim dropdown values as orrect the drop down reasons to: Child out of jurisdiction > ROA pending - in-state but other LDSS
Fix provided: Data fix to update the over due reason for alleged victim as orrect the drop down reasons to: Child out of jurisdiction > ROA pending - in-state but other LDSS
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VCOJ',
    cpsresponsetimerreason2 = 'VRIJ',
    cpsresponsetimerreason3 = 'VMOJ',
    cpsresponsetimerreason7 = 'CCOJ',
    cpsresponsetimerreason8 = 'CRIJ',
    cpsresponsetimerreason9 = 'CMOJ',
    updatedon = now(),
    updatedby = 'CJAMS-59075'
where cpsresponsetimeractionsid = '975577c1-2a77-4295-85d7-5c5978f2835e'
and intakeserviceid = 'd95f98c5-5c2d-4113-b04b-b29e56d162b7';