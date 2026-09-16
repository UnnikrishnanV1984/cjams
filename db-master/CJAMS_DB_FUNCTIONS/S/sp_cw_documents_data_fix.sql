CREATE OR REPLACE FUNCTION cjams.sp_cw_documents_data_fix(	as_user_id character varying, 
															OUT al_sqlcode integer, 
															OUT as_mess character varying
														  )
RETURNS record
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Vineet Tirodkar
-- Date Created: 06/28/2023

-- Document table Data Cleanup (CIDM-7375)
-- 1.Person profile documents metadata moved from transaction table to document properties table. 
/*
	1.	personimmunization
	2.	personbehavioralhealth
	3.	birthhealthinfo
	4.	clientunder5yearsinfo
	5.	personfmlymdclhstry
	6.	personhospitalization
	7.	personhealthinsurance
	8.	personsexualinfo
	9.	personexamination
	10.	personabusesubstance
	11.	personmedicpshychotropic
	12.	personphycisianinfo
	13.	personmedicalcondition
	14.	personhlthmobilityspeech
	15. personhlthfeeding
*/

-- 2. Unsaved documents count mismatch (activeflag = 2)
	
-- Revision(s)
-- 07/07/2023 - Vineet Tirodkar - To comment out Person profile documents metadata fix, 
--				So the SP will be used for Saved (Draft) documents cleanup multiple runs (CDM-32726)
-- 07/21/2023 - Vineet Tirodkar - Move the Person profile documents metadata to document properties table (CDM-33096)
--				Multiple documents were missed in the fix provided with CIDM-7375
-- 08/01/2023 - Vineet Tirodkar - Duplicate Unsaved documents Clean up (activeflag = 2) (CDM-33312)
------------------------------------------------------------------------
Declare sqlcode int default 0;

Declare vs_med_id character varying;
Declare vs_doctype character varying;
Declare vs_ecmsdocumentid character varying;
Declare vs_documentpropertiesid character varying;
Declare vs_documentpropertiesid_update character varying;
Declare vs_last_doctype character varying;
Declare vs_originalfilename character varying;
		
Declare vu_person_id uuid;
Declare vu_documentpropertiesid uuid;
Declare vu_objectid uuid;

Declare vl_cjamspid bigint;
Declare vl_count bigint;
Declare vl_dps_rank bigint;
Declare vl_active_record_count bigint;

Declare	vd_documentdate timestamp;
Declare	vd_actualdocumentdate timestamp;
		
cur_document_record record;
cur_documents_REFCURSOR REFCURSOR;

cur_documents_update_record record;
cur_documents_update_REFCURSOR REFCURSOR;

cur_unsaved_document record;
cur_unsaved_documents_REFCURSOR REFCURSOR;

cur_only_unsaved_document record;
cur_only_unsaved_documents_REFCURSOR REFCURSOR;

