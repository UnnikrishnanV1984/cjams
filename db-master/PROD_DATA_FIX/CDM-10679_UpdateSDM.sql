-- CDM-10679 - no maltreatment record found because there is no SDM info.

update intakeservicerequestsdm set ismalpa_caregiver = true, updatedby = 'CDM-10679', updatedon = now() where intakeservicerequestsdmid ='2b73c60f-7085-4ec0-8fe9-8ad66d7dd603';
