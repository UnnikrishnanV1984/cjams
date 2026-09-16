
/*
   Issue Description: CDM-30939
   Category/ Module  : Agreement Documents
   Root cause: provider payment is missing
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select provider_id, startdate, enddate, approvaldate, updatedon, updatedby, activeflag  
    from adoptioncaserevision a  
where adoptionagreementrateid  
    in ( '4df45131-c9dd-477b-9f22-5493963357b3', 'c7a85389-3660-4f14-b5e5-9e557674192a' )
and approvaldate is not null ;

update adoptioncaserevision
set updatedby = 'CDM-30939',
    updatedon = now(),
    approvaldate = now()
where adoptionagreementrateid  
    in ( '4df45131-c9dd-477b-9f22-5493963357b3', 'c7a85389-3660-4f14-b5e5-9e557674192a' ) 
    and approvaldate is not null ;


    select payment_id, payment_status_id, payment_status_cd, delete_sw, update_ts, update_user_id
	from tb_payment_status  
where payment_id in (3308604,3308607,3308608,3308606,3308605,3316175)
	and delete_sw = 'N' ;

update tb_payment_status
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-30939'
where payment_id in (3308604,3308607,3308608,3308606,3308605,3316175)
	and delete_sw = 'N' ;

select payment_id, payment_detail_id, delete_sw, update_ts, update_user_id, delete_sw 
	from tb_payment_detail 
where payment_id in (3308604,3308607,3308608,3308606,3308605,3316175)
	and delete_sw = 'N' ;

update tb_payment_detail
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-30939'
where payment_id in (3308604,3308607,3308608,3308606,3308605,3316175)
	and delete_sw = 'N' ;
	
select payment_id, provider_id, payment_type_cd, delete_sw, update_ts, update_user_id
	from tb_payment_header 
where payment_id in (3308604,3308607,3308608,3308606,3308605,3316175)
	and delete_sw = 'N' ;

update tb_payment_header
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-30939'
where payment_id in (3308604,3308607,3308608,3308606,3308605,3316175)
	and delete_sw = 'N' ; 

