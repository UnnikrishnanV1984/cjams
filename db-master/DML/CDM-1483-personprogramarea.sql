UPDATE cjams.personprogramarea
SET updatedon=now(), updatedby='CDM-1483', activeflag=0, datatransferflag='D'
WHERE personprogramid='28a7609a-cf34-48d5-b0aa-d0d424c17719';

UPDATE cjams.intakeservicerequest
SET activeflag=0, updatedon=now(), updatedby = 'CDM-1483' 
WHERE intakeserviceid='2cb0c069-9633-40f6-8274-a27ffe8bf83d';

UPDATE cjams.intakedastaging
SET updatedon=now(), updatedby='CDM-1483', activeflag = 0
WHERE intakenumber='I202000164308' and activeflag = 1;


