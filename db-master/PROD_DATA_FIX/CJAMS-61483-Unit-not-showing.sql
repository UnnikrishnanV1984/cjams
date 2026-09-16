/*
   Issue Description: CJAMS-61483
   Category/ Module  : work load
   Root cause: FNS unit wasn't populating for taryn.shambaugh@maryland.gov as there is wrong teamtype key and parent teamid was being mapped
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update team
set teamtypekey = 'CW',
	updatedby = 'CJAMS-61483',
	parentteamid = '3254e9ef-08da-4cd7-8aa1-083896ed9bec', --24c59d52-50cc-4d0b-ae19-4b004b247048	Demo County
	updatedon = now()
where countyid = '3254e9ef-08da-4cd7-8aa1-083896ed9bec' and teamtypekey = 'FNS'
and teamid = 'eec93b08-ce1d-4305-92b1-78cdc1c1ba4e';