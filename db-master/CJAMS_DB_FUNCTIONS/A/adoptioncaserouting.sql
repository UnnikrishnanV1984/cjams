CREATE OR REPLACE FUNCTION cjams.adoptioncaserouting(v_adoptioncaseid uuid, v_objectid uuid, v_securityuserid character varying, appeventcode character varying, v_status integer)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$

-----------------------------------------------------------------

-- CIDM - 4203 03-07-2022 Veera Updating approval date for adoption agreement table
-- CIDM-3920 = 04-11-2022 -VN - Revision Record with active flag 1
-- CDM-25225 - switchproviderreason approval issue fix 09/20
-- CDM-25395 - switchproviderreason & effectiveswitchdate column fix for Reject status 09/29
-- To Remove Annual Review Rejected Records - Veera Nadimpalli
-- CIDM-8892- 06/20/2024 -- Updated start date in adoptioncase table.
-- 07/23/2024 - Vineet Tirodkar - Modifications for not to update the adoptioncase startdate on Rate approval (CDM-40364)
---------------------------------------------------------------------------
DECLARE
 	v_case_county_id uuid;
 	v_fromroleid character varying;
	v_toroleid character varying;
	v_tosecurityusersid character varying;
	v_teamid uuid;
	v_routingid uuid;
	v_revisionid uuid;
	v_adoptioncasenumber character varying;
	v_notifymsg character varying;

	v_cnt integer;
	v_row_cnt integer;
	v_new_revisionid uuid;

	v_effectiveswitchdate timestamp;
	v_max_rate_id uuid; 
	v_rate_app_status varchar;
	v_rate_end_date timestamp;
	v_oldproviderid int;
	v_adoptiveparentsinfo json;
	i json;

