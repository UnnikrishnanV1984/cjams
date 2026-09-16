-- CDM-13820
-- 2020-12-08 01:18:28	2021-02-10 01:00:00	2020-07-07 22:00:00
select childapplicableassessmentdt,adoptionldssdate,adoptionparent1signdate from adoptioninitialeligibilityinfo where clientid = 200642804;
update adoptioninitialeligibilityinfo set childapplicableassessmentdt = '2020-12-07 05:00:00' ,adoptionldssdate = '2021-02-09 05:00:00', adoptionparent1signdate = '2020-07-07 05:00:00',updatedby = 'CDM-13820', updatedon = now() where clientid = 200642804;
