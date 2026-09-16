--
-- UPDATE SCRIPT TO CORRECT VALUES IN CRBREFERENCEVALUES FOR DEFECT D-21142 FOR CRB INTERFACE
-- 11/13/2019 - Hadi Siddiqui
--
update crbreferencevalues set chessiecode = '1647' where referenceid = 44 and cjamscode = 'Reunification';
update crbreferencevalues set chessiecode = '1644' where referenceid = 45 and cjamscode = 'ADOPTNR';
update crbreferencevalues set chessiecode = '1649' where referenceid = 46 and cjamscode = 'GUARDR';
update crbreferencevalues set chessiecode = '1644' where referenceid = 47 and cjamscode = 'ADOPTR';
update crbreferencevalues set chessiecode = '1649' where referenceid = 48 and cjamscode = 'Guardianship';
update crbreferencevalues set chessiecode = '1645' where referenceid = 49 and cjamscode = 'APPLA';
