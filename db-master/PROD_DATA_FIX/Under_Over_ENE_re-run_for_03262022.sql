-- Manual run of the Under-Over SPs for 03/26/2022 
-- Batch did not run on on the weekedn due to teh Batch server space issue)

-- Provider Batch Checklist
select * from cjams.sp_batch_prov_checklist('U'::character, '2022-03-26'::date) ;

-- UNDER OVER ADOPTION
select return_code, al_sqlcode, as_error
from cjams.sp_under_over_adoption('2022-03-26'::date) ;

-- UNDER OVER GAP
select return_code, al_sqlcode, as_error
from cjams.sp_under_over_gap('2022-03-26'::date) ;

-- UNDER OVER PVT
select * from cjams.sp_under_over_pvt('2022-03-26'::date) ;

-- UNDER OVER PUB
select * from cjams.sp_under_over_pub('2022-03-26'::date) ;


-- For CJAMS - E&E manual run of Batch # 234 Response received on 03/26

select successful_sw, runstatus, batchnumber, interfaceid, updatedby, updatedon 
	from cjams.interfacesruntimeslog
where runid = 4845 
	and batchnumber = 234 ;

update cjams.interfacesruntimeslog 
set successful_sw = 'P', 
	updatedby = 'DFX03282022', 	
	updatedon = now() 
where runid = 4845 
	and batchnumber = 234 ;

