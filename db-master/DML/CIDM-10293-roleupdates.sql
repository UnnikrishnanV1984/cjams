UPDATE cjams.role_resource
SET activeflag=0, updatedby='CIDM-10293', updatedon=now()
WHERE roleid=135 and id='2be180c8-d9ba-4ef1-be3c-c3d365e97e38'::uuid;

UPDATE cjams.teammemberroletype
SET updatedby='CIDM-10293', updatedon=now(), rolelevel=40
WHERE roletypekey in ('CWPSYCOORD','CWPSYPHARM','CWPSYPSYCH');