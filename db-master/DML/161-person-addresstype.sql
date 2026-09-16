INSERT INTO cjams.personaddresstype
(sequencenumber,
personaddresstypekey,
activeflag, 
datavalue, 
editable,
typedescription,
effectivedate, 
expirationdate, 
insertedby, 
updatedby,
insertedon, 
updatedon,
old_id)
select 
row_number() OVER (ORDER BY ref_key) AS i,
ref_key,
activeflag,
1,
1,
description,
current_date(),
updatedon,
insertedby, 
updatedby,
insertedon, 
updatedon,
1
from referencevalues where referencetypeid=172;
and ref_key not in (select personaddresstypekey from personaddresstype);
UPDATE referencevalues
set ref_key=subquery.countyid
FROM (select countyid,countyname from county ) AS subquery
WHERE referencevalues.value_text=subquery.countyname
and referencevalues.referencetypeid=306;