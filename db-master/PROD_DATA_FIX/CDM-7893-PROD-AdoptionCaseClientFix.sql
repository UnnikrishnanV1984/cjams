/*orig personid ='a185fa6e-77c4-4afb-91d1-0910ad716e3c'*/

--re-activate AR case kid
update person 
set activeflag =1, updatedon =now(), updatedby ='CDM-7893'
where personid ='bb6725d3-3a3b-4962-994c-7ebd8a5893e6';

--update person id for AR case kid
update intakeservicerequestactor
set personid ='bb6725d3-3a3b-4962-994c-7ebd8a5893e6', updatedon =now(), updatedby ='CDM-7893'
where intakeservicerequestactorid ='ef138dee-faab-48df-ab63-fa03cde9f28b';

--update person id for AR case kid
update actor 
set personid ='bb6725d3-3a3b-4962-994c-7ebd8a5893e6', updatedon =now(), updatedby ='CDM-7893'
where actorid ='bbf35212-5045-4413-b9a3-6fe5fd3ebbc8';

--update person id for AR case program area
update personprogramarea 
set personid ='bb6725d3-3a3b-4962-994c-7ebd8a5893e6', entityid ='20200344061827', updatedon =now(), updatedby ='CDM-7893'
where personprogramid ='f4749463-cabb-43a3-9707-9cbee9885719';

--de-activate duplicate program area
update personprogramarea 
set activeflag =0, updatedon =now(), updatedby ='CDM-7893'
where personprogramid ='c35b4370-2f65-4597-986b-0ffdac68778e';

--update correct name for Adoption Case kid
update person 
set firstname ='JA''MEARE', lastname ='Plummer', ssnno =null, updatedon =now(), updatedby ='CDM-7893'
where personid ='a185fa6e-77c4-4afb-91d1-0910ad716e3c';

--update correct name for Bio Case kid
update person 
set firstname ='Ja''Meare', lastname ='Sidibe', middlename =null, updatedon =now(), updatedby ='CDM-7893'
where personid ='3db4dd56-5d84-419e-96cc-4ff046198e40';