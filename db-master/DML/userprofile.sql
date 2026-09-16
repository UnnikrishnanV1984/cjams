UPDATE userprofile 
SET ssn = tb_staff.ssn_no
FROM (
   select tb_staff.ssn_no,tb_staff.staff_id from tb_staff 

) as tb_staff
where tb_staff.staff_id = userprofile.old_id;

update intakeservicerequestsdm set isfinalscreenin = false where intakeserviceid = 'd0dbf303-2a8a-4998-99f7-b7741bb51188';

update intakedastaging set activeflag=0 where intakenumber = 'I202000159592';