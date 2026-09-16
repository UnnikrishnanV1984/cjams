-- CDM-10473 - Change child removal exit date

update intakeservreqchildremoval set exitdate = '2020-08-18 08:45:00', updatedby = 'CDM-10473', updatedon = now() where intakeservreqchildremovalid in ('7c6b8fe2-3127-469b-bc80-166371e9d87e','68f1f445-c124-4ea4-a542-3821e326cac5','0c992921-57a6-45b3-b70f-4543c8988911');
