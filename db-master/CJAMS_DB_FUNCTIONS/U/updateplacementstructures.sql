CREATE OR REPLACE FUNCTION cjams.updateplacementstructures(v_applicantid character varying, v_prgram character varying, v_prgramtype character varying, v_securityusersid character varying, v_approvedplacementcapacity numeric)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$ 

declare

   v_serviceid numeric;
  v_returnstatus character varying;
  v_structurerecord record;
  v_providerapprovalid uuid;
 v_referralid character varying;
v_personrecord record;
v_ssnno character varying;
v_approvalStatusCd text;
v_recommendCd text;
v_nextrecondate timestamp without time zone;
v_haApprovalStatusCd text;
v_approvalReasonCd text;
v_providerid character varying;
v_provisionally timestamp;

begin
	
v_approvalStatusCd := '3579'; 
v_recommendCd := '3661'; 
v_haApprovalStatusCd := '3047';
v_approvalReasonCd := '4995'; 

SELECT CURRENT_DATE + INTERVAL '365 day' INTO v_nextrecondate;
v_providerid := null;
v_referralid :=  null;



raise notice 'v_applicantid%',v_applicantid;
select provider_id,referral_id  into v_providerid,v_referralid from providerapprovalphaserecord where applicant_id=v_applicantid;
raise notice 'v_providerid%',v_providerid;
if (v_providerid is null) then 
select providerid,referralid into v_providerid,v_referralid from providerapprovetypeconfig where applicantid=v_applicantid;--program type change request table
end if;
--IF provisionally approved, inserting provisionally approved approvaltype
select provisionstrtdate into v_provisionally from tb_public_provider_applicant where provisionstrtdate is not null and application_status like '%Provisionally%' and applicant_id=v_applicantid;
raise notice 'v_provisionally%',v_provisionally;
if (v_provisionally is not null)then 
raise notice 'inside provisionally%','inside provisionally';
INSERT INTO tb_provider_approval
	( provider_id, approval_type_cd, approval_status_cd, recommend_cd, approved_beds_no, approval_dt,
	  effective_dt, next_recon_dt, ha_approval_status_cd, ha_approval_dt, approval_reason_cd,
	  create_ts, create_user_id, update_ts, update_user_id, delete_sw, active_sw, providerapprovalid )
VALUES
	( (v_providerid)::int, '4991', v_approvalStatusCd, v_recommendCd, v_approvedPlacementCapacity, now()::date,
	  now()::date, v_nextrecondate, v_haApprovalStatusCd, now()::date, v_approvalReasonCd,
	  now()::date, v_securityusersid, now()::date, v_securityusersid, 'N'::bpchar,'Y'::bpchar, gen_random_uuid() );

end if;
v_serviceid := null;
  IF (v_providerid is not null) then
    if (v_prgramtype = 'Formal') then 
      v_serviceid := 8;
    end if;
    if (v_prgramtype = 'Regular Resource Home') then 
      v_serviceid := 10;
    end if;
     if (v_prgramtype = 'Restricted Home') then 
      v_serviceid := 9;
    end if;
     if (v_prgramtype = 'Treatment Resource Home') then 
      v_serviceid := 12;
    end if;
   if (v_serviceid is not null) then 
   insert into tb_provider_services (provider_id, 
service_id,start_dt, service_status,
create_ts,create_user_id)
values
(v_providerid::bigint,v_serviceid,now()::date , 'Active',
now()::timestamp,v_securityusersid);
end if;
for v_structurerecord in 
select tsc.approvaltypecd from tb_provider_services tps 
inner join providerapprovalserviceconfig tsc on tsc.serviceid::integer=tps.service_id
where tps.provider_id=v_providerid::bigint
loop 
v_providerapprovalid := gen_random_uuid();
INSERT INTO tb_provider_approval
	( provider_id, approval_type_cd, approval_status_cd, recommend_cd, approved_beds_no, approval_dt,
	  effective_dt, next_recon_dt, ha_approval_status_cd, ha_approval_dt, approval_reason_cd,
	  create_ts, create_user_id, update_ts, update_user_id, delete_sw, active_sw, providerapprovalid )
VALUES
	( (v_providerid)::int, v_structurerecord.approvaltypecd, v_approvalStatusCd, v_recommendCd, v_approvedPlacementCapacity, now()::date,
	  now()::date, v_nextrecondate, v_haApprovalStatusCd, now()::date, v_approvalReasonCd,
	  now()::date, v_securityusersid, now()::date, v_securityusersid, 'N'::bpchar,'Y'::bpchar, v_providerApprovalId );

--select referral_id into v_referralid  from providerapprovalphaserecord where provider_id=v_providerid;
for v_personrecord in 
select ia.personid,p.firstname,p.lastname,ia.intakeservicerequestpersontypekey,p.prefx,p.suffix,p.dob,p.gendertypekey,
p.ssnno,p.religiontypekey,p.maritalstatustypekey from intakeservicerequestactor ia
inner join person p on p.personid= ia.personid
where ia.intakenumber=v_referralid and ia.activeflag=1 and p.activeflag=1
loop
v_ssnno := null;
if (v_personrecord.ssnno ~ '^[0-9\.]+$') then 
v_ssnno := v_personrecord.ssnno;
end if;
insert into provapprovalperson(approvalpersonid,providerapprovalid,persontypekey,firstname,lastname,prefixkey,
suffixkey,dobdate,genderkey,ssnno,religionkey,maritalstatuskey)
values(v_personrecord.personid,v_providerapprovalid,v_personrecord.intakeservicerequestpersontypekey,v_personrecord.firstname
,v_personrecord.lastname,v_personrecord.prefx,v_personrecord.suffix,v_personrecord.dob,v_personrecord.gendertypekey,
v_ssnno::numeric,v_personrecord.religiontypekey,v_personrecord.maritalstatustypekey);
end loop;
end loop;
   
  v_returnstatus := 'structure updated';
 else 
  v_returnstatus := 'Failure';
  END IF;


RETURN v_returnstatus;
                                                      
END;

$function$;
