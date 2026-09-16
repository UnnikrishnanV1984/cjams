CREATE OR REPLACE FUNCTION cjams.getprovidercomplaintdetails(v_complaint_number character varying)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

DECLARE  

jsondata  json;
BEGIN

SELECT  Json_agg(a)  INTO      jsondata  FROM      (  

SELECT TPC.provider_complaintid, TPC.intakeservreqinputtypeid, TPC.complaint_source,
TPC.source_information_type, TPC.complaint_date, TPC.narrative,
TPC.complainant_firstname, TPC.complainant_lastname, TPC.complainant_phone,
TPC.complainant_email, TPC.complainant_address1, TPC.complainant_address2,
TPC.complainant_city, TPC.complainant_state, TPC.complainant_county,
TPC.isrouted, TPC.complaint_number, TPC.routedon, TPC.teamtype_key, TPC.provider_id,
TPC.site_id, TPC.is_draft, TPC.complainant_zipcode, TPC.source_specification, 
TPC.inserted_on,TPC.inserted_by,ISRIT.description as comminucationtype,
RV.description as sourceinformation, COU.countyname as county,rst.typedescription as statusdescription,
TPC.updated_on,TPC.updated_by,
up.displayname,rst.routingstatustypekey as status,TPC.outcomes,TPC.summary,TPC.investigationenddate,TPC.investigationstartdate
FROM cjams.tb_provider_complaint TPC 
left join intakeservicerequestinputtype ISRIT on ISRIT.intakeservreqinputtypeid=TPC.intakeservreqinputtypeid and ISRIT.activeflag=1
left join referencevalues RV on RV.ref_key=TPC.source_information_type and RV.activeflag=1
left join county COU on COU.countyid=TPC.complainant_county
left join routingstatustype rst on rst.sequencenumber=tpc.complaint_status::integer
left join userprofile up on up.securityusersid=tpc.inserted_by

where TPC.complaint_number=v_complaint_number and TPC.activeflag=1


		 )  a;

RETURN  jsondata;
END;

$function$
