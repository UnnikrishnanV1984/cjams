-- CDM-10053
update assessment set assessmentstatustypekey = 'InProcess',
updatedby = 'CIDM-4724',
updatedon = now()
 where assessmenttemplateid = '2aeb1d4c-db27-4393-9d90-19ee5dd7e997' and objectid = '19f1c413-20a8-4ff8-b9c8-df2ad37a74c1' 
