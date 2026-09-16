CREATE OR REPLACE FUNCTION cjams.adoptionrouting(v_servicecaseid uuid, v_objectid uuid, v_securityuserid character varying, appeventcode character varying, v_status integer)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$

--------------------------------------------------------
-- 09-21-2022 - Aurora Issue Fixes  - Veera
-- Veera 09-19-2025 code fix - CDM-44514
---------------------------------------------------------


--------------------------------------------------------------------------------------
--09-01 - Addded agreementtyperefid field for the story CIDM-5203
--------------------------------------------------------------------------------------
DECLARE
 	v_case_county_id uuid;
 	v_fromroleid character varying;
	v_toroleid character varying;
	v_tosecurityusersid character varying;
	v_teamid uuid;
	v_routingid uuid;
	v_revisionid uuid;
	v_servicerequestnumber character varying;
	v_adoptionplanningid uuid;
	v_cnt integer;
	v_adpagreementcount integer;
	v_row_cnt integer;
	v_new_revisionid uuid;

	l_objecttypekey character varying;

BEGIN
	
	RAISE  NOTICE  '  appeventcode  %', appeventcode;
	RAISE  NOTICE  '  v_objectid  %', v_objectid;
	RAISE  NOTICE  '  v_servicecaseid  %', v_servicecaseid;

	--get Service Case Number
	select servicecasenumber into v_servicerequestnumber from servicecase s where servicecaseid = v_servicecaseid; 

	--get Case county id
	select c.countyid into v_case_county_id 
		from caseassignment ca 
			join team t on t.teamid = ca.fromteamid and t.activeflag=1
			join county c on c.countyid :: character varying = t.countyid and c.activeflag =1
	where ca.objectid = v_servicecaseid 
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


	RAISE NOTICE '  l_objecttypekey  %', l_objecttypekey;
	RAISE NOTICE '  v_case_county_id  %', v_case_county_id;
	RAISE NOTICE '  v_securityuserid  %', v_securityuserid;
	RAISE NOTICE '  v_tosecurityusersid  %', v_tosecurityusersid;
	RAISE NOTICE '  v_fromroleid  %', v_fromroleid;
	RAISE NOTICE '  v_toroleid  %', v_toroleid;

	IF (appeventcode='ASAR') THEN 
		--get most recent un-approved revisionid	
		SELECT adoptionagreementrevisionid, adoptionplanningid into v_revisionid ,  v_adoptionplanningid
			FROM adoptionagreementrevision
		WHERE adoptionagreementid = v_objectid 
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
						v_servicerequestnumber, 'Adoption Agreement Submitted for Review', 'Adoption Agreement Submitted for Review');
							
				--update revision record status as Review
				UPDATE 	adoptionagreementrevision 
					SET approvalstatustypekey = '3045', 
						updatedby = v_securityuserid, 
						updatedon = now() 
				WHERE adoptionagreementrevisionid = v_revisionid;

			elsif v_status = 16 then -- Approved
				--generate new adoptionagreementrevisionid
                select gen_random_uuid() into v_new_revisionid ;       

				--create agreement revision
				INSERT INTO cjams.adoptionagreementrevision
						(adoptionagreementrevisionid, adoptionagreementid, adoptionplanningid, isofferedsubsidy, offeraccepteddate, startdate, enddate, 
						finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, activeflag, effectivedate, 
						insertedby, insertedon, updatedby, updatedon, old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, 
						alternateid, isoriginal, issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, 
						agreementcomments, childplacedby, childplacedfrom, agreementtyperefid,providerid, adoptiveparent1id, adoptiveparent2id, approvalstatustypekey, approvaldate, etl_userid, etl_load_date)
				SELECT  v_new_revisionid, adoptionagreementid, adoptionplanningid, isofferedsubsidy, offeraccepteddate, startdate, enddate, 
						finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, 1, effectivedate, 
						v_securityuserid, now(), v_securityuserid, now(), old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, 
						alternateid, isoriginal, issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, 
						agreementcomments, childplacedby, childplacedfrom,agreementtyperefid, providerid, adoptiveparent1id, adoptiveparent2id, '3047', now(), etl_userid, etl_load_date
				FROM adoptionagreementrevision 
				WHERE adoptionagreementrevisionid = v_revisionid 
				ORDER BY insertedon DESC LIMIT 1;

				GET DIAGNOSTICS v_row_cnt = ROW_COUNT;

				if coalesce(v_row_cnt, 0) > 0 then
					--de-activate revision review record 
					UPDATE 	adoptionagreementrevision 
					SET activeflag = 0, 
						updatedby = v_securityuserid, 
						updatedon = now()
					WHERE adoptionagreementrevisionid = v_revisionid;

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
						v_servicerequestnumber, 'Adoption Agreement Approved', 'Adoption Agreement Approved' 
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

				-- Update or Insert adoptionagreement
				select count(1) 
					into v_cnt
				from adoptionagreement
				where adoptionagreementid = v_objectid
					and activeflag = 1 ;

				select count(1) 
					into v_adpagreementcount
				from adoptionagreement
				where adoptionplanningid = v_adoptionplanningid 
					and activeflag = 1 ;	
				
				IF coalesce(v_cnt, 0) > 0 THEN
					-- Update
					UPDATE 	adoptionagreement a
					SET 	adoptionagreementid = aa.adoptionagreementid, adoptionplanningid = aa.adoptionplanningid, 
							isofferedsubsidy = aa.isofferedsubsidy,offeraccepteddate = aa.offeraccepteddate, startdate = aa.startdate, enddate = aa.enddate, 
							finalizationdate = aa.finalizationdate, isunderappeal = aa.isunderappeal, parent1signdate = aa.parent1signdate, parent2signdate = aa.parent2signdate, 
							ldssdate = aa.ldssdate, issubsidypaid = aa.issubsidypaid, activeflag = 1, effectivedate = aa.effectivedate, 
							insertedby = v_securityuserid, insertedon = now(), updatedby = v_securityuserid, updatedon = now(), old_id = aa.old_id, ismedassist = aa.ismedassist, 
							parent1providerid = aa.parent1providerid, parent2providerid = aa.parent2providerid, parent1providername = aa.parent1providername, parent2providername = aa.parent2providername, 
							issingleparent = aa.issingleparent, singleparentadoptioncheck = aa.singleparentadoptioncheck, adoptiveparent1signature = aa.adoptiveparent1signature, 
							adoptiveparent2signature = aa.adoptiveparent2signature, ldssdirectorsignature = aa.ldssdirectorsignature, 
							agreementcomments = aa.agreementcomments, childplacedby = aa.childplacedby, childplacedfrom = aa.childplacedfrom, agreementtyperefid=aa.agreementtyperefid, providerid = aa.providerid, 
							adoptiveparent1id = aa.adoptiveparent1id, adoptiveparent2id = aa.adoptiveparent2id
					FROM adoptionagreementrevision aa
					WHERE a.adoptionagreementid = aa.adoptionagreementid
					AND aa.adoptionagreementrevisionid = v_new_revisionid ;
				ELSE

				    -- To deactivate duplicate adoption agreement for 1 adoption planning
					IF coalesce(v_adpagreementcount, 0) > 1 THEN
					    UPDATE 	adoptionagreement a set activeflag = 0, updatedby = v_securityuserid, updatedon = now()
						where adoptionplanningid = v_adoptionplanningid and activeflag = 1;
					end if;

					-- Insert
					INSERT INTO cjams.adoptionagreement
							(adoptionagreementid, adoptionplanningid, isofferedsubsidy, offeraccepteddate, startdate, enddate, 
							finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, activeflag, effectivedate, 
							insertedby, insertedon, updatedby, updatedon, old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, 
							issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, 
							agreementcomments, childplacedby, childplacedfrom,agreementtyperefid, providerid, adoptiveparent1id, adoptiveparent2id)
					SELECT 	adoptionagreementid, adoptionplanningid, isofferedsubsidy, offeraccepteddate, startdate, enddate, 
							finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, 1, effectivedate, 
							v_securityuserid, now(), v_securityuserid, now(), old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, 
							issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, 
							agreementcomments, childplacedby, childplacedfrom,agreementtyperefid, providerid, adoptiveparent1id, adoptiveparent2id
					FROM cjams.adoptionagreementrevision WHERE adoptionagreementrevisionid = v_new_revisionid ;

				END IF;
				
				
			elsif v_status = 17 then -- Reject
				--generate new adoptionagreementrevisionid
                select gen_random_uuid() into v_new_revisionid;

				--create agreement revision
				INSERT INTO cjams.adoptionagreementrevision
						(adoptionagreementrevisionid, adoptionagreementid, adoptionplanningid, isofferedsubsidy, offeraccepteddate, startdate, enddate, 
						finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, activeflag, effectivedate, 
						insertedby, insertedon, updatedby, updatedon, old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, 
						alternateid, isoriginal, issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, 
						agreementcomments, childplacedby, childplacedfrom, agreementtyperefid, providerid, adoptiveparent1id, adoptiveparent2id, approvalstatustypekey, approvaldate, etl_userid, etl_load_date)
				SELECT  v_new_revisionid, adoptionagreementid, adoptionplanningid, isofferedsubsidy, offeraccepteddate, startdate, enddate, 
						finalizationdate, isunderappeal, parent1signdate, parent2signdate, ldssdate, issubsidypaid, 1, effectivedate, 
						v_securityuserid, now(), v_securityuserid, now(), old_id, ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, 
						alternateid, isoriginal, issingleparent, singleparentadoptioncheck, adoptiveparent1signature, adoptiveparent2signature, ldssdirectorsignature, 
						agreementcomments, childplacedby, childplacedfrom,agreementtyperefid, providerid, adoptiveparent1id, adoptiveparent2id, '3046', now(), etl_userid, etl_load_date
				FROM adoptionagreementrevision 
				WHERE adoptionagreementrevisionid = v_revisionid 
				ORDER BY insertedon DESC LIMIT 1;

				GET DIAGNOSTICS v_row_cnt = ROW_COUNT;

				if coalesce(v_row_cnt, 0) > 0 then
					--de-activate revision review record 
					UPDATE 	adoptionagreementrevision 
					SET activeflag = 0, 
						updatedby = v_securityuserid, 
						updatedon = now()
					WHERE adoptionagreementrevisionid = v_revisionid;

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
						v_servicerequestnumber, 'Adoption Agreement Rejected', 'Adoption Agreement Rejected' 
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

	ELSIF (appeventcode='ADSR') THEN

	 	if v_routingstatustypeid = 16 then -- Approved
			update 	adoptionsuspensionrevision set approvalstatustypekey = '3047', approvaldate = now()::date 
	 		where 	adoptionsuspensionid = v_objectid ;
			
			update 	adoptionsuspension set approvalstatustypekey = '3047', updatedon = now(), approvaldate = now()::date
	 		where 	adoptionsuspensionid = v_objectid ;
  		end if;

	ELSIF (appeventcode = 'AARR' ) THEN
		
		--generate new adoptionagreementraterevisionid
        select gen_random_uuid() into v_new_revisionid ; 

		--get most recent un-approved revisionid	
		SELECT adoptionagreementraterevisionid into v_revisionid
			FROM adoptionagreementraterevision
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
						v_servicerequestnumber, 'Adoption Agreement Rate Submitted for Review', 'Adoption Agreement Rate Submitted for Review');

				--update revision record status as Review
				UPDATE 	adoptionagreementraterevision 
					SET approvalstatustypekey = '3045', 
						updatedby = v_securityuserid, 
						updatedon = now() 
				WHERE adoptionagreementraterevisionid = v_revisionid;
				
			elsif v_status = 16 then -- Approved

				--create rate revision
				INSERT INTO cjams.adoptionagreementraterevision 
						(adoptionagreementraterevisionid, adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
						provider_id, paymentamout, isssaapproved, ssaapproveddate, isspeacialneeds, parent1providerid, parent2providerid, 
						parent1providername, parent2providername, childrelationship, notes, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
						old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, approvalstatustypekey, approvaldate, isoriginal)
				SELECT  v_new_revisionid, adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
						provider_id, paymentamout, isssaapproved, ssaapproveddate, isspeacialneeds, parent1providerid, parent2providerid, 
						parent1providername, parent2providername, childrelationship, notes, 1, effectivedate, v_securityuserid, now(), v_securityuserid, now(), 
						old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, 'Approved', '3047', now(), isoriginal
				FROM adoptionagreementraterevision 
				WHERE adoptionagreementraterevisionid = v_revisionid 
				AND activeflag = 1;

				GET DIAGNOSTICS v_row_cnt = ROW_COUNT;

				if coalesce(v_row_cnt, 0) > 0 then
					--de-activate revision review record 
					UPDATE 	adoptionagreementraterevision 
					SET activeflag = 0, 
						updatedby = v_securityuserid, 
						updatedon = now() 
					WHERE adoptionagreementraterevisionid = v_revisionid;

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
						v_servicerequestnumber, 'Adoption Agreement Rate Approved', 'Adoption Agreement Rate Approved' 
				FROM routing as R 
				WHERE R.routingid = v_routingid;

				GET DIAGNOSTICS v_row_cnt = ROW_COUNT;

				if coalesce(v_row_cnt, 0) > 0 then
					--de-activate routing review record 
					UPDATE 	routing 
					SET activeflag = 0, 
						updatedby = v_securityuserid, 
						updatedon = now() 
					-- WHERE routingid = v_routingid;
					WHERE objectid = v_objectid::character varying 
						and eventcode = appeventcode
						AND routingstatustypeid = 15 
						and activeflag = 1;
				
				end if;

				-- Update or Insert adoptionagreementrate
				select count(1) 
					into v_cnt
				from adoptionagreementrate
				where adoptionagreementrateid = v_objectid
					and activeflag = 1 ;
				
				IF coalesce(v_cnt, 0) > 0 THEN
					-- Update
					UPDATE 	adoptionagreementrate r
					SET 	adoptionagreementrateid = rrv.adoptionagreementrateid, adoptionagreementid = rrv.adoptionagreementid, startdate = rrv.startdate, enddate = rrv.enddate, 
							provider_id = rrv.provider_id, paymentamout = rrv.paymentamout, isssaapproved = rrv.isssaapproved, ssaapproveddate = rrv.ssaapproveddate, 
							isspeacialneeds = rrv.isspeacialneeds, childrelationship = rrv.childrelationship, notes = rrv.notes, activeflag = 1, effectivedate = rrv.effectivedate, 
							insertedby = v_securityuserid, insertedon = now(), updatedby = v_securityuserid, updatedon = now(), approvaldate = rrv.approvaldate,
							old_id = rrv.old_id, specialneedtypekey = rrv.specialneedtypekey, specialneedremarks = rrv.specialneedremarks, transactiondate = rrv.transactiondate, 
							rateoverwrittensw = rrv.rateoverwrittensw, status = 'Approved'
					FROM adoptionagreementraterevision rrv
					WHERE r.adoptionagreementrateid = rrv.adoptionagreementrateid 
					AND rrv.adoptionagreementraterevisionid = v_new_revisionid ;
				ELSE
					-- Insert
					INSERT INTO cjams.adoptionagreementrate
							(adoptionagreementrateid, adoptionagreementid, startdate, enddate, provider_id, paymentamout, isssaapproved, ssaapproveddate, 
							isspeacialneeds, childrelationship, notes, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, approvaldate,
							old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status)
					SELECT 	adoptionagreementrateid, adoptionagreementid, startdate, enddate, provider_id, paymentamout, isssaapproved, ssaapproveddate, 
							isspeacialneeds, childrelationship, notes, 1, effectivedate, v_securityuserid, now(), v_securityuserid, now(), approvaldate,
							old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, 'Approved'
					FROM cjams.adoptionagreementraterevision WHERE adoptionagreementraterevisionid = v_new_revisionid ;
					
				END IF;
				
			elsif v_status = 17 then -- Reject
				
				--create rate revision
				INSERT INTO cjams.adoptionagreementraterevision 
						(adoptionagreementraterevisionid, adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
						provider_id, paymentamout, isssaapproved, ssaapproveddate, isspeacialneeds, parent1providerid, parent2providerid, 
						parent1providername, parent2providername, childrelationship, notes, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, 
						old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, status, approvalstatustypekey, approvaldate, isoriginal)
				SELECT  v_new_revisionid, adoptionagreementrateid, adoptionagreementid, startdate, enddate, 
						provider_id, paymentamout, isssaapproved, ssaapproveddate, isspeacialneeds, parent1providerid, parent2providerid, 
						parent1providername, parent2providername, childrelationship, notes, 1, effectivedate, v_securityuserid, now(), v_securityuserid, now(), 
						old_id, specialneedtypekey, specialneedremarks, transactiondate, rateoverwrittensw, 'Rejected', '3046', now(), isoriginal
				FROM adoptionagreementraterevision 
				WHERE adoptionagreementraterevisionid = v_revisionid 
				AND activeflag = 1;

				GET DIAGNOSTICS v_row_cnt = ROW_COUNT;

				if coalesce(v_row_cnt, 0) > 0 then
					--de-activate revision review record 
					UPDATE 	adoptionagreementraterevision 
					SET activeflag = 0, 
						updatedby = v_securityuserid, 
						updatedon = now() 
					WHERE adoptionagreementraterevisionid = v_revisionid;

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
						v_servicerequestnumber, 'Adoption Agreement Rate Rejected', 'Adoption Agreement Rate Rejected' 
				FROM routing as R 
				WHERE R.routingid = v_routingid;

				GET DIAGNOSTICS v_row_cnt = ROW_COUNT;

				if coalesce(v_row_cnt, 0) > 0 then
					--de-activate routing review record 
					UPDATE 	routing 
					SET activeflag = 0, 
						updatedby = v_securityuserid, 
						updatedon = now() 
					-- WHERE routingid = v_routingid;
					WHERE objectid = v_objectid::character varying 
						and eventcode = appeventcode
						AND routingstatustypeid = 15 
						and activeflag = 1;

				end if;

			end if;	
		ELSE
			RETURN  'Agreement Rate Revision record not found!';
		END IF;	
	END IF;

	RETURN  'Success';

END;


$function$
;