UPDATE progressnote
set contactstatus = not attemptindicator,
updatedby = 'admin-D21095',
updatedon = now()
where old_id IS NULL 
AND insertedon > '2019-10-25'