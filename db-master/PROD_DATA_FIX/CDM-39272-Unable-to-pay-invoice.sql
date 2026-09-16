/*
Issue Description: Dashboard:I am trying to pay an invoice for the month of February 2024. I initially submitted an authorization request to pay an invoice that was dated from 1/24/24 to 2/24/24. That authorization was denied. Despite this, I was unable to pay another invoice from 2/1/24 to 3/1/24 for the same service because the second invoice generated an error message that stated there were overlapping dates, even though the first authorization had been denied. I would like to have the invoice (Provider ID: 5086033 and auth number 3029768 to reflect the new dates of 1/24/24 to 3/1/24 as I believe that this should fix the issue.
Category/ Module: User Error
Root cause: Overlapping dates preventing invoice payment. Requested to change the end date for the invoice to 3/1/2024
Fix provided: Yes, write db query
Code fix ticket#:CDM-39272
Reason why no related code fix: Status of the code fix already submitted
Status of the code fix if already submitted and expected prod fix date: N/A
Backup before update/ delete:
*/

--Updated tb_service_log
update tb_service_log
set
	end_dt = '2024-03-01',
	estimated_end_dt = '2024-03-01',
	update_user_id = 'CDM-39272',
	update_ts = now()
	where service_log_id = 3053043
	and case_id = 3243421;