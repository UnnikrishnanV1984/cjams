update rolemapping
set activeflag=1, updatedon =now(), updatedby = 'CDM-11838'
where id = '21281109';

update rolemapping
set activeflag=0, updatedon =now(), updatedby = 'CDM-11838'
where id = '35773524';