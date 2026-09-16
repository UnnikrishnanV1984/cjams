CREATE OR REPLACE FUNCTION cjams.getadoptioncaseagreementlist(v_adoptioncaseid uuid, _page integer, _limit integer)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

--------------------------------------------------------------------------------------
-- 03-15 Adoptive Switch missing Provider Info
-- 03-17 To get Adoptive Provider Names
--09-01 - Addded agreementtyperefid for the story CIDM-5203
-- 09/30 - Show rejected records
-- 11/07 - Aurora Issue fix
-- 06/21/2023 Manasa Kasula -- CIDM-7337 Changes to show the person updated by and updated on correctly
--07/13/2023 Umasankar Raavi --CIDM-7128-Fetching document other value
-- 01/09/2024 Sreekanth Marrikanti -- CDM-36282 - Changes to fetch latest adoptioncaseagreementrevision record
--------------------------------------------------------------------------------------

DECLARE                    
_offset    integer;
l_agreementdetails json ;
v_adoptionagreementid uuid;
v_adoptioncaseagreementrevisionid uuid;
v_auditinfo_id uuid;
v_preadoptionclientid uuid;
v_preadoptioncaseid uuid;
v_lastfcpaymentamount numeric;
v_cjamspid  bigint;

BEGIN
_offset  :=  (_page  -  1)  *  _limit;    

select adoptionagreementid 
	into v_adoptionagreementid
from adoptioncaseagreement a where adoptioncaseid = v_adoptioncaseid
	and activeflag = 1 --to filter deleted records
order by insertedon limit 1;

select adoptioncaseagreementrevisionid
		into v_adoptioncaseagreementrevisionid
	from adoptioncaseagreementrevision 
where coalesce(approvalstatustypekey, '') <> '3047' 
	and activeflag = 1
	and adoptioncaseagreementid = v_adoptionagreementid 
	ORDER BY insertedon DESC
	LIMIT 1;
	
	
select adoptioncaseagreementrevisionid into v_auditinfo_id from adoptioncaseagreementrevision 
where adoptioncaseagreementid = v_adoptionagreementid  and switchprovider = true order by updatedon desc;

  RAISE NOTICE 'v_auditinfo_id : %', v_auditinfo_id ;                                                                                                                                                                          
  RAISE NOTICE 'v_adoptionagreementid : %', v_adoptionagreementid ;  


-- Get Child's last foster care placement Payment amount - START
v_lastfcpaymentamount := 2000;

select a_preadoptionclientid, 
	a_preadoptioncaseid
from  cjams.f_get_preadop_info(v_adoptioncaseid) a
	into v_preadoptionclientid,
		v_preadoptioncaseid;
	
IF v_preadoptionclientid is NOT NULL THEN
	select cjamspid 
		into v_cjamspid 
	from person 
	where personid = v_preadoptionclientid 
		and activeflag = 1 ;
		
	select 
		a_lastfcpaymentamount 
	from cjams.f_get_lastfcpaymentamount(v_cjamspid) l
		into v_lastfcpaymentamount;
ELSE
	v_lastfcpaymentamount := 2000;
END IF;	

-- Get Child's last foster care placement rate - END
							 