BEGIN
	if as_user_id is NULL then
		as_user_id := 'cw_document_fix';
	end if;
	
	
	-- 1.Person profile documents metadata moved from transaction table to document properties table. 
	/*
	DROP TABLE IF EXISTS ttb_document_updates CASCADE;
	CREATE TEMPORARY TABLE ttb_document_updates
		( med_id character varying, 
		  doctype character varying,
		  ecmsdocumentid character varying,
		  documentpropertiesid character varying,
		  personid uuid,
		  cjamspid bigint
		) ;
	*/	
	
	/*
	-- 1) personimmunization
	RAISE NOTICE 'personimmunization updates';
	
	OPEN cur_documents_REFCURSOR FOR
		select tab.med_id,
			tab.doctype,
			tab.ecmsdocumentid,
			tab.documentpropertiesid,
			tab.personid,
			tab.cjamspid
		from (
			select pmd.personimmunizationid as med_id,
				'personimmunization' as doctype,
				(pmd.uploadpath -> 0 ->> 'ecmsdocumentid')::character varying as ecmsdocumentid,
				(pmd.uploadpath -> 0 ->> 'documentpropertiesid')::character varying as documentpropertiesid,
				pmd.personid,
				pr.cjamspid,
				pmd.insertedon,
				pmd.updatedon
			from personimmunization pmd
				left join person pr on pr.personid = pmd.personid 
			where pmd.activeflag = 1
				and pmd.uploadpath is not null
				and pmd.uploadpath::character varying <> '[]'
				and pmd.personid is not null
			order by pmd.personid 
		) tab
		where tab.documentpropertiesid is not null 
		;
	loop
		fetch cur_documents_REFCURSOR into cur_document_record;
			exit when not found;
		
			-- Reset
			vs_med_id := NULL;
			vs_doctype := NULL;
			vs_ecmsdocumentid := NULL;
			vs_documentpropertiesid := NULL;
			vu_person_id := NULL;
			
			vs_med_id := cur_document_record.med_id;
			vs_doctype := cur_document_record.doctype;
			vs_ecmsdocumentid := cur_document_record.ecmsdocumentid;
			vs_documentpropertiesid := cur_document_record.documentpropertiesid;
			vu_person_id := cur_document_record.personid;
			vl_cjamspid := cur_document_record.cjamspid;
			
			if vs_documentpropertiesid is not NULL then 
			
				OPEN cur_documents_update_REFCURSOR FOR
					select templates.documentpropertiesid
						from personimmunization med,
							jsonb_to_recordset(med.uploadpath::jsonb) 
								AS templates(personid UUID, documentpropertiesid UUID )
					where  personimmunizationid = vs_med_id::uuid 
					; 
				loop
				fetch cur_documents_update_REFCURSOR into cur_documents_update_record;
				exit when not found;
				
					-- Reset
					vs_documentpropertiesid_update := NULL;
					
					vs_documentpropertiesid_update := cur_documents_update_record.documentpropertiesid;
					
					if vs_documentpropertiesid_update is not NULL then 
					
						RAISE NOTICE 'vs_documentpropertiesid_update >> %', vs_documentpropertiesid_update || ' for ' || vl_cjamspid;
						
						update documentproperties 
						set additionalobjecttype = vs_doctype, 
							additionalobjectid = vs_med_id
--							, updatedby = 'CDM-33096_1'
--							, updatedon = now()
						where documentpropertiesid = vs_documentpropertiesid_update::uuid 
							and additionalobjecttype is null 
							and additionalobjectid is null ;
							
						al_sqlcode := SQLCODE;
						IF al_sqlcode < 0 THEN
							as_mess := 'Error updating documentproperties for personimmunization.';
							al_sqlcode := -1;
							ROLLBACK;
							exit;
						END IF ;	
						
					end if;	
				END LOOP;	
				close cur_documents_update_REFCURSOR;
				
			end if;
	END LOOP;	
	close cur_documents_REFCURSOR;	
	
	-- 2) personbehavioralhealth
	RAISE NOTICE 'personbehavioralhealth updates';
	
	OPEN cur_documents_REFCURSOR FOR
		select tab.med_id,
			tab.doctype,
			tab.ecmsdocumentid,
			tab.documentpropertiesid,
			tab.personid,
			tab.cjamspid
		from (
			select pmd.personbehavioralhealthid as med_id,
				'personbehavioralhealth' as doctype,
				(pmd.uploadpath -> 0 ->> 'ecmsdocumentid')::character varying as ecmsdocumentid,
				(pmd.uploadpath -> 0 ->> 'documentpropertiesid')::character varying as documentpropertiesid,
				pmd.personid,
				pr.cjamspid,
				pmd.insertedon,
				pmd.updatedon
			from personbehavioralhealth pmd
				left join person pr on pr.personid = pmd.personid 
			where pmd.activeflag = 1
				and pmd.uploadpath is not null
				and pmd.uploadpath::character varying <> '[]'
				and pmd.personid is not null
			order by pmd.personid 
		) tab
		where tab.documentpropertiesid is not null 
		;
	loop
		fetch cur_documents_REFCURSOR into cur_document_record;
			exit when not found;
		
			-- Reset
			vs_med_id := NULL;
			vs_doctype := NULL;
			vs_ecmsdocumentid := NULL;
			vs_documentpropertiesid := NULL;
			vu_person_id := NULL;
			
			vs_med_id := cur_document_record.med_id;
			vs_doctype := cur_document_record.doctype;
			vs_ecmsdocumentid := cur_document_record.ecmsdocumentid;
			vs_documentpropertiesid := cur_document_record.documentpropertiesid;
			vu_person_id := cur_document_record.personid;
			vl_cjamspid := cur_document_record.cjamspid;
			
			if vs_documentpropertiesid is not NULL then 
			
				OPEN cur_documents_update_REFCURSOR FOR
					select templates.documentpropertiesid
						from personbehavioralhealth med,
							jsonb_to_recordset(med.uploadpath::jsonb) 
								AS templates(personid UUID, documentpropertiesid UUID )
					where personbehavioralhealthid = vs_med_id::uuid 
					; 
				loop
				fetch cur_documents_update_REFCURSOR into cur_documents_update_record;
				exit when not found;
				
					-- Reset
					vs_documentpropertiesid_update := NULL;
					
					vs_documentpropertiesid_update := cur_documents_update_record.documentpropertiesid;
					
					if vs_documentpropertiesid_update is not NULL then 
						
						RAISE NOTICE 'vs_documentpropertiesid_update >> %', vs_documentpropertiesid_update || ' for ' || vl_cjamspid;
						-- RAISE NOTICE 'vs_doctype >> %', vs_doctype || ' PK ' || vs_med_id;
					
						update documentproperties 
						set additionalobjecttype = vs_doctype, 
							additionalobjectid = vs_med_id
--							, updatedby = 'CDM-33096_2'
--							, updatedon = now()
						where documentpropertiesid = vs_documentpropertiesid_update::uuid 
							and additionalobjecttype is null 
							and additionalobjectid is null ;
							
						al_sqlcode := SQLCODE;
						IF al_sqlcode < 0 THEN
							as_mess := 'Error updating documentproperties with for personbehavioralhealth.';
							al_sqlcode := -1;
							ROLLBACK;
							exit;
						END IF ;	
						
					end if;	
				END LOOP;	
				close cur_documents_update_REFCURSOR;
				
			end if;
	END LOOP;	
	close cur_documents_REFCURSOR;		
	
	-- 3) birthhealthinfo
	RAISE NOTICE 'birthhealthinfo updates';

	OPEN cur_documents_REFCURSOR FOR
		select tab.med_id,
			tab.doctype,
			tab.ecmsdocumentid,
			tab.documentpropertiesid,
			tab.personid,
			tab.cjamspid
		from (
			select pmd.birthhealthinfoid as med_id,
				'birthhealthinfo' as doctype,
				(pmd.uploadpath -> 0 ->> 'ecmsdocumentid')::character varying as ecmsdocumentid,
				(pmd.uploadpath -> 0 ->> 'documentpropertiesid')::character varying as documentpropertiesid,
				pmd.personid,
				pr.cjamspid,
				pmd.insertedon,
				pmd.updatedon
			from birthhealthinfo pmd
				left join person pr on pr.personid = pmd.personid 
			where pmd.activeflag = 1
				and pmd.uploadpath is not null
				and pmd.uploadpath::character varying <> '[]'
				and pmd.personid is not null
			order by pmd.personid
		) tab
		where tab.documentpropertiesid is not null
		;
	loop
		fetch cur_documents_REFCURSOR into cur_document_record;
			exit when not found;
		
			-- Reset
			vs_med_id := NULL;
			vs_doctype := NULL;
			vs_ecmsdocumentid := NULL;
			vs_documentpropertiesid := NULL;
			vu_person_id := NULL;
			
			vs_med_id := cur_document_record.med_id;
			vs_doctype := cur_document_record.doctype;
			vs_ecmsdocumentid := cur_document_record.ecmsdocumentid;
			vs_documentpropertiesid := cur_document_record.documentpropertiesid;
			vu_person_id := cur_document_record.personid;
			vl_cjamspid := cur_document_record.cjamspid;
			
			if vs_documentpropertiesid is not NULL then 
			
				OPEN cur_documents_update_REFCURSOR FOR
					select templates.documentpropertiesid
						from birthhealthinfo med,
							jsonb_to_recordset(med.uploadpath::jsonb) 
								AS templates(personid UUID, documentpropertiesid UUID )
					where birthhealthinfoid = vs_med_id::uuid
					; 
				loop
				fetch cur_documents_update_REFCURSOR into cur_documents_update_record;
				exit when not found;
				
					-- Reset
					vs_documentpropertiesid_update := NULL;
					
					vs_documentpropertiesid_update := cur_documents_update_record.documentpropertiesid;
					
					if vs_documentpropertiesid_update is not NULL then 
					
						RAISE NOTICE 'vs_documentpropertiesid_update >> %', vs_documentpropertiesid_update || ' for ' || vl_cjamspid;
						
						update documentproperties 
						set additionalobjecttype = vs_doctype, 
							additionalobjectid = vs_med_id
--							, updatedby = 'CDM-33096_3'
--							, updatedon = now()
						where documentpropertiesid = vs_documentpropertiesid_update::uuid 
							and additionalobjecttype is null 
							and additionalobjectid is null ;
							
						al_sqlcode := SQLCODE;
						IF al_sqlcode < 0 THEN
							as_mess := 'Error updating documentproperties with for birthhealthinfo.';
							al_sqlcode := -1;
							ROLLBACK;
							exit;
						END IF ;	
						
					end if;
				END LOOP;	
				close cur_documents_update_REFCURSOR;
				
			end if;
	END LOOP;	
	close cur_documents_REFCURSOR;		
	
	-- 4) clientunder5yearsinfo
	RAISE NOTICE 'clientunder5yearsinfo updates';

	OPEN cur_documents_REFCURSOR FOR
		select tab.med_id,
			tab.doctype,
			tab.ecmsdocumentid,
			tab.documentpropertiesid,
			tab.personid,
			tab.cjamspid
		from (
		select pmd.clientunder5yearsinfoid as med_id,
				'clientunder5yearsinfo' as doctype,
				(pmd.uploadpath -> 0 ->> 'ecmsdocumentid')::character varying as ecmsdocumentid,
				(pmd.uploadpath -> 0 ->> 'documentpropertiesid')::character varying as documentpropertiesid,
				pmd.personid,
				pr.cjamspid,
				pmd.insertedon,
				pmd.updatedon
			from clientunder5yearsinfo pmd
				left join person pr on pr.personid = pmd.personid 
			where pmd.activeflag = 1
				and pmd.uploadpath is not null
				and pmd.uploadpath::character varying <> '[]'
				and pmd.personid is not null
			order by pmd.personid
		) tab
		where tab.documentpropertiesid is not null 
		;
	loop
		fetch cur_documents_REFCURSOR into cur_document_record;
			exit when not found;
		
			-- Reset
			vs_med_id := NULL;
			vs_doctype := NULL;
			vs_ecmsdocumentid := NULL;
			vs_documentpropertiesid := NULL;
			vu_person_id := NULL;
			
			vs_med_id := cur_document_record.med_id;
			vs_doctype := cur_document_record.doctype;
			vs_ecmsdocumentid := cur_document_record.ecmsdocumentid;
			vs_documentpropertiesid := cur_document_record.documentpropertiesid;
			vu_person_id := cur_document_record.personid;
			vl_cjamspid := cur_document_record.cjamspid;
			
			if vs_documentpropertiesid is not NULL then 
			
				OPEN cur_documents_update_REFCURSOR FOR
					select templates.documentpropertiesid
						from clientunder5yearsinfo med,
							jsonb_to_recordset(med.uploadpath::jsonb) 
								AS templates(personid UUID, documentpropertiesid UUID )
					where clientunder5yearsinfoid = vs_med_id::uuid 
					; 
				loop
				fetch cur_documents_update_REFCURSOR into cur_documents_update_record;
				exit when not found;
				
					-- Reset
					vs_documentpropertiesid_update := NULL;
					
					vs_documentpropertiesid_update := cur_documents_update_record.documentpropertiesid;
					
					if vs_documentpropertiesid_update is not NULL then 
					
						RAISE NOTICE 'vs_documentpropertiesid_update >> %', vs_documentpropertiesid_update || ' for ' || vl_cjamspid;
						
						update documentproperties 
						set additionalobjecttype = vs_doctype, 
							additionalobjectid = vs_med_id
--							, updatedby = 'CDM-33096_4'
--							, updatedon = now()
						where documentpropertiesid = vs_documentpropertiesid_update::uuid 
							and additionalobjecttype is null 
							and additionalobjectid is null ;
							
						al_sqlcode := SQLCODE;
						IF al_sqlcode < 0 THEN
							as_mess := 'Error updating documentproperties with for clientunder5yearsinfo.';
							al_sqlcode := -1;
							ROLLBACK;
							exit;
						END IF ;	
						
					end if;	
				END LOOP;	
				close cur_documents_update_REFCURSOR;
				
			end if;
	END LOOP;	
	close cur_documents_REFCURSOR;	
	
	-- 5) personfmlymdclhstry
	RAISE NOTICE 'personfmlymdclhstry updates';

	OPEN cur_documents_REFCURSOR FOR
		select tab.med_id,
			tab.doctype,
			tab.ecmsdocumentid,
			tab.documentpropertiesid,
			tab.personid,
			tab.cjamspid
		from (
			select pmd.personfmlymdclhstryid as med_id,
				'personfmlymdclhstry' as doctype,
				(pmd.uploadpath -> 0 ->> 'ecmsdocumentid')::character varying as ecmsdocumentid,
				(pmd.uploadpath -> 0 ->> 'documentpropertiesid')::character varying as documentpropertiesid,
				pmd.personid,
				pr.cjamspid,
				pmd.insertedon,
				pmd.updatedon
			from personfmlymdclhstry pmd
				left join person pr on pr.personid = pmd.personid 
			where pmd.activeflag = 1
				and pmd.uploadpath is not null
				and pmd.uploadpath::character varying <> '[]'
				and pmd.personid is not null
			order by pmd.personid
		) tab
		where tab.documentpropertiesid is not null 
		;	
	loop
		fetch cur_documents_REFCURSOR into cur_document_record;
			exit when not found;
		
			-- Reset
			vs_med_id := NULL;
			vs_doctype := NULL;
			vs_ecmsdocumentid := NULL;
			vs_documentpropertiesid := NULL;
			vu_person_id := NULL;
			
			vs_med_id := cur_document_record.med_id;
			vs_doctype := cur_document_record.doctype;
			vs_ecmsdocumentid := cur_document_record.ecmsdocumentid;
			vs_documentpropertiesid := cur_document_record.documentpropertiesid;
			vu_person_id := cur_document_record.personid;
			vl_cjamspid := cur_document_record.cjamspid;
			
			if vs_documentpropertiesid is not NULL then 
			
				OPEN cur_documents_update_REFCURSOR FOR
					select templates.documentpropertiesid
						from personfmlymdclhstry med,
							jsonb_to_recordset(med.uploadpath::jsonb) 
								AS templates(personid UUID, documentpropertiesid UUID )
					where personfmlymdclhstryid = vs_med_id::uuid 
					; 
				loop
				fetch cur_documents_update_REFCURSOR into cur_documents_update_record;
				exit when not found;
				
					-- Reset
					vs_documentpropertiesid_update := NULL;
					
					vs_documentpropertiesid_update := cur_documents_update_record.documentpropertiesid;
					
					if vs_documentpropertiesid_update is not NULL then 
					
						RAISE NOTICE 'vs_documentpropertiesid_update >> %', vs_documentpropertiesid_update || ' for ' || vl_cjamspid;
						
						update documentproperties 
						set additionalobjecttype = vs_doctype, 
							additionalobjectid = vs_med_id
--							, updatedby = 'CDM-33096_5'
--							, updatedon = now()
						where documentpropertiesid = vs_documentpropertiesid_update::uuid 
							and additionalobjecttype is null 
							and additionalobjectid is null ;
							
						al_sqlcode := SQLCODE;
						IF al_sqlcode < 0 THEN
							as_mess := 'Error updating documentproperties with for personfmlymdclhstry.';
							al_sqlcode := -1;
							ROLLBACK;
							exit;
						END IF ;	
						
					end if;	
				END LOOP;	
				close cur_documents_update_REFCURSOR;
				
			end if;
	END LOOP;	
	close cur_documents_REFCURSOR;	
	
	-- 6) personhospitalization
	RAISE NOTICE 'personhospitalization updates';

	OPEN cur_documents_REFCURSOR FOR
		select tab.med_id,
			tab.doctype,
			tab.ecmsdocumentid,
			tab.documentpropertiesid,
			tab.personid,
			tab.cjamspid
		from (
			select pmd.hospitalizationid as med_id,
				'personhospitalization' as doctype,
				(pmd.uploadpath -> 0 ->> 'ecmsdocumentid')::character varying as ecmsdocumentid,
				(pmd.uploadpath -> 0 ->> 'documentpropertiesid')::character varying as documentpropertiesid,
				pmd.personid,
				pr.cjamspid,
				pmd.insertedon,
				pmd.updatedon
			from personhospitalization pmd
				left join person pr on pr.personid = pmd.personid 
			where pmd.activeflag = 1
				and pmd.uploadpath is not null
				and pmd.uploadpath::character varying <> '[]'
				and pmd.personid is not null
			order by pmd.personid 
		) tab
		where tab.documentpropertiesid is not null
		;
	loop
		fetch cur_documents_REFCURSOR into cur_document_record;
			exit when not found;
		
			-- Reset
			vs_med_id := NULL;
			vs_doctype := NULL;
			vs_ecmsdocumentid := NULL;
			vs_documentpropertiesid := NULL;
			vu_person_id := NULL;
			
			vs_med_id := cur_document_record.med_id;
			vs_doctype := cur_document_record.doctype;
			vs_ecmsdocumentid := cur_document_record.ecmsdocumentid;
			vs_documentpropertiesid := cur_document_record.documentpropertiesid;
			vu_person_id := cur_document_record.personid;
			vl_cjamspid := cur_document_record.cjamspid;
			
			if vs_documentpropertiesid is not NULL then 
			
				OPEN cur_documents_update_REFCURSOR FOR
					select templates.documentpropertiesid
						from personhospitalization med,
							jsonb_to_recordset(med.uploadpath::jsonb) 
								AS templates(personid UUID, documentpropertiesid UUID )
					where hospitalizationid = vs_med_id::uuid 
					; 
				loop
				fetch cur_documents_update_REFCURSOR into cur_documents_update_record;
				exit when not found;
				
					-- Reset
					vs_documentpropertiesid_update := NULL;
					
					vs_documentpropertiesid_update := cur_documents_update_record.documentpropertiesid;
					
					if vs_documentpropertiesid_update is not NULL then 
						RAISE NOTICE 'vs_documentpropertiesid_update >> %', vs_documentpropertiesid_update || ' for ' || vl_cjamspid;
						
						update documentproperties 
						set additionalobjecttype = vs_doctype, 
							additionalobjectid = vs_med_id
--							, updatedby = 'CDM-33096_6'
--							, updatedon = now()
						where documentpropertiesid = vs_documentpropertiesid_update::uuid 
							and additionalobjecttype is null 
							and additionalobjectid is null ;
							
						al_sqlcode := SQLCODE;
						IF al_sqlcode < 0 THEN
							as_mess := 'Error updating documentproperties with for personhospitalization.';
							al_sqlcode := -1;
							ROLLBACK;
							exit;
						END IF ;

					end if;			
				END LOOP;	
				close cur_documents_update_REFCURSOR;
				
			end if;
	END LOOP;	
	close cur_documents_REFCURSOR;	
	
	-- 7) personhealthinsurance
	RAISE NOTICE 'personhealthinsurance updates';

	OPEN cur_documents_REFCURSOR FOR
		select tab.med_id,
			tab.doctype,
			tab.ecmsdocumentid,
			tab.documentpropertiesid,
			tab.personid,
			tab.cjamspid
		from (
			select pmd.personhealthinsuranceid as med_id,
				'personhealthinsurance' as doctype,
				(pmd.uploadpath -> 0 ->> 'ecmsdocumentid')::character varying as ecmsdocumentid,
				(pmd.uploadpath -> 0 ->> 'documentpropertiesid')::character varying as documentpropertiesid,
				pmd.personid,
				pr.cjamspid,
				pmd.insertedon,
				pmd.updatedon
			from personhealthinsurance pmd
				left join person pr on pr.personid = pmd.personid 
			where pmd.activeflag = 1
				and pmd.uploadpath is not null
				and pmd.uploadpath::character varying <> '[]'
				and pmd.personid is not null
			order by pmd.personid
		) tab
		where tab.documentpropertiesid is not null 
		;	
	loop
		fetch cur_documents_REFCURSOR into cur_document_record;
			exit when not found;
		
			-- Reset
			vs_med_id := NULL;
			vs_doctype := NULL;
			vs_ecmsdocumentid := NULL;
			vs_documentpropertiesid := NULL;
			vu_person_id := NULL;
			
			vs_med_id := cur_document_record.med_id;
			vs_doctype := cur_document_record.doctype;
			vs_ecmsdocumentid := cur_document_record.ecmsdocumentid;
			vs_documentpropertiesid := cur_document_record.documentpropertiesid;
			vu_person_id := cur_document_record.personid;
			vl_cjamspid := cur_document_record.cjamspid;
			
			if vs_documentpropertiesid is not NULL then 
			
				OPEN cur_documents_update_REFCURSOR FOR
					select templates.documentpropertiesid
						from personhealthinsurance med,
							jsonb_to_recordset(med.uploadpath::jsonb) 
								AS templates(personid UUID, documentpropertiesid UUID )
					where personhealthinsuranceid = vs_med_id::uuid 
					; 
				loop
				fetch cur_documents_update_REFCURSOR into cur_documents_update_record;
				exit when not found;
				
					-- Reset
					vs_documentpropertiesid_update := NULL;
					
					vs_documentpropertiesid_update := cur_documents_update_record.documentpropertiesid;
					
					if vs_documentpropertiesid_update is not NULL then 
						RAISE NOTICE 'vs_documentpropertiesid_update >> %', vs_documentpropertiesid_update || ' for ' || vl_cjamspid;
						
						update documentproperties 
						set additionalobjecttype = vs_doctype, 
							additionalobjectid = vs_med_id
--							, updatedby = 'CDM-33096_7'
--							, updatedon = now()
						where documentpropertiesid = vs_documentpropertiesid_update::uuid 
							and additionalobjecttype is null 
							and additionalobjectid is null ;
							
						al_sqlcode := SQLCODE;
						IF al_sqlcode < 0 THEN
							as_mess := 'Error updating documentproperties with for personhealthinsurance.';
							al_sqlcode := -1;
							ROLLBACK;
							exit;
						END IF ;	
						
					end if;	
				END LOOP;	
				close cur_documents_update_REFCURSOR;
				
			end if;
	END LOOP;	
	close cur_documents_REFCURSOR;	
	
	
	-- 8) personsexualinfo
	RAISE NOTICE 'personsexualinfo updates';

	OPEN cur_documents_REFCURSOR FOR
		select tab.med_id,
			tab.doctype,
			tab.ecmsdocumentid,
			tab.documentpropertiesid,
			tab.personid,
			tab.cjamspid
		from (
			select pmd.personsexualinfoid as med_id,
				'personsexualinfo' as doctype,
				(pmd.uploadpath -> 0 ->> 'ecmsdocumentid')::character varying as ecmsdocumentid,
				(pmd.uploadpath -> 0 ->> 'documentpropertiesid')::character varying as documentpropertiesid,
				pmd.personid,
				pr.cjamspid,
				pmd.insertedon,
				pmd.updatedon
			from personsexualinfo pmd
				left join person pr on pr.personid = pmd.personid 
			where pmd.activeflag = 1
				and pmd.uploadpath is not null
				and pmd.uploadpath::character varying <> '[]'
				and pmd.personid is not null
			order by pmd.personid
		) tab
		where tab.documentpropertiesid is not null
		;
	loop
		fetch cur_documents_REFCURSOR into cur_document_record;
			exit when not found;
		
			-- Reset
			vs_med_id := NULL;
			vs_doctype := NULL;
			vs_ecmsdocumentid := NULL;
			vs_documentpropertiesid := NULL;
			vu_person_id := NULL;
			
			vs_med_id := cur_document_record.med_id;
			vs_doctype := cur_document_record.doctype;
			vs_ecmsdocumentid := cur_document_record.ecmsdocumentid;
			vs_documentpropertiesid := cur_document_record.documentpropertiesid;
			vu_person_id := cur_document_record.personid;
			vl_cjamspid := cur_document_record.cjamspid;
			
			if vs_documentpropertiesid is not NULL then 
			
				OPEN cur_documents_update_REFCURSOR FOR
					select templates.documentpropertiesid
						from personsexualinfo med,
							jsonb_to_recordset(med.uploadpath::jsonb) 
								AS templates(personid UUID, documentpropertiesid UUID )
					where personsexualinfoid = vs_med_id::uuid 
					; 
				loop
				fetch cur_documents_update_REFCURSOR into cur_documents_update_record;
				exit when not found;
				
					-- Reset
					vs_documentpropertiesid_update := NULL;
					
					vs_documentpropertiesid_update := cur_documents_update_record.documentpropertiesid;
					
					if vs_documentpropertiesid_update is not NULL then 
					
						RAISE NOTICE 'vs_documentpropertiesid_update >> %', vs_documentpropertiesid_update || ' for ' || vl_cjamspid;
						
						update documentproperties 
						set additionalobjecttype = vs_doctype, 
							additionalobjectid = vs_med_id
--							, updatedby = 'CDM-33096_8'
--							, updatedon = now()
						where documentpropertiesid = vs_documentpropertiesid_update::uuid 
							and additionalobjecttype is null 
							and additionalobjectid is null ;
							
						al_sqlcode := SQLCODE;
						IF al_sqlcode < 0 THEN
							as_mess := 'Error updating documentproperties with for personsexualinfo.';
							al_sqlcode := -1;
							ROLLBACK;
							exit;
						END IF ;	
						
					end if;	
				END LOOP;	
				close cur_documents_update_REFCURSOR;
				
			end if;
	END LOOP;	
	close cur_documents_REFCURSOR;	
	
	
	-- 9) personexamination
	RAISE NOTICE 'personexamination updates';

	OPEN cur_documents_REFCURSOR FOR
		select tab.med_id,
			tab.doctype,
			tab.ecmsdocumentid,
			tab.documentpropertiesid,
			tab.personid,
			tab.cjamspid
		from (
			select pmd.personexaminationid as med_id,
				'personexamination' as doctype,
				(pmd.uploadpath -> 0 ->> 'ecmsdocumentid')::character varying as ecmsdocumentid,
				(pmd.uploadpath -> 0 ->> 'documentpropertiesid')::character varying as documentpropertiesid,
				pmd.personid,
				pr.cjamspid,
				pmd.insertedon,
				pmd.updatedon
			from personexamination pmd
				left join person pr on pr.personid = pmd.personid 
			where pmd.activeflag = 1
				and pmd.uploadpath is not null
				and pmd.uploadpath::character varying <> '[]'
				and pmd.personid is not null
			order by pmd.personid 
		) tab
		where tab.documentpropertiesid is not null 
		;	
	loop
		fetch cur_documents_REFCURSOR into cur_document_record;
			exit when not found;
		
			-- Reset
			vs_med_id := NULL;
			vs_doctype := NULL;
			vs_ecmsdocumentid := NULL;
			vs_documentpropertiesid := NULL;
			vu_person_id := NULL;
			
			vs_med_id := cur_document_record.med_id;
			vs_doctype := cur_document_record.doctype;
			vs_ecmsdocumentid := cur_document_record.ecmsdocumentid;
			vs_documentpropertiesid := cur_document_record.documentpropertiesid;
			vu_person_id := cur_document_record.personid;
			vl_cjamspid := cur_document_record.cjamspid;
			
			if vs_documentpropertiesid is not NULL then 
			
				OPEN cur_documents_update_REFCURSOR FOR
					select templates.documentpropertiesid
						from personexamination med,
							jsonb_to_recordset(med.uploadpath::jsonb) 
								AS templates(personid UUID, documentpropertiesid UUID )
					where personexaminationid = vs_med_id::uuid 
					; 
				loop
				fetch cur_documents_update_REFCURSOR into cur_documents_update_record;
				exit when not found;
				
					-- Reset
					vs_documentpropertiesid_update := NULL;
					
					vs_documentpropertiesid_update := cur_documents_update_record.documentpropertiesid;
					
					if vs_documentpropertiesid_update is not NULL then 
					
						RAISE NOTICE 'vs_documentpropertiesid_update >> %', vs_documentpropertiesid_update || ' for ' || vl_cjamspid;
						
						update documentproperties 
						set additionalobjecttype = vs_doctype, 
							additionalobjectid = vs_med_id
--							, updatedby = 'CDM-33096_9'
--							, updatedon = now()							
						where documentpropertiesid = vs_documentpropertiesid_update::uuid 
							and additionalobjecttype is null 
							and additionalobjectid is null ;
							
						al_sqlcode := SQLCODE;
						IF al_sqlcode < 0 THEN
							as_mess := 'Error updating documentproperties with for personexamination.';
							al_sqlcode := -1;
							ROLLBACK;
							exit;
						END IF ;	
						
					end if;	
				END LOOP;	
				close cur_documents_update_REFCURSOR;
				
			end if;
	END LOOP;	
	close cur_documents_REFCURSOR;	
	
		
	-- 10) personabusesubstance
	RAISE NOTICE 'personabusesubstance updates';

	OPEN cur_documents_REFCURSOR FOR
		select tab.med_id,
			tab.doctype,
			tab.ecmsdocumentid,
			tab.documentpropertiesid,
			tab.personid,
			tab.cjamspid
		from (
			select pmd.personabusesubstanceid as med_id,
				'personabusesubstance' as doctype,
				(pmd.uploadpath -> 0 ->> 'ecmsdocumentid')::character varying as ecmsdocumentid,
				(pmd.uploadpath -> 0 ->> 'documentpropertiesid')::character varying as documentpropertiesid,
				pmd.personid,
				pr.cjamspid,
				pmd.insertedon,
				pmd.updatedon
			from personabusesubstance pmd
				left join person pr on pr.personid = pmd.personid 
			where pmd.activeflag = 1
				and pmd.uploadpath is not null
				and pmd.uploadpath::character varying <> '[]'
				and pmd.personid is not null
			order by pmd.personid 
		) tab
		where tab.documentpropertiesid is not null ;	
	loop
		fetch cur_documents_REFCURSOR into cur_document_record;
			exit when not found;
		
			-- Reset
			vs_med_id := NULL;
			vs_doctype := NULL;
			vs_ecmsdocumentid := NULL;
			vs_documentpropertiesid := NULL;
			vu_person_id := NULL;
			
			vs_med_id := cur_document_record.med_id;
			vs_doctype := cur_document_record.doctype;
			vs_ecmsdocumentid := cur_document_record.ecmsdocumentid;
			vs_documentpropertiesid := cur_document_record.documentpropertiesid;
			vu_person_id := cur_document_record.personid;
			vl_cjamspid := cur_document_record.cjamspid;
			
			if vs_documentpropertiesid is not NULL then 
			
				OPEN cur_documents_update_REFCURSOR FOR
					select templates.documentpropertiesid
						from personabusesubstance med,
							jsonb_to_recordset(med.uploadpath::jsonb) 
								AS templates(personid UUID, documentpropertiesid UUID )
					where personabusesubstanceid = vs_med_id::uuid 
					; 
				loop
				fetch cur_documents_update_REFCURSOR into cur_documents_update_record;
				exit when not found;
				
					-- Reset
					vs_documentpropertiesid_update := NULL;
					
					vs_documentpropertiesid_update := cur_documents_update_record.documentpropertiesid;
					
					if vs_documentpropertiesid_update is not NULL then 
					
						RAISE NOTICE 'vs_documentpropertiesid_update >> %', vs_documentpropertiesid_update || ' for ' || vl_cjamspid;
						
						update documentproperties 
						set additionalobjecttype = vs_doctype, 
							additionalobjectid = vs_med_id
--							, updatedby = 'CDM-33096_10'
--							, updatedon = now()							
						where documentpropertiesid = vs_documentpropertiesid_update::uuid 
							and additionalobjecttype is null 
							and additionalobjectid is null ;
							
						al_sqlcode := SQLCODE;
						IF al_sqlcode < 0 THEN
							as_mess := 'Error updating documentproperties with for personabusesubstance.';
							al_sqlcode := -1;
							ROLLBACK;
							exit;
						END IF ;	
						
					end if;	
				END LOOP;	
				close cur_documents_update_REFCURSOR;
				
			end if;
	END LOOP;	
	close cur_documents_REFCURSOR;	
	
	-- 11) personmedicpshychotropic
	RAISE NOTICE 'personmedicpshychotropic updates';

	OPEN cur_documents_REFCURSOR FOR
		select tab.med_id,
			tab.doctype,
			tab.ecmsdocumentid,
			tab.documentpropertiesid,
			tab.personid,
			tab.cjamspid
		from (
			select pmd.personmedicpshychotropicid as med_id,
				'personmedicpshychotropic' as doctype,
				(pmd.uploadedfiles -> 0 ->> 'ecmsdocumentid')::character varying as ecmsdocumentid,
				(pmd.uploadedfiles -> 0 ->> 'documentpropertiesid')::character varying as documentpropertiesid,
				pmd.personid,
				pr.cjamspid,
				pmd.insertedon,
				pmd.updatedon
			from personmedicpshychotropic pmd
				left join person pr on pr.personid = pmd.personid 
			where pmd.activeflag = 1
				and pmd.uploadedfiles is not null
				and pmd.uploadedfiles::character varying <> '[]'
				and pmd.personid is not null
			order by pmd.personid 
		) tab
		where tab.documentpropertiesid is not null 
		;
	loop
		fetch cur_documents_REFCURSOR into cur_document_record;
			exit when not found;
		
			-- Reset
			vs_med_id := NULL;
			vs_doctype := NULL;
			vs_ecmsdocumentid := NULL;
			vs_documentpropertiesid := NULL;
			vu_person_id := NULL;
			
			vs_med_id := cur_document_record.med_id;
			vs_doctype := cur_document_record.doctype;
			vs_ecmsdocumentid := cur_document_record.ecmsdocumentid;
			vs_documentpropertiesid := cur_document_record.documentpropertiesid;
			vu_person_id := cur_document_record.personid;
			vl_cjamspid := cur_document_record.cjamspid;
			
			if vs_documentpropertiesid is not NULL then 
			
				OPEN cur_documents_update_REFCURSOR FOR
					select templates.documentpropertiesid
						from personmedicpshychotropic med,
							jsonb_to_recordset(med.uploadedfiles::jsonb) 
								AS templates(personid UUID, documentpropertiesid UUID )
					where personmedicpshychotropicid = vs_med_id::uuid 
					; 
				loop
				fetch cur_documents_update_REFCURSOR into cur_documents_update_record;
				exit when not found;
				
					-- Reset
					vs_documentpropertiesid_update := NULL;
					
					vs_documentpropertiesid_update := cur_documents_update_record.documentpropertiesid;
					
					if vs_documentpropertiesid_update is not NULL then 
					
						RAISE NOTICE 'vs_documentpropertiesid_update >> %', vs_documentpropertiesid_update || ' for ' || vl_cjamspid;
						
						update documentproperties 
						set additionalobjecttype = vs_doctype, 
							additionalobjectid = vs_med_id
--							, updatedby = 'CDM-33096_11'
--							, updatedon = now()							
						where documentpropertiesid = vs_documentpropertiesid_update::uuid 
							and additionalobjecttype is null 
							and additionalobjectid is null ;
							
						al_sqlcode := SQLCODE;
						IF al_sqlcode < 0 THEN
							as_mess := 'Error updating documentproperties with for personmedicpshychotropic.';
							al_sqlcode := -1;
							ROLLBACK;
							exit;
						END IF ;	
						
					end if;	
				END LOOP;	
				close cur_documents_update_REFCURSOR;
				
			end if;
	END LOOP;	
	close cur_documents_REFCURSOR;	
	
	-- 12) personphycisianinfo
	RAISE NOTICE 'personphycisianinfo updates';

	OPEN cur_documents_REFCURSOR FOR
		select tab.med_id,
			tab.doctype,
			tab.ecmsdocumentid,
			tab.documentpropertiesid,
			tab.personid,
			tab.cjamspid
		from (
			select pmd.personphycisianinfoid as med_id,
				'personphycisianinfo' as doctype,
				(pmd.uploadpath -> 0 ->> 'ecmsdocumentid')::character varying as ecmsdocumentid,
				(pmd.uploadpath -> 0 ->> 'documentpropertiesid')::character varying as documentpropertiesid,
				pmd.personid,
				pr.cjamspid,
				pmd.insertedon,
				pmd.updatedon
			from personphycisianinfo pmd
				left join person pr on pr.personid = pmd.personid 
			where pmd.activeflag = 1
				and pmd.uploadpath is not null
				and pmd.uploadpath::character varying <> '[]'
				and pmd.personid is not null
			order by pmd.personid 
		) tab
		where tab.documentpropertiesid is not null 
		;
	loop
		fetch cur_documents_REFCURSOR into cur_document_record;
			exit when not found;
		
			-- Reset
			vs_med_id := NULL;
			vs_doctype := NULL;
			vs_ecmsdocumentid := NULL;
			vs_documentpropertiesid := NULL;
			vu_person_id := NULL;
			
			vs_med_id := cur_document_record.med_id;
			vs_doctype := cur_document_record.doctype;
			vs_ecmsdocumentid := cur_document_record.ecmsdocumentid;
			vs_documentpropertiesid := cur_document_record.documentpropertiesid;
			vu_person_id := cur_document_record.personid;
			vl_cjamspid := cur_document_record.cjamspid;
			
			if vs_documentpropertiesid is not NULL then 
			
				OPEN cur_documents_update_REFCURSOR FOR
					select templates.documentpropertiesid
						from personphycisianinfo med,
							jsonb_to_recordset(med.uploadpath::jsonb) 
								AS templates(personid UUID, documentpropertiesid UUID )
					where personphycisianinfoid = vs_med_id::uuid 
					; 
				loop
				fetch cur_documents_update_REFCURSOR into cur_documents_update_record;
				exit when not found;
				
					-- Reset
					vs_documentpropertiesid_update := NULL;
					
					vs_documentpropertiesid_update := cur_documents_update_record.documentpropertiesid;
					
					if vs_documentpropertiesid_update is not NULL then 
					
						RAISE NOTICE 'vs_documentpropertiesid_update >> %', vs_documentpropertiesid_update || ' for ' || vl_cjamspid;
						
						update documentproperties 
						set additionalobjecttype = vs_doctype, 
							additionalobjectid = vs_med_id
--							, updatedby = 'CDM-33096_12'
--							, updatedon = now()							
						where documentpropertiesid = vs_documentpropertiesid_update::uuid 
							and additionalobjecttype is null 
							and additionalobjectid is null ;
							
						al_sqlcode := SQLCODE;
						IF al_sqlcode < 0 THEN
							as_mess := 'Error updating documentproperties with for personphycisianinfo.';
							al_sqlcode := -1;
							ROLLBACK;
							exit;
						END IF ;	
						
					end if;	
				END LOOP;	
				close cur_documents_update_REFCURSOR;
				
			end if;
	END LOOP;	
	close cur_documents_REFCURSOR;	

	
	-- 13) personmedicalcondition
	RAISE NOTICE 'personmedicalcondition updates';

	OPEN cur_documents_REFCURSOR FOR
		select tab.med_id,
			tab.doctype,
			tab.ecmsdocumentid,
			tab.documentpropertiesid,
			tab.personid,
			tab.cjamspid
		from (
			select pmd.personmedicalconditionid as med_id,
				'personmedicalcondition' as doctype,
				(pmd.uploadpath -> 0 ->> 'ecmsdocumentid')::character varying as ecmsdocumentid,
				(pmd.uploadpath -> 0 ->> 'documentpropertiesid')::character varying as documentpropertiesid,
				pmd.personid,
				pr.cjamspid,
				pmd.insertedon,
				pmd.updatedon
			from personmedicalcondition pmd
				left join person pr on pr.personid = pmd.personid 
			where pmd.activeflag = 1
				and pmd.uploadpath is not null
				and pmd.uploadpath::character varying <> '[]'
				and pmd.personid is not null
			order by pmd.personid 
		) tab
		where documentpropertiesid is not null ;	
	loop
		fetch cur_documents_REFCURSOR into cur_document_record;
			exit when not found;
		
			-- Reset
			vs_med_id := NULL;
			vs_doctype := NULL;
			vs_ecmsdocumentid := NULL;
			vs_documentpropertiesid := NULL;
			vu_person_id := NULL;
			
			vs_med_id := cur_document_record.med_id;
			vs_doctype := cur_document_record.doctype;
			vs_ecmsdocumentid := cur_document_record.ecmsdocumentid;
			vs_documentpropertiesid := cur_document_record.documentpropertiesid;
			vu_person_id := cur_document_record.personid;
			vl_cjamspid := cur_document_record.cjamspid;
			
			if vs_documentpropertiesid is not NULL then 
			
				OPEN cur_documents_update_REFCURSOR FOR
					select templates.documentpropertiesid
						from personmedicalcondition med,
							jsonb_to_recordset(med.uploadpath::jsonb) 
								AS templates(personid UUID, documentpropertiesid UUID )
					where personmedicalconditionid = vs_med_id::uuid 
					; 
				loop
				fetch cur_documents_update_REFCURSOR into cur_documents_update_record;
				exit when not found;
				
					-- Reset
					vs_documentpropertiesid_update := NULL;
					
					vs_documentpropertiesid_update := cur_documents_update_record.documentpropertiesid;
					
					if vs_documentpropertiesid_update is not NULL then 
					
						RAISE NOTICE 'vs_documentpropertiesid_update >> %', vs_documentpropertiesid_update || ' for ' || vl_cjamspid;
						
						update documentproperties 
						set additionalobjecttype = vs_doctype, 
							additionalobjectid = vs_med_id
--							, updatedby = 'CDM-33096_13'
--							, updatedon = now()							
						where documentpropertiesid = vs_documentpropertiesid_update::uuid 
							and additionalobjecttype is null 
							and additionalobjectid is null ;
							
						al_sqlcode := SQLCODE;
						IF al_sqlcode < 0 THEN
							as_mess := 'Error updating documentproperties with for personmedicalcondition.';
							al_sqlcode := -1;
							ROLLBACK;
							exit;
						END IF ;	
						
					end if;	
				END LOOP;	
				close cur_documents_update_REFCURSOR;
				
			end if;
	END LOOP;	
	close cur_documents_REFCURSOR;	
	
	-- 14) personhlthmobilityspeech
	RAISE NOTICE 'personhlthmobilityspeech updates';

	OPEN cur_documents_REFCURSOR FOR
		select tab.med_id,
			tab.doctype,
			tab.ecmsdocumentid,
			tab.documentpropertiesid,
			tab.personid,
			tab.cjamspid
		from (
			select pmd.personhlthmobilityspeechid as med_id,
				'personhlthmobilityspeech' as doctype,
				(pmd.uploadpath -> 0 ->> 'ecmsdocumentid')::character varying as ecmsdocumentid,
				(pmd.uploadpath -> 0 ->> 'documentpropertiesid')::character varying as documentpropertiesid,
				pmd.personid,
				pr.cjamspid,
				pmd.insertedon,
				pmd.updatedon
			from personhlthmobilityspeech pmd
				left join person pr on pr.personid = pmd.personid 
			where pmd.activeflag = 1
				and pmd.uploadpath is not null
				and pmd.uploadpath::character varying <> '[]'
				and pmd.personid is not null
			order by pmd.personid 
		) tab
		where tab.documentpropertiesid is not null 
		;	
	loop
		fetch cur_documents_REFCURSOR into cur_document_record;
			exit when not found;
		
			-- Reset
			vs_med_id := NULL;
			vs_doctype := NULL;
			vs_ecmsdocumentid := NULL;
			vs_documentpropertiesid := NULL;
			vu_person_id := NULL;
			
			vs_med_id := cur_document_record.med_id;
			vs_doctype := cur_document_record.doctype;
			vs_ecmsdocumentid := cur_document_record.ecmsdocumentid;
			vs_documentpropertiesid := cur_document_record.documentpropertiesid;
			vu_person_id := cur_document_record.personid;
			vl_cjamspid := cur_document_record.cjamspid;
			
			if vs_documentpropertiesid is not NULL then 
			
				OPEN cur_documents_update_REFCURSOR FOR
					select templates.documentpropertiesid
						from personhlthmobilityspeech med,
							jsonb_to_recordset(med.uploadpath::jsonb) 
								AS templates(personid UUID, documentpropertiesid UUID )
					where personhlthmobilityspeechid = vs_med_id::uuid 
					; 
				loop
				fetch cur_documents_update_REFCURSOR into cur_documents_update_record;
				exit when not found;
				
					-- Reset
					vs_documentpropertiesid_update := NULL;
					
					vs_documentpropertiesid_update := cur_documents_update_record.documentpropertiesid;
					
					if vs_documentpropertiesid_update is not NULL then 
					
						RAISE NOTICE 'vs_documentpropertiesid_update >> %', vs_documentpropertiesid_update || ' for ' || vl_cjamspid;
						
						update documentproperties 
						set additionalobjecttype = vs_doctype, 
							additionalobjectid = vs_med_id
--							, updatedby = 'CDM-33096_14'
--							, updatedon = now()							
						where documentpropertiesid = vs_documentpropertiesid_update::uuid 
							and additionalobjecttype is null 
							and additionalobjectid is null ;
							
						al_sqlcode := SQLCODE;
						IF al_sqlcode < 0 THEN
							as_mess := 'Error updating documentproperties with for personhlthmobilityspeech.';
							al_sqlcode := -1;
							ROLLBACK;
							exit;
						END IF ;
			
					end if;		
				END LOOP;	
				close cur_documents_update_REFCURSOR;
				
			end if;
	END LOOP;	
	close cur_documents_REFCURSOR;	

	
	-- 15) personhlthfeeding
	RAISE NOTICE 'personhlthfeeding updates';

	OPEN cur_documents_REFCURSOR FOR
		select tab.med_id,
			tab.doctype,
			tab.ecmsdocumentid,
			tab.documentpropertiesid,
			tab.personid,
			tab.cjamspid
		from (
			select pmd.personhlthfeedingid as med_id,
				'personhlthfeeding' as doctype,
				(pmd.uploadpath -> 0 ->> 'ecmsdocumentid')::character varying as ecmsdocumentid,
				(pmd.uploadpath -> 0 ->> 'documentpropertiesid')::character varying as documentpropertiesid,
				pmd.personid,
				pr.cjamspid,
				pmd.insertedon,
				pmd.updatedon
			from personhlthfeeding pmd
				left join person pr on pr.personid = pmd.personid 
			where pmd.activeflag = 1
				and pmd.uploadpath is not null
				and pmd.uploadpath::character varying <> '[]'
				and pmd.personid is not null
			order by pmd.personid 
		) tab
		where tab.documentpropertiesid is not null 
		;	
	loop
		fetch cur_documents_REFCURSOR into cur_document_record;
			exit when not found;
		
			-- Reset
			vs_med_id := NULL;
			vs_doctype := NULL;
			vs_ecmsdocumentid := NULL;
			vs_documentpropertiesid := NULL;
			vu_person_id := NULL;
			
			vs_med_id := cur_document_record.med_id;
			vs_doctype := cur_document_record.doctype;
			vs_ecmsdocumentid := cur_document_record.ecmsdocumentid;
			vs_documentpropertiesid := cur_document_record.documentpropertiesid;
			vu_person_id := cur_document_record.personid;
			vl_cjamspid := cur_document_record.cjamspid;
			
			if vs_documentpropertiesid is not NULL then 
			
				OPEN cur_documents_update_REFCURSOR FOR
					select templates.documentpropertiesid
						from personhlthfeeding med,
							jsonb_to_recordset(med.uploadpath::jsonb) 
								AS templates(personid UUID, documentpropertiesid UUID )
					where personhlthfeedingid = vs_med_id::uuid 
					; 
				loop
				fetch cur_documents_update_REFCURSOR into cur_documents_update_record;
				exit when not found;
				
					-- Reset
					vs_documentpropertiesid_update := NULL;
					
					vs_documentpropertiesid_update := cur_documents_update_record.documentpropertiesid;
					
					if vs_documentpropertiesid_update is not NULL then 
					
						RAISE NOTICE 'vs_documentpropertiesid_update >> %', vs_documentpropertiesid_update || ' for ' || vl_cjamspid;
						
						update documentproperties 
						set additionalobjecttype = vs_doctype, 
							additionalobjectid = vs_med_id
--							, updatedby = 'CDM-33096_15'
--							, updatedon = now()							
						where documentpropertiesid = vs_documentpropertiesid_update::uuid 
							and additionalobjecttype is null 
							and additionalobjectid is null ;
							
						al_sqlcode := SQLCODE;
						IF al_sqlcode < 0 THEN
							as_mess := 'Error updating documentproperties with for personhlthfeeding.';
							al_sqlcode := -1;
							ROLLBACK;
							exit;
						END IF ;	
						
					end if;	
				END LOOP;	
				close cur_documents_update_REFCURSOR;
				
			end if;
	END LOOP;	
	close cur_documents_REFCURSOR;	
	*/
	
	-- 2. Saved (Draft) Documents Cleanup  (activeflag = 2)
	
	RAISE NOTICE 'Saved (Draft) Documents Cleanup  (activeflag = 2)';
	
	DROP TABLE IF EXISTS ttb_unsaved_documents CASCADE;
	CREATE TEMPORARY TABLE ttb_unsaved_documents
		( documentpropertiesid uuid,
		  originalfilename character varying, 
		  objectid uuid,
		  -- documentdate timestamp,
		  -- actualdocumentdate timestamp,
		  dps_rank bigint
		) ;
		
		
	OPEN cur_unsaved_documents_REFCURSOR FOR
		select tab.originalfilename, 
			tab.objectid, 
			-- tab.documentdate, 
			-- tab.actualdocumentdate
			(select count(*)
				from documentproperties dps1
			  where dps1.originalfilename = tab.originalfilename
				and dps1.objectid = tab.objectid
				-- and dps1.documentdate = tab.documentdate
				-- and dps1.actualdocumentdate = tab.actualdocumentdate
				and dps1.activeflag = 1
			 ) as active_record_count
		from (
			select distinct dps.originalfilename, 
				dps.objectid 
				-- dps.documentdate, 
				-- dps.actualdocumentdate
				--	RANK() OVER(PARTITION BY dps.originalfilename, dps.objectid, dps.documentdate, dps.actualdocumentdate
				--				ORDER BY dps.insertedon desc
				--	) dps_rank
			from documentproperties dps
			where dps.activeflag = 2
		) tab;
	loop
		fetch cur_unsaved_documents_REFCURSOR into cur_unsaved_document;
		exit when not found;
	
		-- Reset
		vs_originalfilename := NULL;
		vu_objectid := NULL;
		vd_documentdate := NULL;
		vd_actualdocumentdate := NULL;
		vl_active_record_count := NULL;
		
		vs_originalfilename := cur_unsaved_document.originalfilename;
		vu_objectid := cur_unsaved_document.objectid;
		-- vd_documentdate := cur_unsaved_document.documentdate;
		-- vd_actualdocumentdate := cur_unsaved_document.actualdocumentdate;
		vl_active_record_count := cur_unsaved_document.active_record_count;
		
		-- RAISE NOTICE 'vl_cjamspid >> %',vl_cjamspid;
		-- RAISE NOTICE 'vs_servicerequestnumber >> %', vs_actiontype || '' || vs_servicerequestnumber;
		
		If vl_active_record_count > 0 then 
			-- Delete all
			update documentproperties
			set activeflag = 0,
				updatedby = as_user_id,
				updatedon = now()
			where originalfilename = vs_originalfilename
				and objectid = vu_objectid
				-- and documentdate = vd_documentdate
				-- and actualdocumentdate = vd_actualdocumentdate
				and activeflag = 2 ;
		else
			-- Keep the latest and delete remaining 
			delete from ttb_unsaved_documents ;
			
			insert into ttb_unsaved_documents
				( documentpropertiesid,
				  originalfilename, 
				  objectid,
				  -- documentdate,
				  -- actualdocumentdate,
				  dps_rank
				) 
			select dps.documentpropertiesid, 
				dps.originalfilename,
				dps.objectid,
				-- dps.documentdate, 
				-- dps.actualdocumentdate, 
				-- dps.insertedon, 
				-- row_number() OVER() as dps_rank 
				RANK() OVER(PARTITION BY dps.originalfilename, dps.objectid -- , dps.actualdocumentdate -- dps.documentdate 
							ORDER BY dps.insertedon desc, dps.documentpropertiesid
				) dps_rank
				--, dps.activeflag 
			from documentproperties dps
			where dps.originalfilename = vs_originalfilename
				and dps.objectid = vu_objectid
				-- and dps.documentdate = vd_documentdate
				-- and dps.actualdocumentdate = vd_actualdocumentdate
				and dps.activeflag = 2
			order by dps.insertedon desc
			;
			
			OPEN cur_only_unsaved_documents_REFCURSOR FOR
				select documentpropertiesid,
				  originalfilename, 
				  objectid,
				  -- documentdate,
				  -- actualdocumentdate,
				  dps_rank
				from ttb_unsaved_documents
				order by dps_rank; 
			loop
			fetch cur_only_unsaved_documents_REFCURSOR into cur_only_unsaved_document;
				exit when not found;

				-- Reset
				vu_documentpropertiesid := NULL;
				vl_dps_rank := NULL;
				
				vu_documentpropertiesid := cur_only_unsaved_document.documentpropertiesid;
				vl_dps_rank := cur_only_unsaved_document.dps_rank;
				
				-- RAISE NOTICE 'vl_cjamvu_documentpropertiesidspid >> %',vu_documentpropertiesid;
				
				If vl_dps_rank <> 1 then 
					-- Delete 
					update documentproperties
					set activeflag = 0,
						updatedby = as_user_id,
						updatedon = now()
					where documentpropertiesid = vu_documentpropertiesid
						and activeflag = 2 ;
						
					al_sqlcode := SQLCODE;
					IF al_sqlcode < 0 THEN
						as_mess := 'Error deleting the documentproperties record.';
						al_sqlcode := -1;
						ROLLBACK;
						exit;
					END IF ;	
				
				end if;
			END LOOP;	
			
			close cur_only_unsaved_documents_REFCURSOR;	
		end if;
	END LOOP;	
	
	close cur_unsaved_documents_REFCURSOR;	
	
	al_sqlcode := 0;
	as_mess := 'success';
	
	-- DROP TABLE IF EXISTS ttb_document_updates CASCADE;	  
	DROP TABLE IF EXISTS ttb_unsaved_documents CASCADE;	  
	
END;

$function$
;
