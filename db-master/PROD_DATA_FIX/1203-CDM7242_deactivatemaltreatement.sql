--CDM-7242
update Investigationmaltreatment set activeflag=0,updatedby='CDM-7242',updatedon=now() where maltreatmentid in
('a4cd5d69-4abd-4b39-88b6-d42cab28471c','f4194d89-4eb2-4e80-b933-bd98538e1d8d','13d6fee8-b9d3-417c-9564-9e636392e0bb','3f926e37-7859-42a0-99e3-e401fc072139');
