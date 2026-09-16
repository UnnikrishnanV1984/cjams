--D-23262 update SDM

update intakeservicerequestsdm set ismalsa_sex_trafficking=true, updatedon=now()
where intakeserviceid = '34e2d38d-32ea-40e6-9f3d-693b8f0404c4'

--D-23003 update mdm id

update personidentifier set personidentifiervalue = 'MDT-130993877'
where personid='ccee6b59-7736-4940-820d-aa8a0a197a5e'
and personidentifiertypekey like 'MDM_ID' and personidentifiervalue = 'MDT-130824207'

--D-23264 update mdm_id
update personidentifier set personidentifiervalue = 'MDT-131032318'
where personidentifiertypekey like 'MDM_ID' and personidentifiervalue = 'MDT-130818770'