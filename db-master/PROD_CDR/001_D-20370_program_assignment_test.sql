--D-20370 data fix to update OOH end date for the case 3046820
UPDATE personprogramarea SET enddate = '2019-10-24 00:00:00',  updatedon = current_timestamp, datatransferflag='U' 
WHERE personprogramid='1629e383-99b0-4288-a4ca-200c83a22232'