/*
   Issue Description: CDM-19117
   Category/ Module  Child removal
   Root cause: user forgot to open the OOH program assignment
   Pull request# for code fix: 
  explanantion: user wants to open OOG program assignments in child removal
*/

update personprogramarea set enddate = null, updatedon = now(), updatedby = 'CDM-19117'
 where (personid, personprogramid) in (('c9136513-c996-4349-ac81-5099a3ddd353','c0c5a5fb-31a6-44fa-b9cd-fafee8da2f42'),
('9da13e49-b635-43e7-83ef-88b24fc7a9fe', 'e20011ba-12c4-4168-b0b9-b3c85f52f88a'));