UPDATE progressnote
SET totaltime = concat_ws(':', DATE_PART('hour', endtime - starttime )::integer, DATE_PART('minute', endtime - starttime )::integer),
updatedby = 'admin-D22079',
updatedon = now()
WHERE old_id IS NULL
AND insertedon >'2019-10-25'
AND endtime IS NOT NULL
AND endtime >= starttime
AND totaltime IS NULL;