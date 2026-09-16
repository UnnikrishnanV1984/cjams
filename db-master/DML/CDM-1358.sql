update usernotification
set activeflag= 0, updatedon = now(), updatedby ='Datafix user as per CDM-1358'
where usernotificationid in ('decf0b7e-5368-4821-8c0a-b2b70bfb0a46','6301eb0e-1341-407b-8aad-1ba574af4c83');