UPDATE intakeservicerequest
SET activeflag = 0
WHERE intakenumber = 'I202000362346' and activeflag = 1;

UPDATE intakedastaging
SET ispreintake = null, status = 'pending'
WHERE intakenumber = 'I202000362346' and activeflag = 1;