update userprofile 
set teamtypekey ='CW', updatedon =now(), updatedby ='CDM-12073'
where securityusersid ::uuid='d636ac2f-53ff-43e0-adbf-35c97e0427ec'::uuid;