-- CDM-38464 - Commingled Account missing
/*
-- Issue Description: 
   Person has been removed with ticket # CDM-37702 on Case # 241021910974
    but the person name (Robert Todd Sr / PID: 4202481) still showed as 
    Alleged Maltreater under the case prior history.



--Root Cause:
--User Error. Client ID # 4202481 (Robert Todd Sr.) was added to the wrong case  and still showed as 
    Alleged Maltreater under the case prior history.
--Fix: As requested by the user removed  the Person 4202481 (1ca09d9f-ab87-43cb-b5a2-aeeb34a66f4c)
*/

select investigationallegationmaltreatorsid ,intakeservicerequestactorid,activeflag,updatedby,updatedon from investigationallegationmaltreators where intakeservicerequestactorid in
('ba9efe05-dcdb-4104-ba08-be9bb90daec7');

UPDATE cjams.investigationallegationmaltreators
SET activeflag = 0, updatedby='CDM-38464', updatedon=now()
WHERE intakeservicerequestactorid in ('ba9efe05-dcdb-4104-ba08-be9bb90daec7') and activeflag=1;                                                                         