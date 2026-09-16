
-- CDM-12179
-- 2020-08-14 00:00:00
update personprogramarea p set enddate = null,updatedon = now(), updatedby = 'CDM-12179' where personprogramid = 'e44aade5-976f-4315-bbd5-40e953d7c602';

