
/*
   Issue Description: CDM-26678
   Category/ Module  :  Intake
   Root cause: user asked to delete the pending intake
*/

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26678'
where objectid in ('I221010247786','I221010274573','I221010291468','I221010294031','I221010324809','I221010329503','I221010329703');

UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-26678',
    updatedon = now()
WHERE intakenumber in ('I221010247786','I221010274573','I221010291468','I221010294031','I221010324809','I221010329503','I221010329703');

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-26678',
    updatedon = now()
WHERE intakenumber in ('I221010247786','I221010274573','I221010291468','I221010294031','I221010324809','I221010329503','I221010329703');

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26678'
WHERE intakenumber in ('I221010247786','I221010274573','I221010291468','I221010294031','I221010324809','I221010329503','I221010329703');
