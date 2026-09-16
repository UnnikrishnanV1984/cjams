update tb_prov_approval_person
set person_type_cd = 3611 
where first_nm ='REAYANA R'
and provider_approval_id='1885';

update tb_prov_approval_person
set person_type_cd = 3610 
where first_nm ='MOHAMED E'
and provider_approval_id='1885';

update cjams.guardianship gap
set guardianonename = (select 
						concat(tpp.first_nm,' ',coalesce(tpp.middle_nm,''),' ',tpp.last_nm)
						from tb_provider_approval tpa 
						join tb_prov_approval_person tpp 
						on tpp.provider_approval_id = tpa.provider_approval_id
						where provider_id=gap.guardianoneproviderid 
						and (tpp.person_type_cd = '3610')
						order by tpa.entry_dt desc
						limit 1
						)
where old_id is  null;


update cjams.guardianship gap
set guardianoneid = (select 
						tpp.approval_person_id
						from tb_provider_approval tpa 
						join tb_prov_approval_person tpp 
						on tpp.provider_approval_id = tpa.provider_approval_id
						where provider_id=gap.guardianoneproviderid 
						and (tpp.person_type_cd = '3610')
						order by tpa.entry_dt desc
						limit 1
						)
where old_id is  null;



update cjams.guardianship gap
set guardiantwoname = (select 
						concat(tpp.first_nm,' ',coalesce(tpp.middle_nm,''),' ',tpp.last_nm)
						from tb_provider_approval tpa 
						join tb_prov_approval_person tpp 
						on tpp.provider_approval_id = tpa.provider_approval_id
						where provider_id=gap.guardianoneproviderid 
						and (tpp.person_type_cd = '3611')
						order by tpa.entry_dt desc
						limit 1
						)
where old_id is  null;


update cjams.guardianship gap
set guardiantwoid = (select 
						tpp.approval_person_id
						from tb_provider_approval tpa 
						join tb_prov_approval_person tpp 
						on tpp.provider_approval_id = tpa.provider_approval_id
						where provider_id=gap.guardianoneproviderid 
						and (tpp.person_type_cd = '3611')
						order by tpa.entry_dt desc
						limit 1
						)
where old_id is  null;


