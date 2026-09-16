/*
-- CDM-23770 -- 
-- Issue Description: Incorrect user name is displaying in program assignment updated by
*/

UPDATE personprogramarea
SET updatedon = now(), updatedby = 'ee7a8459-06e3-40b3-9037-3cc0e8130202'
WHERE personprogramid = 'dc4e0714-efa5-4931-95c3-5e0c27779ea1';
