
-- 2021-04-02 00:00:00 2021-04-02 08:00:00
update intakeservreqchildremoval i set removaldate = '2021-04-01 00:00:00', removaltime = '2021-04-01 08:00:00', updatedby = 'CDM-14133', updatedon = now() where removalid in ('251999','251998','252000');

-- 2021-04-02 00:00:00
update personprogramarea set startdate = '2021-04-01 00:00:00', updatedon = now() where personprogramid in ('98865762-a068-484e-bb1c-b7db60bd7617','68dcba71-431e-4239-a731-c5da4bf4d1cc','a28606bf-c3b8-44dc-853a-912d7b0a82e3');