BEGIN
	
	RAISE  NOTICE  '  appeventcode  %', appeventcode;
	RAISE  NOTICE  '  v_objectid  %', v_objectid;

	--get Adoption Case Number
	select adoptioncasenumber into v_adoptioncasenumber from adoptioncase s where adoptioncaseid = v_adoptioncaseid; 

	--get Case county id
	select c.countyid into v_case_county_id 
		from caseassignment ca 
			join team t on t.teamid = ca.fromteamid and t.activeflag=1
			join county c on c.countyid :: character varying = t.countyid and c.activeflag =1
	where ca.objectid = v_adoptioncaseid 
		and ca.activeflag = 1 
		and lower(ca.responsibilitytypekey) = 'family'
        order by ca.insertedon desc
        limit 1;
	
	--get Supervisor ID; worker role into from_role
	select supervisorid, roletypekey, teamid
			into v_tosecurityusersid, v_fromroleid, v_teamid
		from v_userprofile vu 
	where securityusersid = v_securityuserid;
		--and countyid = v_case_county_id;

	--set Supervisor role into to_role
	select roletypekey
		into v_toroleid
	from v_userprofile vu 
		where securityusersid = v_tosecurityusersid;


	RAISE NOTICE '  v_case_county_id  %', v_case_county_id;
	RAISE NOTICE '  v_securityuserid  %', v_securityuserid;
	RAISE NOTICE '  v_tosecurityusersid  %', v_tosecurityusersid;
	RAISE NOTICE '  v_fromroleid  %', v_fromroleid;
	RAISE NOTICE '  v_toroleid  %', v_toroleid;

	IF (appeventcode='ASAR') THEN -- Adoption Subsidy Agreement Review
		--get most recent un-approved revisionid	
		SELECT adoptioncaseagreementrevisionid into v_revisionid
			FROM adoptioncaseagreementrevision
		WHERE adoptioncaseagreementid = v_objectid 
			AND (
					(v_status = 15 and coalesce(approvalstatustypekey,'') <> '3047')  
					OR
					(v_status in (16, 17) and coalesce(approvalstatustypekey,'') = '3045')
				)
			AND activeflag = 1 
		ORDER BY insertedon 
		DESC LIMIT 1;

		IF v_revisionid is NOT NULL THEN

			if v_status = 15 then -- Review
				--create review record
	 			INSERT INTO routing (
						eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
						fromroleid, toroleid, objectid, routingstatustypeid, activeflag,
						insertedby, updatedby, insertedon, updatedon, isreviewrequest,
						servicerequestnumber, remarks, routeddescription )
				VALUES (appeventcode, v_securityuserid, v_tosecurityusersid, v_teamid, 
						v_fromroleid, v_toroleid, v_objectid, v_status, 1,
						v_securityuserid, v_securityuserid, now(), now(), true, 
						v_adoptioncasenumber, 'Adoption Agreement Submitted for Review', 'Adoption Agreement Submitted for Review');
							
			    UPDATE 	providerswitchinfo 
					SET approvedby = v_tosecurityusersid, 
						updatedby = v_securityuserid, 
						updatedon = now() 
				WHERE objectid = v_revisionid and activeflag = 1;			
				
				
				--update revision record status as Review
				UPDATE 	adoptioncaseagreementrevision 
					SET approvalstatustypekey = '3045', 
						updatedby = v_securityuserid, 
						updatedon = now() 
				WHERE adoptioncaseagreementrevisionid = v_revisionid;

			elsif v_status = 16 then -- Approved

			     	--update revision record status as Review
				UPDATE 	adoptioncaseagreementrevision 
					SET activeflag = 0, 
						updatedby = v_securityuserid, 
						updatedon = now() 
				WHERE adoptioncaseagreementrevisionid = v_revisionid and activeflag = 1 and approvalstatustypekey = '3045' ;


				--generate new adoptioncaseagreementrevisionid
                select gen_random_uuid() into v_new_revisionid ;       

				--create agreement revision
				INSERT INTO cjams.adoptioncaseagreementrevision
						(adoptioncaseagreementrevisionid, adoptioncaseagreementid, isofferedsubsidy, offeraccepteddate, startdate, enddate, 
						finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, activeflag, effectivedate, 
						insertedby, insertedon, updatedby, updatedon, old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, 
						agreementcomments, childplacedby, childplacedfrom,agreementtyperefid, providerid, adoptiveparent1id, adoptiveparent2id, approvalstatustypekey, approvaldate, switchproviderreason, effectiveswitchdate)
				SELECT 	v_new_revisionid, adoptioncaseagreementid, isofferedsubsidy, offeraccepteddate, startdate, enddate, 
						finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, 1, effectivedate, 
						v_securityuserid, now(), v_securityuserid, now(), old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, 
						agreementcomments, childplacedby, childplacedfrom,agreementtyperefid, providerid, adoptiveparent1id, adoptiveparent2id, '3047', now(), switchproviderreason, effectiveswitchdate
				FROM adoptioncaseagreementrevision 
				WHERE adoptioncaseagreementrevisionid = v_revisionid 
				ORDER BY insertedon DESC LIMIT 1;

				 UPDATE providerswitchinfo SET approvedby = v_securityuserid, 
					   approvaldate =  now(),
					   approvalstatus = 'Approved',
					   updatedby = v_securityuserid, 
					   updatedon = now() 
				WHERE objectid = v_revisionid and activeflag = 1;	

				GET DIAGNOSTICS v_row_cnt = ROW_COUNT;

				if coalesce(v_row_cnt, 0) > 0 then
					--de-activate revision review record 
					UPDATE 	adoptioncaseagreementrevision 
					SET activeflag = 0, 
						updatedby = v_securityuserid, 
						updatedon = now()
					WHERE adoptioncaseagreementrevisionid = v_revisionid;

				end if;

				SELECT routingid into v_routingid
					FROM routing
				WHERE objectid = v_objectid::character varying 
					and eventcode = appeventcode
					AND routingstatustypeid = 15 
					and activeflag = 1 
				ORDER BY insertedon DESC LIMIT 1;

				--update routing with approval record
				INSERT INTO routing (
						eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
						fromroleid, toroleid, objectid , routingstatustypeid, activeflag,
						insertedby,  updatedby, insertedon, updatedon, isreviewrequest,
						servicerequestnumber,remarks,routeddescription )
				SELECT  appeventcode, R.tosecurityusersid, R.fromsecurityusersid, R.teamid, 
						R.toroleid, R.fromroleid, v_objectid, 16, 1,
						R.insertedby, R.updatedby, now(), now(), R.isreviewrequest,
						v_adoptioncasenumber, 'Adoption Agreement Approved', 'Adoption Agreement Approved' 
				FROM routing as R 
				WHERE R.routingid = v_routingid;

				GET DIAGNOSTICS v_row_cnt = ROW_COUNT;

				if coalesce(v_row_cnt, 0) > 0 then
					--de-activate routing review record 
					UPDATE 	routing 
					SET activeflag = 0,
						updatedby = v_securityuserid, 
						updatedon = now()
					--WHERE routingid = v_routingid;
					WHERE objectid = v_objectid::character varying 
						and eventcode = appeventcode
						AND routingstatustypeid = 15 
						and activeflag = 1;

				end if;
				
				-- Update or Insert adoptioncaseagreement
				select count(1) 
					into v_cnt
				from adoptioncaseagreement
				where adoptionagreementid = v_objectid
					and activeflag = 1 ;
				
				IF coalesce(v_cnt, 0) > 0 THEN
					-- Update
					UPDATE 	adoptioncaseagreement a
					SET 	adoptionagreementid = aa.adoptioncaseagreementid, 
							isofferedsubsidy = aa.isofferedsubsidy, offeraccepteddate = aa.offeraccepteddate, startdate = aa.startdate, enddate = aa.enddate, 
							finalizationdate = aa.finalizationdate, isunderappeal = aa.isunderappeal, parent1signdate = aa.parent1signdate, parent2signdate = aa.parent2signdate, 
							ldssdate = aa.ldssdate, issubsidypaid = aa.issubsidypaid, activeflag = 1, effectivedate = aa.effectivedate, 
							insertedby = v_securityuserid, insertedon = now(), updatedby = v_securityuserid, updatedon = now(), old_id = aa.old_id, ismedassist = aa.ismedassist, 
							parent1providerid = aa.parent1providerid, parent2providerid = aa.parent2providerid, parent1providername = aa.parent1providername, parent2providername = aa.parent2providername, 
							issingleparent = aa.issingleparent, singleparentadoptioncheck = aa.singleparentadoptioncheck, adoptiveparent1signature = aa.adoptiveparent1signature, 
							adoptiveparent2signature = aa.adoptiveparent2signature, ldssdirectorsignature = aa.ldssdirectorsignature, 
							agreementcomments = aa.agreementcomments, childplacedby = aa.childplacedby, childplacedfrom = aa.childplacedfrom, agreementtyperefid = aa.agreementtyperefid,  providerid = aa.providerid, 
							adoptiveparent1id = aa.adoptiveparent1id, adoptiveparent2id = aa.adoptiveparent2id, 
							switchproviderreason = aa.switchproviderreason, effectiveswitchdate = aa.effectiveswitchdate
					FROM adoptioncaseagreementrevision aa
					WHERE a.adoptionagreementid = aa.adoptioncaseagreementid
					AND aa.adoptioncaseagreementrevisionid = v_new_revisionid ;
				ELSE
					-- Insert
					INSERT INTO cjams.adoptioncaseagreement
							(adoptionagreementid, adoptioncaseid, isofferedsubsidy, offeraccepteddate, startdate, enddate, 
							finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, activeflag, effectivedate, 
							insertedby, insertedon, updatedby, updatedon, old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, 
							issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, 
							agreementcomments, childplacedby, childplacedfrom, providerid, adoptiveparent1id, adoptiveparent2id, switchproviderreason, effectiveswitchdate)
					SELECT 	adoptioncaseagreementid, v_adoptioncaseid, isofferedsubsidy, offeraccepteddate, startdate, enddate, 
							finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, 1, effectivedate, 
							v_securityuserid, now(), v_securityuserid, now(), old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, 
							issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, 
							agreementcomments, childplacedby, childplacedfrom, agreementtyperefid, providerid, adoptiveparent1id, adoptiveparent2id, switchproviderreason, effectiveswitchdate
					FROM cjams.adoptioncaseagreementrevision WHERE adoptioncaseagreementrevisionid = v_new_revisionid ;

				END IF;

				-- Update startdate and enddate in adoptioncase
				UPDATE 	adoptioncase a
				SET startdate = aa.startdate,
					enddate = aa.enddate, 
					updatedby = v_securityuserid, 
					updatedon = now()
				FROM adoptioncaseagreementrevision aa
				WHERE a.adoptioncaseid = v_adoptioncaseid
				  AND aa.adoptioncaseagreementrevisionid = v_new_revisionid ;
			
			
				-- Adoption Rate End date logic
				-- Get effectective End date
				select effectiveswitchdate
					into v_effectiveswitchdate
				from adoptioncaseagreementrevision
				where adoptioncaseagreementrevisionid = v_revisionid;
				
				IF v_effectiveswitchdate is not null then
					-- Get most recent Rate End ddate 
					select adoptionagreementrateid, status, enddate  
						into v_max_rate_id, v_rate_app_status, v_rate_end_date 
					from adoptioncaseagreementrate 
					where adoptionagreementid = v_objectid
						and activeflag  = 1
					order by insertedon desc
					Limit 1 ;
				
					IF btrim(lower(v_rate_app_status)) = 'approved' AND v_rate_end_date > v_effectiveswitchdate THEN
						-- Update Rate End date & trigger under over
						update adoptioncaseagreementrate
							set enddate = v_effectiveswitchdate,
							    approvaldate = now(),
								updatedon = now(), -- to trigger under over
								updatedby = v_securityuserid
						where adoptionagreementrateid = v_max_rate_id ;
					end if;	
				END IF;
				
			elsif v_status = 17 then -- Reject
				--generate new adoptioncaseagreementrevisionid
                select gen_random_uuid() into v_new_revisionid ;  

				select effectiveswitchdate into v_effectiveswitchdate
				from adoptioncaseagreementrevision
				where adoptioncaseagreementrevisionid = v_revisionid;

				--create agreement revision
				INSERT INTO cjams.adoptioncaseagreementrevision
						(adoptioncaseagreementrevisionid, adoptioncaseagreementid, isofferedsubsidy, offeraccepteddate, startdate, enddate, 
						finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, activeflag, effectivedate, 
						insertedby, insertedon, updatedby, updatedon, old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, 
						agreementcomments, childplacedby, childplacedfrom, agreementtyperefid, providerid, adoptiveparent1id, adoptiveparent2id, approvalstatustypekey, approvaldate)
				SELECT 	v_new_revisionid, adoptioncaseagreementid, isofferedsubsidy, offeraccepteddate, startdate, enddate, 
						finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, 1, effectivedate, 
						v_securityuserid, now(), v_securityuserid, now(), old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, 
						agreementcomments, childplacedby, childplacedfrom,agreementtyperefid, providerid, adoptiveparent1id, adoptiveparent2id, '3046', now()
				FROM adoptioncaseagreementrevision 
				WHERE adoptioncaseagreementrevisionid = v_revisionid 
				ORDER BY insertedon DESC LIMIT 1;

				select oldproviderid into v_oldproviderid  from providerswitchinfo 
				WHERE objectid = v_revisionid and activeflag = 1 and approvalstatus = 'Review';

				if v_effectiveswitchdate is not null and v_oldproviderid is not null then 

					select * into v_adoptiveparentsinfo from getadoptiveparents(v_oldproviderid::varchar);

					for i in select * from json_array_elements(v_adoptiveparentsinfo) 
					loop 
					UPDATE adoptioncaseagreementrevision g SET parent1providerid = (i ->> 'providerid')::int, parent2providerid = (i ->> 'provider2id')::int ,
									adoptiveparent1id = (i ->> 'adoptiveparent1id')::varchar, parent1providername = (i ->> 'adoptiveparent1')::int,
									adoptiveparent2id = (i ->> 'adoptiveparent2id')::varchar, parent2providername = (i ->> 'adoptiveparent2')::int,
									effectiveswitchdate = null, updatedby = v_securityuserid, updatedon = now() 
					where adoptioncaseagreementrevisionid = v_new_revisionid  and activeflag = 1;
					End Loop;

				End IF;

				UPDATE providerswitchinfo SET approvedby = v_securityuserid, 
					   approvaldate =  now(),
					   approvalstatus = 'Rejected',
					   updatedby = v_securityuserid, 
					   updatedon = now() 
				WHERE objectid = v_revisionid and activeflag = 1;	

				GET DIAGNOSTICS v_row_cnt = ROW_COUNT;

				if coalesce(v_row_cnt, 0) > 0 then
					--de-activate revision review record 
					UPDATE 	adoptioncaseagreementrevision 
					SET activeflag = 0, 
						updatedby = v_securityuserid, 
						updatedon = now()
					WHERE adoptioncaseagreementrevisionid = v_revisionid;

				end if;

				SELECT routingid into v_routingid
					FROM routing
				WHERE objectid = v_objectid::character varying 
					and eventcode = appeventcode
					AND routingstatustypeid = 15 
					and activeflag = 1 
				ORDER BY insertedon DESC LIMIT 1;

				--update routing with rejection record
				INSERT INTO routing (
						eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
						fromroleid, toroleid, objectid , routingstatustypeid, activeflag,
						insertedby,  updatedby, insertedon, updatedon, isreviewrequest,
						servicerequestnumber,remarks,routeddescription )
				SELECT  appeventcode, R.tosecurityusersid, R.fromsecurityusersid, R.teamid, 
						R.toroleid, R.fromroleid, v_objectid, 17, 1,
						R.insertedby, R.updatedby, now(), now(), R.isreviewrequest,
						v_adoptioncasenumber, 'Adoption Agreement Rejected', 'Adoption Agreement Rejected' 
				FROM routing as R 
				WHERE R.routingid = v_routingid;
					
				GET DIAGNOSTICS v_row_cnt = ROW_COUNT;

				if coalesce(v_row_cnt, 0) > 0 then
					--de-activate routing review record 
					UPDATE 	routing 
					SET activeflag = 0, 
						updatedby = v_securityuserid, 
						updatedon = now() 
					WHERE routingid = v_routingid;

				end if;
	
			end if;
		ELSE
			RETURN  'Agreement Revision record not found!';
		END IF;

	ELSIF (appeventcode='ADSR') THEN -- Adoption Suspension Review

	 	if v_routingstatustypeid = 16 then -- Approved
			update 	adoptionsuspensionrevision set approvalstatustypekey = '3047', approvaldate = now()::date 
	 		where 	adoptionsuspensionid = v_objectid ;
			
			update 	adoptionsuspension set approvalstatustypekey = '3047', updatedon = now(), approvaldate = now()::date
	 		where 	adoptionsuspensionid = v_objectid ;
  		end if;

	ELSIF (appeventcode = 'AARR' ) THEN -- Adoption Agreement Rate Review
		
		--generate new adoptioncaseagreementraterevisionid
        select gen_random_uuid() into v_new_revisionid ; 

		--get most recent un-approved revisionid	
		SELECT adoptionrevisionid into v_revisionid
			FROM adoptioncaserevision
		WHERE adoptionagreementrateid = v_objectid 
			AND (
					(v_status = 15 and coalesce(approvalstatustypekey,'') <> '3047')  
					OR
					(v_status in (16, 17) and coalesce(approvalstatustypekey,'') = '3045')
				)
			AND activeflag = 1 
		ORDER BY insertedon 
		DESC LIMIT 1;

		IF v_revisionid is NOT NULL THEN
			if v_status = 15 then -- Review
				
				INSERT INTO routing (
						eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
						fromroleid, toroleid, objectid, routingstatustypeid, activeflag,
						insertedby, updatedby, insertedon, updatedon, isreviewrequest,
						servicerequestnumber, remarks, routeddescription )
				VALUES (appeventcode, v_securityuserid, v_tosecurityusersid, v_teamid, 
						v_fromroleid, v_toroleid, v_objectid, v_status, 1,
						v_securityuserid, v_securityuserid, now(), now(), true, 
						v_adoptioncasenumber, 'Adoption Agreement Rate Submitted for Review', 'Adoption Agreement Rate Submitted for Review');

				--update revision record status as Review
				UPDATE 	adoptioncaserevision 
					SET approvalstatustypekey = '3045', 
						updatedby = v_securityuserid, 
						updatedon = now() 
				WHERE adoptionrevisionid = v_revisionid;
				
			elsif v_status = 16 then -- Approved

				--create rate revision
				INSERT INTO cjams.adoptioncaserevision 
						(adoptionrevisionid, adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
						provider_id, paymentamout, isssaapproved, ssaapproveddate, isspeacialneeds,
						parent1providername, parent2providername, childrelationship, notes, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
						old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, approvalstatustypekey, approvaldate, isoriginal)
				SELECT  v_new_revisionid, adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
						provider_id, paymentamout, isssaapproved, ssaapproveddate, isspeacialneeds,
						parent1providername, parent2providername, childrelationship, notes, 1, effectivedate, v_securityuserid, now(), v_securityuserid, now(), 
						old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, 'Approved', '3047', now(), isoriginal
				FROM adoptioncaserevision 
				WHERE adoptionrevisionid = v_revisionid 
				AND activeflag = 1;

				-- Commented with CDM-40364 (Code revert of CIDM-8892)
				/*
			    --Update adoptioncase table with start date.
				UPDATE adoptioncase a 
				   SET startdate = aa.startdate ,
				       updatedby =v_securityuserid,
				       updatedon =now()
                FROM adoptioncaserevision aa
				WHERE aa.adoptionrevisionid = v_revisionid 
			         AND a.adoptioncaseid =v_adoptioncaseid;
				*/
				
				GET DIAGNOSTICS v_row_cnt = ROW_COUNT;

				if coalesce(v_row_cnt, 0) > 0 then
					--de-activate revision review record 
					UPDATE 	adoptioncaserevision 
					SET activeflag = 0, 
						updatedby = v_securityuserid, 
						updatedon = now() 
					WHERE adoptionrevisionid = v_revisionid;
				
				end if;

				SELECT routingid into v_routingid
					FROM routing
				WHERE objectid = v_objectid :: character varying 
					AND eventcode = appeventcode
					AND routingstatustypeid = 15 
					AND activeflag = 1 
				ORDER BY insertedon DESC LIMIT 1;

				--update routing with approval record
				INSERT INTO routing (
						eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
						fromroleid, toroleid, objectid , routingstatustypeid, activeflag,
						insertedby,  updatedby, insertedon, updatedon, isreviewrequest,
						servicerequestnumber,remarks,routeddescription )
				SELECT  appeventcode, R.tosecurityusersid, R.fromsecurityusersid, R.teamid, 
						R.toroleid, R.fromroleid, v_objectid, v_status, 1,
						R.insertedby, R.updatedby, now(), now(), R.isreviewrequest, 
						v_adoptioncasenumber, 'Adoption Agreement Rate Approved', 'Adoption Agreement Rate Approved' 
				FROM routing as R 
				WHERE R.routingid = v_routingid;

				GET DIAGNOSTICS v_row_cnt = ROW_COUNT;

				if coalesce(v_row_cnt, 0) > 0 then
					--de-activate routing review record 
					UPDATE 	routing 
					SET activeflag = 0, 
						updatedby = v_securityuserid, 
						updatedon = now() 
					WHERE routingid = v_routingid;
				
				end if;
				
				-- Update or Insert adoptioncaseagreementrate
				select count(1) 
					into v_cnt
				from adoptioncaseagreementrate
				where adoptionagreementrateid = v_objectid
					and activeflag = 1 ;
				
				IF coalesce(v_cnt, 0) > 0 THEN
					-- Update
					UPDATE 	adoptioncaseagreementrate r
					SET 	adoptionagreementrateid = rrv.adoptionagreementrateid, adoptionagreementid = rrv.adoptionagreementid, startdate = rrv.startdate, enddate = rrv.enddate, 
							provider_id = rrv.provider_id, paymentamout = rrv.paymentamout, 
							isssaapproved = (case when rrv.isssaapproved = 'true' then 1
													when rrv.isssaapproved = 'false' then 2
													else null
												end )::integer,  
							isspeacialneeds = (case when rrv.isspeacialneeds = 'true' then 1
													when rrv.isspeacialneeds = 'false' then 2
													else null
												end )::integer, ssaapproveddate = rrv.ssaapproveddate,
							childrelationship = rrv.childrelationship, notes = rrv.notes, activeflag = 1, effectivedate = rrv.effectivedate, 
							insertedby = v_securityuserid, insertedon = now(), updatedby = v_securityuserid, updatedon = now(), approvaldate = rrv.approvaldate,
							old_id = rrv.old_id, specialneedtypekey = rrv.specialneedtypekey, specialneedremarks = rrv.specialneedremarks, transactiondate = rrv.transactiondate, 
							rateoverwrittensw = rrv.rateoverwrittensw, status = 'Approved'
					FROM adoptioncaserevision rrv
					WHERE r.adoptionagreementrateid = rrv.adoptionagreementrateid 
					AND rrv.adoptionrevisionid = v_new_revisionid ;
				ELSE
					-- Insert
					INSERT INTO cjams.adoptioncaseagreementrate
							(adoptionagreementrateid, adoptionagreementid, startdate, enddate, provider_id, paymentamout, 
							isssaapproved, 
							isspeacialneeds, ssaapproveddate, 
							childrelationship, notes, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, approvaldate,
							old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status)
					SELECT 	adoptionagreementrateid, adoptionagreementid, startdate, enddate, provider_id, paymentamout, 
							(case when isssaapproved = 'true' then 1
								when isssaapproved = 'false' then 2
								else null
							end )::integer, 
							(case when isspeacialneeds = 'true' then 1
								when isspeacialneeds = 'false' then 2
								else null
							end )::integer, ssaapproveddate, 
							childrelationship, notes, 1, effectivedate, v_securityuserid, now(), v_securityuserid, now(), approvaldate,
							old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, 'Approved'
					FROM cjams.adoptioncaserevision WHERE adoptionrevisionid = v_new_revisionid ;
					
				END IF;
				
			elsif v_status = 17 then -- Reject
				
				--create rate revision
				INSERT INTO cjams.adoptioncaserevision 
						(adoptionrevisionid, adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
						provider_id, paymentamout, isssaapproved, ssaapproveddate, isspeacialneeds,
						parent1providername, parent2providername, childrelationship, notes, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
						old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, approvalstatustypekey, approvaldate, isoriginal)
				SELECT  v_new_revisionid, adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
						provider_id, paymentamout, isssaapproved, ssaapproveddate, isspeacialneeds,
						parent1providername, parent2providername, childrelationship, notes, 1, effectivedate, v_securityuserid, now(), v_securityuserid, now(), 
						old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, 'Rejected', '3046', now(), isoriginal
				FROM adoptioncaserevision 
				WHERE adoptionrevisionid = v_revisionid 
				AND activeflag = 1;

				GET DIAGNOSTICS v_row_cnt = ROW_COUNT;

				if coalesce(v_row_cnt, 0) > 0 then
					--de-activate revision review record 
					UPDATE 	adoptioncaserevision 
					SET activeflag = 0, 
						updatedby = v_securityuserid, 
						updatedon = now() 
					WHERE adoptionrevisionid = v_revisionid;

				end if;

				SELECT routingid into v_routingid
					FROM routing
				WHERE objectid = v_objectid :: character varying 
					and eventcode = appeventcode
					AND routingstatustypeid = 15 
					and activeflag = 1 
				ORDER BY insertedon DESC LIMIT 1;

				--update routing with rejection record
				INSERT INTO routing (
						eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
						fromroleid, toroleid, objectid , routingstatustypeid, activeflag,
						insertedby,  updatedby, insertedon, updatedon, isreviewrequest,
						servicerequestnumber,remarks,routeddescription )
				SELECT  appeventcode, R.tosecurityusersid, R.fromsecurityusersid, R.teamid, 
						R.toroleid, R.fromroleid, v_objectid, v_status, 1,
						R.insertedby, R.updatedby, now(), now(), R.isreviewrequest, 
						v_adoptioncasenumber, 'Adoption Agreement Rate Rejected', 'Adoption Agreement Rate Rejected' 
				FROM routing as R 
				WHERE R.routingid = v_routingid;

				GET DIAGNOSTICS v_row_cnt = ROW_COUNT;

				if coalesce(v_row_cnt, 0) > 0 then
					--de-activate routing review record 
					UPDATE 	routing 
					SET activeflag = 0, 
						updatedby = v_securityuserid, 
						updatedon = now() 
					WHERE routingid = v_routingid;

				end if;
				
			end if;	
		ELSE
			RETURN  'Agreement Rate Revision record not found!';
		END IF;	
	
	ELSIF (appeventcode='ADYR') THEN -- Adoption Annual Review
		if v_status = 15 then -- Review
			-- Deactivating the existing routing record.
			UPDATE 	routing SET activeflag = 0,
					updatedby = v_securityuserid, 
					updatedon = now()
			WHERE objectid = v_objectid::character varying 
					and eventcode = appeventcode
					AND routingstatustypeid = 15
					and activeflag = 1;

			--create review record
 			INSERT INTO routing (
					eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
					fromroleid, toroleid, objectid, routingstatustypeid, activeflag,
					insertedby, updatedby, insertedon, updatedon, isreviewrequest,
					servicerequestnumber, remarks, routeddescription )
			VALUES (appeventcode, v_securityuserid, v_tosecurityusersid, v_teamid, 
					v_fromroleid, v_toroleid, v_objectid, v_status, 1,
					v_securityuserid, v_securityuserid, now(), now(), true, 
					v_adoptioncasenumber, 'Adoption Annual Review Submitted for Review', 'Adoption Annual Review Submitted for Review');

			SELECT send_notification into v_notifymsg FROM send_notification(
					v_tosecurityusersid :: character varying,
					v_securityuserid :: character varying,
					v_tosecurityusersid :: character varying,
					'System' :: character varying,
					'High' :: character varying,
					'Adoption Annual Review Submitted for Review' :: character varying,
					'Adoption Annual Review Submitted for Review' :: character varying,
					v_objectid :: character varying);
		
		elsif v_status = 16 then -- Approved
			
			SELECT routingid into v_routingid
				FROM routing
			WHERE objectid = v_objectid::character varying 
				and eventcode = appeventcode
			    AND routingstatustypeid = 15 
				and activeflag = 1 
			ORDER BY insertedon DESC LIMIT 1;

			--update routing with approval record
			INSERT INTO routing (
					eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
					fromroleid, toroleid, objectid , routingstatustypeid, activeflag,
					insertedby,  updatedby, insertedon, updatedon, isreviewrequest,
					servicerequestnumber,remarks,routeddescription )
			SELECT  appeventcode, R.tosecurityusersid, R.fromsecurityusersid, R.teamid, 
					R.toroleid, R.fromroleid, v_objectid, 16, 1,
					R.insertedby, R.updatedby, now(), now(), R.isreviewrequest,
					v_adoptioncasenumber, 'Adoption Annual Review Approved', 'Adoption Annual Review Approved' 
			FROM routing as R 
			WHERE R.routingid = v_routingid;

			GET DIAGNOSTICS v_row_cnt = ROW_COUNT;

			
			if coalesce(v_row_cnt, 0) > 0 then
				--de-activate routing review record 
				UPDATE 	routing 
				SET activeflag = 0,
					updatedby = v_securityuserid, 
					updatedon = now()
				--WHERE routingid = v_routingid;
				WHERE objectid = v_objectid::character varying 
					and eventcode = appeventcode
					AND routingstatustypeid in ( 15 , 17)
					and activeflag = 1;

			end if;

		elsif v_status = 17 then -- Reject

			SELECT routingid into v_routingid
				FROM routing
			WHERE objectid = v_objectid::character varying 
				and eventcode = appeventcode
				AND routingstatustypeid = 15 
				and activeflag = 1 
			ORDER BY insertedon DESC LIMIT 1;

			--update routing with rejection record
			INSERT INTO routing (
					eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
					fromroleid, toroleid, objectid , routingstatustypeid, activeflag,
					insertedby,  updatedby, insertedon, updatedon, isreviewrequest,
					servicerequestnumber,remarks,routeddescription )
			SELECT  appeventcode, R.tosecurityusersid, R.fromsecurityusersid, R.teamid, 
					R.toroleid, R.fromroleid, v_objectid, 17, 1,
					R.insertedby, R.updatedby, now(), now(), R.isreviewrequest,
					v_adoptioncasenumber, 'Adoption Annual Review Denied', 'Adoption Annual Review Denied' 
			FROM routing as R 
			WHERE R.routingid = v_routingid;
				
			GET DIAGNOSTICS v_row_cnt = ROW_COUNT;

			if coalesce(v_row_cnt, 0) > 0 then
				--de-activate routing review record 
				UPDATE 	routing 
				SET activeflag = 0, 
					updatedby = v_securityuserid, 
					updatedon = now() 
				WHERE routingid = v_routingid;

			end if;

		end if;

	END IF;

	RETURN  'Success';

END;


$function$
;
