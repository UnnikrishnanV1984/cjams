/*
   Issue Description: CDM-39255
   Category/ Module : Intake Dashboard
   Root cause: 
   Fix Provided: Did data fix to remove old case from pending dashboard

*/
UPDATE cjams.intakedastatus
SET status=2, updatedby='CDM-39255', updatedon=now()
WHERE intakenumber='CW10175611';

UPDATE cjams.intakedastaging
SET status='Complete', updatedby='CDM-39255', updatedon=now(), activeflag = 0
WHERE intakenumber='CW10175611' and activeflag = 1;
