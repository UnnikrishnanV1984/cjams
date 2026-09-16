-- CDM-13822

-- 2020-12-30 10:00:00	2021-01-05 15:00:00	2020-12-19 01:00:00
select childapplicableassessmentdt,adoptionldssdate,adoptionparent1signdate from adoptioninitialeligibilityinfo where clientid = 200314238;
update adoptioninitialeligibilityinfo set childapplicableassessmentdt = '2020-12-30 05:00:00' ,adoptionldssdate = '2021-01-05 05:00:00', adoptionparent1signdate = '2020-12-18 05:00:00',updatedby = 'CDM-13822', updatedon = now() where clientid = 200314238;

