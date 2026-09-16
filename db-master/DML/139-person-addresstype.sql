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
insertedon,
updatedon,
insertedby, 
updatedby,
insertedon, 
updatedon,
1
from referencevalues where referencetypeid=172
and ref_key not in (select personaddresstypekey from personaddresstype);
drop VIEW cjams.actortype;
ALTER TABLE cjams.referencevalues ALTER COLUMN ref_key TYPE varchar(50) USING ref_key::varchar;

UPDATE referencevalues
set ref_key=subquery.countyid
FROM (select countyid,countyname from county ) AS subquery
WHERE referencevalues.value_text=subquery.countyname
and referencevalues.referencetypeid=306;

CREATE OR REPLACE VIEW cjams.actortype
AS SELECT referencevalues.displayorder AS sequencenumber,
    referencevalues.ref_key AS actortype,
    referencevalues.activeflag,
    referencevalues.description AS typedescription,
    referencevalues.updatedon AS effectivedate,
    referencevalues.updatedon + '1 year'::interval AS expirationdate,
    referencevalues.insertedon AS "timestamp",
    1 AS tasktype,
    referencevalues.insertedby,
    referencevalues.updatedby,
    referencevalues.insertedon,
    referencevalues.updatedon,
    NULL::unknown AS old_id,
        CASE
            WHEN referencevalues.referencetypeid = 175 THEN 'C'::text
            ELSE 'H'::text
        END AS rolegroup
   FROM referencevalues
  WHERE referencevalues.referencetypeid = ANY (ARRAY[175, 176]);

