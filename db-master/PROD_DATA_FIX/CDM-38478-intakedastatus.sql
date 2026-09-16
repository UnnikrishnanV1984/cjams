/*
   Issue Description: CDM-38478
   Category/ Module : Intake Dashboard
   Root cause: 
   Fix Provided: Did data fix to remove old case from pending dashboard

*/
UPDATE cjams.intakedastatus
SET status=2, updatedby='CDM-38478', updatedon=now()
WHERE intakenumber='CW10126249';

UPDATE cjams.intakedastaging
SET status='Complete', updatedby='CDM-38478', updatedon=now(), activeflag = 0
WHERE intakenumber='CW10126249' and activeflag = 1;
