update adoptioniverenewal 
set activeflag =0, updatedon =now(), updatedby ='CDM-10668'
where adoptioniverenewalid ='2bd5ebdf-6542-4e86-adaf-27d94374bd2f';

update routing 
set activeflag =0, updatedon =now(), updatedby ='CDM-10668'
where objectid ='2bd5ebdf-6542-4e86-adaf-27d94374bd2f';