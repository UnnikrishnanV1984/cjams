/*
   Issue Description: CDM-36109
   Category/ Module  : Assessments: Other
   Root cause: Cannot approve, worker has sent for approval, supervisor not able to approve
   Fix Type: Datafix done, So deleted the mistakenly added records from AAPLA Assessments
*/

update assessment set activeflag=0,	updatedby = 'CDM-36109',updatedon = now()
where assessmentid='44b60c09-ccca-42f2-88c3-13dd5caf1484';

update assessment set activeflag=0,	updatedby = 'CDM-36109',updatedon = now()
where assessmentid='e71343cf-e8a9-45b8-99bb-958606f23231';

update assessment set activeflag=0,	updatedby = 'CDM-36109',updatedon = now()
where assessmentid='3574ce65-c95e-4802-adc4-2b04f568e4c6';