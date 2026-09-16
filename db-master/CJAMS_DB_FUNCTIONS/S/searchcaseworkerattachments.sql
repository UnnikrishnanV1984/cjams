DROP FUNCTION if exists  cjams.searchcaseworkerattachments(v_servicecaseid character varying, v_servicerequestid character varying, v_adoptioncaseid character varying, v_objecttypekey character varying, pageno integer, pagesize integer, v_category character varying, v_subcategory character varying, v_sortcol character varying, v_sortorder character varying, v_displayname character varying, v_intakenumber character varying, v_personid character varying, v_doctitle character varying, v_actualdocdate timestamp);
DROP FUNCTION if exists  cjams.searchcaseworkerattachments(v_servicecaseid character varying, v_servicerequestid character varying, v_adoptioncaseid character varying, v_objecttypekey character varying, pageno integer, pagesize integer, v_category character varying, v_subcategory character varying, v_sortcol character varying, v_sortorder character varying, v_displayname character varying, v_intakenumber character varying, v_personid character varying, v_doctitle character varying, v_actualdocdate timestamp, v_activeflag integer);
CREATE OR REPLACE FUNCTION cjams.searchcaseworkerattachments(v_servicecaseid character varying, v_servicerequestid character varying, v_adoptioncaseid character varying, v_objecttypekey character varying, pageno integer, pagesize integer, v_category character varying, v_subcategory character varying, v_sortcol character varying, v_sortorder character varying, v_displayname character varying, v_intakenumber character varying, v_personid character varying, v_doctitle character varying, v_actualdocdate timestamp without time zone, v_activeflag integer DEFAULT 1)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
-------------------------------------------------------------------------------------------
--Revision(s)
--10/17/2022 - Vijaya Laxmi Devunoori - CDM-23734
--	Get all documents to include for the servicerequest from intake
--10/04/2022 - Vijaya Laxmi Devunoori - CDM-17673
--Get all documents to include for the intakeservicecaseId for ServiceCase (Case Connect)
--delete insertedby - duplicated column in the result set
-- 04/12/2023 Umasankar - Adding "other" column to the documentproperties table-- CIDM-6863
--05/04/2023 Umasankar --Adding investigationappeal documents to the documents tab --investigationappeal
--06/09/2023 Umasankar --Adding purchaseAuthReceipt documents to the documents tab --purchaseAuthReceipt--CIDM-7279
-- 06-13-2023 Veera Nadimpalli CIDM-7301 - doc issue
--06-29-2023--Umasankar --To fetch aggreement documents--CIDM-7401
---05/30/2024--Umasankar--CIDM-8847-B-188126--Reverting (Get all documents to include for the intakeservicecaseId for ServiceCase (Case Connect))
--11/12/2024 - Naresh - CDM-42667 - Including offboarded (inactive) users in Uplodedby (displayname)
--02/11/2026 - vamshikri.byreddy - CIDM-11127 - query tuning
---------------------------------------------------------------------------------------------------------------
DECLARE
	jsondata json;

