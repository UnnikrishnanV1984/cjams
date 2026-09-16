UPDATE cjams.personprogramarea
SET enddate=null, updatedon=now(), updatedby='CDM-16065'
WHERE personprogramid='53b5afe5-9e28-4ed8-b7dc-6fac69bed657'::uuid and programkey='OOH';
