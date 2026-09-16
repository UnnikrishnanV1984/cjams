UPDATE intakeservreqchildremoval 
SET exitdate=null,  
    updatedby='CDM-14116',
    updatedon=now() 
WHERE intakeservreqchildremovalid = '23e7fd9b-c80f-4105-a247-ea68e06b9e44';

UPDATE personprogramarea 
SET enddate = null, 
    updatedby = 'CDM-14116', 
    updatedon = now() 
WHERE personprogramid = '388bdcf0-15c7-4382-8db4-a0b3b47b38b2';