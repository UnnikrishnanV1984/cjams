UPDATE cjams.intakeservicerequest
SET intakeservicerequestclassid='00000000-0000-0000-0000-000000000000', activeflag=0,updatedby='CDM-1490', updatedon=now() 
WHERE intakeserviceid='66e1160f-dede-4526-97ea-d01c34552db2';

UPDATE cjams.personprogramarea
SET updatedby='CDM-1490', updatedon=now(), activeflag=0, datatransferflag='D'
WHERE personprogramid in ('f4f6ba1f-2718-4e3d-ac2f-3f27f2503e8f', '4f0484cc-f114-4abc-8eda-c68800d96ca0', '292cbe8a-2523-4e15-aed0-17863a8fa005', '5cb2fd7f-f804-412b-9d5b-cbd8ca62384c');