IF v_adoptioncaseagreementrevisionid IS NOT NULL THEN 	
	SELECT json_agg(f)  INTO l_agreementdetails FROM(								
		SELECT aa.adoptioncaseagreementid as adoptionagreementid,
			null as adoptionplanningid,
			aa.isofferedsubsidy,
			aa.offeraccepteddate,
			aa.finalizationdate,
			aa.isunderappeal,
			aa.startdate,
			aa.enddate,
			aa.parent1signdate,
			aa.parent2signdate, 
			aa.singleparentadoptioncheck,
			aa.parent1providerid, 
			aa.parent2providerid, 
			aa.parent1providername, 
			aa.parent2providername,
			aa.ldssdate,
			aa.issubsidypaid,
			aa.ismedassist,
			aa.adoptiveparent1signature,
			aa.adoptiveparent2signature,
			aa.ldssdirectorsignature,
			aa.agreementcomments,
			aa.switchproviderreason,
			(select  agr.switchprovider from adoptioncaseagreementrevision agr where agr.adoptioncaseagreementrevisionid = v_auditinfo_id  order by updatedon desc limit 1),
			aa.effectiveswitchdate,
			(	SELECT rv.ref_key 
					FROM referencevalues rv 
				WHERE rv.ref_key = aa.childplacedby 
					AND rv.referencetypeid = 901 
					AND rv.activeflag = 1 
				LIMIT 1
			) AS childplacedby,
			(	SELECT tppam.provider_id
				FROM tb_public_provider_application_mapping tppam 
				WHERE tppam.old_provider_id = aa.parent1providerid
					AND DELETE_SW = 'N'
				order by create_ts desc
				limit 1
			) AS provider_id_check,
			(	SELECT rv.ref_key 
					FROM referencevalues rv 
				WHERE rv.ref_key = aa.childplacedfrom 
					AND rv.referencetypeid = 900 
					AND rv.activeflag = 1 
					LIMIT 1
			) AS childplacedfrom,
					(	SELECT rv.ref_key 
					FROM referencevalues rv 
				WHERE rv.ref_key = aa.agreementtyperefid 
					AND rv.referencetypeid = 5465 
					AND rv.activeflag = 1 
					LIMIT 1
			) AS agreementtyperefid,
			(	case when aa.approvalstatustypekey = '3045' then
					'Review'
				 when aa.approvalstatustypekey = '3046' then
					'Rejected'
				 else
					'Incomplete'
				 end 
			) AS routingstatus,
			(	SELECT json_agg(auditinfo) AS auditinfo   
					FROM (select ps.approvalstatus, ps.oldproviderid, ps.newproviderid,ps.approvaldate as approvedon,ps.decisiondate, u2.fullname as approvedby, u.fullname as requestedby,
						(select TRIM(CONCAT_WS('', TBAP1.first_nm, ' ', TBAP1.last_nm))	FROM tb_provider_approval TBA 
                       left join tb_prov_approval_person TBAP1 ON TBAP1.provider_approval_id = TBA.provider_approval_id AND TBAP1.DELETE_SW = 'N' 
                        WHERE TBA.provider_id = ps.oldproviderid::int AND TBA.active_sw = 'Y' AND TBA.DELETE_SW = 'N'and  TBAP1.person_type_cd = '3610'ORDER BY TBA.approval_dt DESC LIMIT 1) as oldprovidername,
						(select TRIM(CONCAT_WS('', TBAP1.first_nm, ' ', TBAP1.last_nm))	FROM tb_provider_approval TBA 
                        left join tb_prov_approval_person TBAP1 ON TBAP1.provider_approval_id = TBA.provider_approval_id AND TBAP1.DELETE_SW = 'N' 
                        WHERE TBA.provider_id = ps.newproviderid::int AND TBA.active_sw = 'Y' AND TBA.DELETE_SW = 'N'and  TBAP1.person_type_cd = '3610'ORDER BY TBA.approval_dt DESC LIMIT 1) as newprovidername
                         from providerswitchinfo ps
                         left join userprofile u2 on u2.securityusersid = ps.approvedby
                         left join userprofile u on u.securityusersid = ps.requestedby
                         where ps.objectid = v_auditinfo_id 
						order by ps.insertedby desc) auditinfo  
			),
			(	SELECT json_agg(doc) AS attachments   
					FROM (  SELECT dp.filename, 
								dp.title,  
								dp.documentpropertiesid, 
								dp.mime,  
								dp.numberofbytes, 
								dp.s3bucketpathname,  
								dp.originalfilename , 
								dp.documentdate,
								dp.actualdocumentdate,
								dp.other,
								(select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),
								dp.updatedon,  
								(select attachmentclassificationtypekey from documentattachment where documentpropertiesid = dp.documentpropertiesid),
								(select attachmentclassificationsubtypekey from documentattachment where documentpropertiesid = dp.documentpropertiesid),
								(select attachmenttypekey from documentattachment where documentpropertiesid = dp.documentpropertiesid),
								dp.uploadstatus,
								dp.finalstatus,
								dp.ecmsdocumentid                                                                                                                                                                                                                          
							from documentproperties dp 
							where dp.objectid = aa.adoptioncaseagreementid and dp.activeflag in (1,3,4,5)
						) doc  
			),
			(	SELECT json_agg (e) 
				FROM (	SELECT agr.adoptionagreementrateid,
							agr.adoptionagreementid, 
							agr.startdate,
							agr.enddate,
							agr.provider_id,
							agr.paymentamout,
							agr.isapproval::integer as isapproval,
							agr.isssaapproved,
							agr.ssaapproveddate,
							agr.approvaldate,
							agr.isspeacialneeds,
							agr.parent1actorid::character varying as parent1actorid, 
							agr.parent2actorid::character varying as parent2actorid, 
							agr.childrelationship,
							agr.notes,
							agr.transactiondate,
							agr.specialneedtypekey,
							agr.status as typedescription
						FROM  adoptioncaseagreementrate agr 
						WHERE agr.activeflag = 1 
							AND agr.adoptionagreementid = aa.adoptioncaseagreementid 
							and (select count(1) 
									from adoptioncaserevision rv
								 where rv.adoptionagreementrateid = agr.adoptionagreementrateid
									and rv.activeflag = 1
									and coalesce(rv.approvalstatustypekey, '') not in ('3046','3047')
								 ) = 0	
						union all	
						SELECT rrv.adoptionagreementrateid,
							rrv.adoptionagreementid, 
							rrv.startdate,
							rrv.enddate,
							rrv.provider_id,
							rrv.paymentamout,
							rrv.isapproval,
							(case when rrv.isssaapproved = 'true' then 1
								when rrv.isssaapproved = 'false' then 2
								else null
							end )::integer as isssaapproved,
							rrv.ssaapproveddate,
							rrv.approvaldate,
							(case when rrv.isspeacialneeds = 'true' then 1
								when rrv.isspeacialneeds = 'false' then 2
								else null
							end )::integer as isspeacialneeds,
							rrv.adoptivemotherid::character varying as parent1actorid, 
							rrv.adoptivefatherid::character varying as parent2actorid, 
							rrv.childrelationship,
							rrv.notes,
							rrv.transactiondate,
							rrv.specialneedtypekey,
							(case when rrv.approvalstatustypekey = '3045' then
								'Review'
							 when rrv.approvalstatustypekey = '3046' then
								'Rejected'
							 else
								'Incomplete'
							 end ) as typedescription
						FROM adoptioncaserevision rrv 
						WHERE rrv.activeflag = 1 
							AND rrv.adoptionagreementid = aa.adoptioncaseagreementid 
							and coalesce(rrv.approvalstatustypekey, '') not in ('3046','3047')
						order by 4 asc	
					) e
		) :: json as agreementrate,
		v_lastfcpaymentamount as lastfcpaymentamount
	FROM adoptioncaseagreementrevision aa
	WHERE aa.adoptioncaseagreementrevisionid = v_adoptioncaseagreementrevisionid  
	and aa.activeflag = 1 
	order by aa.insertedon desc
	LIMIT  _limit  OFFSET  _offset
	)f;
