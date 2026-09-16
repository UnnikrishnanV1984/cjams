
/*
   Issue Description: CDM-16385
   Category/ Module  : Child Removal
   Root cause: user request to remove 
   Pull request# for code fix: 5821
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/


--- Removed without placement duplicate childremoval records 


select activeflag, removalid, * from intakeservreqchildremoval 
where intakeservreqchildremovalid in('e28b9ad0-74c3-4065-9520-286d36811a8a','87283658-90b8-4f41-80b3-c24b71ac159b');

select intakeservreqchildremovalid, * from placement 
where intakeservreqchildremovalid in('78b6eb6f-617f-484d-ad3e-db2d331077aa','c7d38065-7c9d-4c92-b3c8-c8bd250d1f23');

select activeflag, removalid, * from intakeservreqchildremoval 
where intakeservreqchildremovalid in('78b6eb6f-617f-484d-ad3e-db2d331077aa','899d6143-a4dc-42c6-8d88-812eaebfd6d9');

select activeflag, removalid, * from intakeservreqchildremoval 
where intakeservreqchildremovalid in('78b6eb6f-617f-484d-ad3e-db2d331077aa','c7d38065-7c9d-4c92-b3c8-c8bd250d1f23');

select activeflag, removalid, * from intakeservreqchildremoval 
where intakeservreqchildremovalid in('fb5db60e-3d56-4ddc-b54b-b245d3c2054b','5ebaf7a3-580e-4292-8357-7f3d35a48d49');

select intakeservreqchildremovalid, * from placement 
where intakeservreqchildremovalid in('fb5db60e-3d56-4ddc-b54b-b245d3c2054b','5ebaf7a3-580e-4292-8357-7f3d35a48d49');



update cjams.intakeservreqchildremoval set activeflag =0, updatedby ='CDM-16385', updatedon = now()

where intakeservreqchildremovalid in('e28b9ad0-74c3-4065-9520-286d36811a8a');


update cjams.intakeservreqchildremoval set activeflag =0, updatedby ='CDM-16385', updatedon = now()

where intakeservreqchildremovalid in('c7d38065-7c9d-4c92-b3c8-c8bd250d1f23');

update cjams.intakeservreqchildremoval set activeflag =0, updatedby ='CDM-16385', updatedon = now()

where intakeservreqchildremovalid in('fb5db60e-3d56-4ddc-b54b-b245d3c2054b');

update cjams.intakeservreqchildremoval set activeflag =0, updatedby ='CDM-16385', updatedon = now()

where intakeservreqchildremovalid in('899d6143-a4dc-42c6-8d88-812eaebfd6d9');


update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-16385',
	update_ts = now()
where removal_id = 251154
	and eligibility_status_cd = '2909'
	and delete_sw  = 'N' ;

update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-16385',
	update_ts = now()
where removal_id = 252013
	and eligibility_status_cd = '2909'
	and delete_sw  = 'N' ;


update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-16385',
	update_ts = now()
where removal_id = 251860
	and eligibility_status_cd = '2909'
	and delete_sw  = 'N' ;


	update tb_client_eligibility
set delete_sw = 'Y',
	update_user_id = 'CDM-16385',
	update_ts = now()
where removal_id = 251928
	and eligibility_status_cd = '2909'
	and delete_sw  = 'N' ;




update cjams.personprogramarea set activeflag =0, updatedby='CDM-16385', updatedon=now()

where personprogramid ='ccc539de-7ae9-4ee3-a9c2-f22ece4cf7d6';

update cjams.personprogramarea set activeflag =0, updatedby='CDM-16385', updatedon=now()

where personprogramid ='c02be002-a375-43bc-b301-a3ad18548385';



update cjams.placement set intakeservreqchildremovalid ='5ebaf7a3-580e-4292-8357-7f3d35a48d49' , updatedby ='CDM-16385', updatedon = now()

where placementid ='4bcd5848-a3f0-48c2-8126-03e8b10368f7' and activeflag =1;













