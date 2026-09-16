/*
   Issue Description: CJAMS-68926
   Root cause: Dev Team,
            Provider# 
            Please carry out data fix to need to revert the write-off request for user to submit again. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update tb_receivable_detail
set written_off_amount_no = null, 
	receivable_status_cd = '19', 
	write_off_approval_status = null, 
	write_off_request_date = null,
	written_off_request_amount_no = null, -- 0
	update_ts = now(),
	update_user_id = 'CJAMS-68926'
where receivable_detail_id = 717167
	and delete_sw = 'N' 
	and ( select count(*) from routing 
		  where objectid = receivable_detail_id::character  varying
		  	and eventcode  = 'FNSWO'
			and activeflag = 1
		) = 0 ;