ELSE
	SELECT json_agg(f)  INTO l_agreementdetails FROM(
		SELECT aa.adoptionagreementid,
			null as adoptionplanningid,
			aa.isofferedsubsidy,
			aa.offeraccepteddate,
			aa.finalizationdate,
			aa.isunderappeal,
			aa.startdate,
			aa.enddate,
			aa.parent1signdate,
			aa.parent2signdate, 
			aa.singleparentadoptioncheck,
			aa.parent1providerid,
			aa.parent2providerid,
			aa.parent1providername,
			aa.parent2providername,
			aa.ldssdate,
			aa.issubsidypaid,
			aa.ismedassist,
			aa.adoptiveparent1signature,
			aa.adoptiveparent2signature,
			aa.ldssdirectorsignature,
			aa.agreementcomments,
			aa.switchproviderreason,
			(select  agr.switchprovider from adoptioncaseagreementrevision agr where agr.adoptioncaseagreementrevisionid = v_auditinfo_id  order by updatedon desc limit 1),
			aa.effectiveswitchdate,
			(	SELECT rv.ref_key 
					FROM referencevalues rv 
				WHERE rv.ref_key = aa.childplacedby 
					AND rv.referencetypeid = 901 
					AND rv.activeflag = 1 
				LIMIT 1
			) AS childplacedby,
			(	SELECT tppam.provider_id
				FROM tb_public_provider_application_mapping tppam 
				WHERE tppam.old_provider_id = aa.parent1providerid
					AND DELETE_SW = 'N'
				order by create_ts desc
				limit 1
			) AS provider_id_check,
			(	SELECT rv.ref_key 
					FROM referencevalues rv 
				WHERE rv.ref_key = aa.childplacedfrom 
					AND rv.referencetypeid = 900 
					AND rv.activeflag = 1 
					LIMIT 1
			) AS childplacedfrom,
					(	SELECT rv.ref_key 
					FROM referencevalues rv 
				WHERE rv.ref_key = aa.agreementtyperefid 
					AND rv.referencetypeid = 5465 
					AND rv.activeflag = 1 
					LIMIT 1
			) AS agreementtyperefid,
			(	SELECT rs.typedescription 
					from routing r
						INNER JOIN routingstatustype rs ON r.routingstatustypeid = rs.sequencenumber
				WHERE r.eventcode = 'ASAR' 
					AND r.objectid = aa.adoptionagreementid::character varying 
					AND r.activeflag = 1 
				order by r.insertedon desc 
				LIMIT 1
			) AS routingstatus,
			(	SELECT json_agg(auditinfo) AS auditinfo   
					FROM (
						select ps.approvalstatus, ps.oldproviderid, ps.newproviderid,ps.approvaldate as approvedon,ps.decisiondate, u2.fullname as approvedby, u.fullname as requestedby,
                        (select f_ename('2953', ps.oldproviderid::bigint)) as oldprovidername,
						(select f_ename('2953', ps.newproviderid::bigint)) as newprovidername
                    	 from providerswitchinfo ps
                         left join userprofile u2 on u2.securityusersid = ps.approvedby
                         left join userprofile u on u.securityusersid = ps.requestedby
                         where ps.objectid = v_auditinfo_id
						order by ps.insertedby desc
							) auditinfo  
			),
			(	SELECT json_agg(doc) AS attachments   
					FROM (  SELECT dp.filename, 
								dp.title,  
								dp.documentpropertiesid,
								dp.mime,  
								dp.numberofbytes, 
								dp.s3bucketpathname,  
								dp.originalfilename , 
								dp.documentdate,
								dp.actualdocumentdate, 
								dp.other, 
								(select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),
								dp.updatedon,
							(select attachmentclassificationtypekey from documentattachment where documentpropertiesid = dp.documentpropertiesid),
							(select attachmentclassificationsubtypekey from documentattachment where documentpropertiesid = dp.documentpropertiesid),
							(select attachmenttypekey from documentattachment where documentpropertiesid = dp.documentpropertiesid),
							dp.uploadstatus,
							dp.finalstatus,
							dp.ecmsdocumentid                                                                                                                                                                                                                                 
							from documentproperties dp 
							where dp.objectid = aa.adoptionagreementid and dp.activeflag in (1,3,4,5)
						) doc    
			),
			(	SELECT json_agg (e) 
					FROM (	SELECT agr.adoptionagreementrateid,
							agr.adoptionagreementid, 
							agr.startdate,
							agr.enddate,
							agr.provider_id,
							agr.paymentamout,
							agr.isapproval::integer as isapproval,
							agr.isssaapproved,
							agr.ssaapproveddate,
							agr.approvaldate,
							agr.isspeacialneeds,
							agr.parent1actorid::character varying as parent1actorid, 
							agr.parent2actorid::character varying as parent2actorid, 
							agr.childrelationship,
							agr.notes,
							agr.transactiondate,
							agr.specialneedtypekey,
							agr.status as typedescription
						FROM  adoptioncaseagreementrate agr 
						WHERE agr.activeflag = 1 
							AND agr.adoptionagreementid = aa.adoptionagreementid 
							and (select count(1) 
									from adoptioncaserevision rv
								 where rv.adoptionagreementrateid = agr.adoptionagreementrateid
									and rv.activeflag = 1
									and coalesce(rv.approvalstatustypekey, '') not in ('3047')
								 ) = 0	
						union all	
						SELECT rrv.adoptionagreementrateid,
							rrv.adoptionagreementid, 
							rrv.startdate,
							rrv.enddate,
							rrv.provider_id,
							rrv.paymentamout,
							rrv.isapproval,
							(case when rrv.isssaapproved = 'true' then 1
								when rrv.isssaapproved = 'false' then 2
								else null
							end )::integer as isssaapproved,
							rrv.ssaapproveddate,
							rrv.approvaldate,
							(case when rrv.isspeacialneeds = 'true' then 1
								when rrv.isspeacialneeds = 'false' then 2
								else null
							end )::integer as isspeacialneeds,
							rrv.adoptivemotherid::character varying as parent1actorid, 
							rrv.adoptivefatherid::character varying as parent2actorid, 
							rrv.childrelationship,
							rrv.notes,
							rrv.transactiondate,
							rrv.specialneedtypekey,
							(case when rrv.approvalstatustypekey = '3045' then
								'Review'
							 when rrv.approvalstatustypekey = '3046' then
								'Rejected'
							 else
								'Incomplete'
							 end ) as typedescription
						FROM adoptioncaserevision rrv 
						WHERE rrv.activeflag = 1 
							AND rrv.adoptionagreementid = aa.adoptionagreementid 
							and coalesce(rrv.approvalstatustypekey, '') not in ('3047')
						order by 4 asc	
						) e
			) :: json as agreementrate,
			v_lastfcpaymentamount as lastfcpaymentamount
		FROM adoptioncaseagreement aa 
		WHERE aa.adoptionagreementid = v_adoptionagreementid 
			and aa.activeflag = 1 
		order by insertedon desc
		LIMIT  _limit  OFFSET  _offset
	)f;
END IF;

Return l_agreementdetails;
 
  END;

$function$
;