BEGIN

    with base as (
        select dp.*
        from documentproperties dp
        where
            -- active flag logic
            (
                (v_activeflag = 1 and dp.activeflag IN (1,3,4,5))
                or (v_activeflag <> 1 and dp.activeflag = v_activeflag)
            )
            -- main object filters
            and (
                (v_servicecaseid IS NOT NULL and
                    dp.servicecaseid = v_servicecaseid::uuid
                    and (dp.objecttypekey = v_objecttypekey
                         or dp.objecttypekey IN (
                             'CasePerson','courtorder','gapagreement','gapapplication',
                             'AdoptionSubsidy','investigationappeal','purchaseAuthReceipt'
                         ))
                )
                or (v_adoptioncaseid IS NOT NULL and
                    (dp.objectid = v_adoptioncaseid::uuid
                     or dp.servicecaseid = v_adoptioncaseid::uuid)
                )
                or (v_servicerequestid IS NOT NULL and
                    (
                        dp.servicerequestid = v_servicerequestid::uuid
                        or dp.intakenumber = (
                            select intakenumber
                            from intakeservicerequest i
                            where i.intakeserviceid = v_servicerequestid::uuid
                              and i.activeflag = 1
                            order by i.updatedon DESC
                            limit 1
                        )
                    )
                )
                or (v_intakenumber IS NOT NULL
                    and v_objecttypekey = 'ServiceRequest'
                    and dp.intakenumber = v_intakenumber
                )
                or (v_personid IS NOT NULL and
                    (
                        (dp.objecttypekey = 'Person' and dp.objectid = v_personid::uuid)
                        or (dp.objecttypekey = 'CasePerson' and dp.objectid = v_personid::uuid)
                    )
                )
                or (
                    v_servicecaseid IS NULL
                    and v_adoptioncaseid IS NULL
                    and v_servicerequestid IS NULL
                    and v_intakenumber IS NULL
                    and v_personid IS NULL
                )
            )
            -- title filter
            and (
                v_doctitle is null or v_doctitle = ''
                or dp.title ILIKE '%' || v_doctitle || '%'
            )
            -- actual document date filter
            and (
                v_actualdocdate IS NULL
                or date(dp.actualdocumentdate) = date(v_actualdocdate)
            )
            -- category / subcategory filters via EXISTS on documentattachment
            and (
                v_category is null or v_category = ''
                or exists (
                    select 1
                    from documentattachment da1
                    where da1.documentpropertiesid = dp.documentpropertiesid
                      and da1.activeflag = v_activeflag
                      and da1.attachmentclassificationtypekey = ANY (v_category::text[])
                )
            )
            and (
                v_subcategory is null or v_subcategory = ''
                or exists (
                    select 1
                    from documentattachment da2
                    where da2.documentpropertiesid = dp.documentpropertiesid
                      and da2.activeflag = v_activeflag
                      and da2.attachmentclassificationsubtypekey = ANY (v_subcategory::text[])
                )
            )
            -- display name filter via userprofile
            AND (
                v_displayname is null or v_displayname = ''
                or exists (
                    select 1
                    from userprofile upf
                    where upf.securityusersid = dp.insertedby
                      and upf.fullname ILIKE '%' || v_displayname || '%'
                )
            )
    ),
    count_cte as (
        select COUNT(*) as total_count
        from base
    ),
    paged as (
    select
        dp.*
    from
        base dp
    order by
        case
            when v_sortorder = 'asc' THEN case
                v_sortcol
                when 'title' then COALESCE(dp.title, '')
                when 'documenttypekey' then COALESCE(dp.documenttypekey, '')
                when 'insertedon' then dp.insertedon :: character varying
                when 'updatedon' then dp.updatedon :: character varying
                when 'insertedby' then COALESCE(dp.insertedby :: text, '')
                when 'updatedby' then COALESCE(dp.updatedby :: text, '')
                when 'documentdate' then dp.documentdate :: character varying
                when 'mime' then COALESCE(dp.mime, '')
                when 'description' then COALESCE(dp.description, '')
                when 'other' then COALESCE(dp.other, '')
                when 'filename' then COALESCE(dp.filename, '')
                when 'originalfilename' then COALESCE(dp.originalfilename, '')
                when 'actualdocumentdate' then COALESCE(dp.actualdocumentdate :: character varying, '')
                else dp.updatedon :: character varying
            end
            else null
        END ASC,
        case
            when v_sortorder = 'desc' THEN case 
            v_sortcol
            when 'title' then COALESCE(dp.title, '')
            when 'documenttypekey' then COALESCE(dp.documenttypekey, '')
            when 'insertedon' then dp.insertedon :: character varying
            when 'updatedon' then dp.updatedon :: character varying
            when 'insertedby' then COALESCE(dp.insertedby :: text, '')
            when 'updatedby' then COALESCE(dp.updatedby :: text, '')
            when 'documentdate' then dp.documentdate :: character varying
            when 'mime' then COALESCE(dp.mime, '')
            when 'description' then COALESCE(dp.description, '')
            when 'other' then COALESCE(dp.other, '')
            when 'filename' then COALESCE(dp.filename, '')
            when 'originalfilename' then COALESCE(dp.originalfilename, '')
            when 'actualdocumentdate' then COALESCE(dp.actualdocumentdate :: character varying, '')
            else dp.updatedon :: character varying
        end
        else NULL
end DESC
limit
    pagesize OFFSET (pageno - 1) * pagesize
)
    select
    json_agg(
        json_build_object(
            'count',
            (
                select
                    total_count
                from
                    count_cte
            ),
            'documentpropertiesid',
            dp.documentpropertiesid,
            'objecttypekey',
            dp.objecttypekey,
            'title',
            dp.title,
            'documenttypekey',
            dp.documenttypekey,
            'insertedon',
            dp.insertedon,
            'updatedon',
            dp.updatedon,
            'insertedby',
            up.fullname,
            'updatedby',
            dp.updatedby,
            'documentdate',
            dp.documentdate,
            'mime',
            dp.mime,
            's3bucketpathname',
            dp.s3bucketpathname,
            'description',
            dp.description,
            'other',
            dp.other,
            'filename',
            dp.filename,
            'numberofbytes',
            dp.numberofbytes,
            'originalfilename',
            dp.originalfilename,
            'servicecaseid',
            dp.servicecaseid,
            'displayname',
            up.displayname,
            'ecmsdocumentid',
            dp.ecmsdocumentid,
            'actualdocumentdate',
            dp.actualdocumentdate,
            'activeflag',
            dp.activeflag,
            'uploadstatus',
            dp.uploadstatus,
            'finalstatus',
            dp.finalstatus,
            'documentattachment',
            att.attachments,
            'userprofile',
            usrin.userprofilein,
            'updateduserprofile',
            usrup.userprofileup
        )
    ) into jsondata
