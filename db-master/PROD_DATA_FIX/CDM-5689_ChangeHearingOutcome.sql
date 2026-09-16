-- CDM-5689 - Court Order error change Hearing outcome and Remarks in Court Order tab

-- Updated remarks for Nora and Alexander King
update intakeservreqcourtorder set remarks = 'Children returned to mother under OPS', updatedon = now(), updatedby = 'CDM-5689' where intakeservreqcourtorderid = 'e519e8f6-46af-4ed3-87d5-d007731289e6' and activeflag =1;
update intakeservreqcourtorder set remarks = 'Children returned to mother under OPS', updatedon = now(), updatedby = 'CDM-5689' where intakeservreqcourtorderid = '4bd48291-240f-4e5b-86a8-3ab4258a35f9' and activeflag =1;

-- Updated Hearing outcome for Nora and Alexander King
update intakeservreqcohearingoutcome set hearingoutcometypekey = 'ORDPROSUP', updatedon = now(), updatedby = 'CDM-5689' where intakeservreqcourtorderid = 'e519e8f6-46af-4ed3-87d5-d007731289e6' and hearingoutcometypekey = 'TEMCOM' and activeflag =1;
update intakeservreqcohearingoutcome set hearingoutcometypekey = 'ORDPROSUP', updatedon = now(), updatedby = 'CDM-5689' where intakeservreqcourtorderid = '4bd48291-240f-4e5b-86a8-3ab4258a35f9' and hearingoutcometypekey = 'TEMCOM' and activeflag =1;
