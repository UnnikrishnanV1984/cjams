/*
 * CDM-35495 - Case is still listed as pending
 * Customer Email ID:elvira.johnson@maryland.gov
 * Customer Name:Elvira Johnson
 * Focus Area:Services: Other
 * Description - I231010673580:The referral was submitted to the Screening supervisor and Screened out; however, it remains on my dashboard as pending. Screen URL: https://cw.cjams.mdthink.maryland.gov/#/pages/newintake/my-newintake/I231010673580/edit/narrative
 * data fix to make the case available in supervisor Dashboard # I231010673580 
*/
update cjams.routing set eventcode='INTR',routingstatustypeid =1, activeflag =1, updatedon = now()

where routingid ='7928e3ce-0221-4a75-b672-9f917244436d';



UPDATE intakedastaging 
 set updatedby = 'CDM-35495', updatedon = now(),
 jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I231010673580' AND activeflag=1;