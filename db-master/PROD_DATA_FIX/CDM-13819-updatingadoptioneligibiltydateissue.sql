-- CDM-13819
-- 2020-12-15 05:00:00	2021-01-06 05:00:00	2020-12-11 05:00:00
select childapplicableassessmentdt,adoptionldssdate,adoptionparent1signdate from adoptioninitialeligibilityinfo where clientid = 200308086;
update adoptioninitialeligibilityinfo set childapplicableassessmentdt = '2020-12-14 05:00:00' ,adoptionldssdate = '2021-01-05 05:00:00', adoptionparent1signdate = '2020-12-10 05:00:00',updatedby = 'CDM-13819', updatedon = now() where clientid = 200308086;
