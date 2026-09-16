UPDATE routing
SET eventcode = 'INTR', activeflag=1
WHERE objectid = 'I202000361743' and activeflag = 0;

UPDATE intakedastaging
SET ispreintake = null
WHERE intakenumber = 'I202000361743' and activeflag = 1;

UPDATE intakeservicerequest
SET activeflag=0
WHERE intakenumber = 'I202000361743' and activeflag = 1;
