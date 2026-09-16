update
    intakeservreqchildremoval
set
    exitdate = '2020-10-21 09:00:00',
    removalexitreason = 'REUNIF',
    updatedby = 'CDM-10693',
    updatedon = now()
where
    intakeservreqchildremovalid = '43234790-d0cd-43ec-9606-064224641efd'
    and servicecaseid = '2536727e-33ce-4a93-8e69-49022a58f640';