from
    paged dp
    left join lateral (
        select
            json_agg(
                json_build_object(
                    'documentpropertiesid',
                    da.documentpropertiesid,
                    'attachmenttypekey',
                    da.attachmenttypekey,
                    'attachmentclassificationtypekey',
                    da.attachmentclassificationtypekey,
                    'assessmenttemplateid',
                    da.assessmenttemplateid,
                    'attachmentclassificationsubtypekey',
                    da.attachmentclassificationsubtypekey,
                    'activeflag',
                    da.activeflag
                )
            ) as attachments
        from
            documentattachment da
        where
            da.documentpropertiesid = dp.documentpropertiesid
            and da.activeflag = v_activeflag
    ) att ON TRUE
    left join lateral (
        select
            json_agg(
                json_build_object(
                    'securityusersid',
                    upinserted.securityusersid,
                    'firstname',
                    upinserted.firstname,
                    'lastname',
                    upinserted.lastname,
                    'displayname',
                    upinserted.displayname,
                    'fullname',
                    upinserted.fullname
                )
            ) as userprofilein
        from
            userprofile upinserted
        where
            upinserted.securityusersid = dp.insertedby
    ) usrin ON TRUE
    left join lateral (
        select
            json_agg(
                json_build_object(
                    'securityusersid',
                    upupdated.securityusersid,
                    'firstname',
                    upupdated.firstname,
                    'lastname',
                    upupdated.lastname,
                    'displayname',
                    upupdated.displayname
                )
            ) as userprofileup
        from
            userprofile upupdated
        where
            upupdated.securityusersid = dp.updatedby
    ) usrup ON TRUE
    left join userprofile up on up.securityusersid = dp.insertedby;

return jsondata;
end;
$function$;