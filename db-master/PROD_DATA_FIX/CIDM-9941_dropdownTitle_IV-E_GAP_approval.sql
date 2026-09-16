/*
  Issue Description:  CIDM-9941
   Category/ Module  :  Title IVE
   Root cause: approval date was missing in the DB
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/
update gapeligibilityinfo
set updatedby = 'CIDM-9941',
	updatedon = now(),
	haapprovaldtjson = '[
                {
                    "text": "2023-01-25",
                    "value": 119645
                },
                {
                    "text": "2022-11-01",
                    "value": 119645
                }]'           
where client_id = 3597446 
and childguardianid = 6007621
and activeflag = 1;