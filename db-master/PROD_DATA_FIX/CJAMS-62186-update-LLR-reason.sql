/*
Issue Description:251023114392:This case needs a support ticket to fix that drop down as Instead of choosing Data Entry Error, this one should be "Alleged victim unavailable > Attempted face to face > 3-4 attempts.
Category/Module: Overdue Reason
Root cause:Data Entry error and 251023087550: the worker selected "Emergency situation prevented initial contact > Non-work related emergency.It needs to be changed to  "Alleged victim unavailable > Family contacted but unavailable to meet within mandate.
Fix provided: Data fix to update the LLR over due reason as follows
              Contact with Alleged Victim Completed;
                Alleged victim Unavailable
                Family contacted but unavailable to meet within mandate
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VFCM',
    updatedon = now(),
    updatedby = 'CJAMS-62191'
where cpsresponsetimeractionsid = '01f405c0-4d55-4692-b54b-858429485224'
and intakeserviceid = 'e14b7e0c-8f95-47c9-9adc-d1ec5ba8c584';