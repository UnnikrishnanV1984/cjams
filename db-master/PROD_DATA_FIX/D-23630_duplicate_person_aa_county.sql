--D-23630 duplicate person records

update person set cisclientid = null, updatedon=now()
where personid = 'a66935da-ebdf-49c5-a24d-400e3b7974d2'

update personidentifier set activeflag=0, updatedon=now()
where personid = 'a66935da-ebdf-49c5-a24d-400e3b7974d2' and personidentifiertypekey='MDM_ID'
