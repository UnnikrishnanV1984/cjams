UPDATE intakeservreqcourtorderdetails
SET    isselected = 0,
       remarks = '',
       updatedon = now(),
       updatedby = 'CDM-21304'
WHERE  intakeservreqcourtorderid = '0335db95-7cd9-4405-aeb0-4eb8ffc3dd2d'
       AND intakeservreqcourtorderdetailsid =
           'fdbf5d08-491a-4a6d-baf3-acdf727d0c87'
       AND isselected = 1;

UPDATE intakeservreqcourtorderdetails
SET    isselected = 1,
       remarks = 'Sexual abuse, physical abuse, and neglect',
       updatedon = now(),
       updatedby = 'CDM-21304'
WHERE  intakeservreqcourtorderid = '0335db95-7cd9-4405-aeb0-4eb8ffc3dd2d'
       AND intakeservreqcourtorderdetailsid =
           '0cc8545c-dabb-4792-ba0a-40d77240b7e8'
       AND isselected = 0; 