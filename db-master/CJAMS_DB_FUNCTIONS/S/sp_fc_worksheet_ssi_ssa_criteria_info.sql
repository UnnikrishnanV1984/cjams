DROP FUNCTION IF EXISTS cjams.sp_fc_worksheet_ssi_ssa_criteria_info(al_client_id bigint, al_removal_id bigint, al_period_type character varying);
CREATE OR REPLACE FUNCTION cjams.sp_fc_worksheet_ssi_ssa_criteria_info(al_client_id bigint, al_removal_id bigint, al_period_type character varying)
 RETURNS TABLE(ivessissadataid uuid, childreceivingssiorssa character varying,
  suspendssipaymentflag character varying, agencyrepresentativeflag character varying,
   notefornotsuspendingssi character varying, noteforagencynotaspayee character varying,
    representativepayee character varying, activeflag integer, clientid bigint, removalid integer,
	 doesagencyhasmedicaldocstostateincapabilityofchild character varying, hasagencyapplytobecomerepresentativepayee character varying,
	  typeofbenefit character varying, amountofbenefit integer, dateofmedicaldetermination timestamp without time zone,
	   dateofapplicationtobecomerepresentativepayee timestamp without time zone, dateofrequesttosuspendthessipaymentandclaimive 
	   timestamp without time zone, ischildageabove18 character varying, detperiodtype character varying, infoaboutincomenresources character varying, incomeresourcesverification character varying, issillaagreementvalid character varying,issilayouth character varying, silaagreementdate timestamp without time zone, citizenshipverification character varying, ageverification character varying, assetinfoverification character varying,  ssissainfoverification character varying, homeassessmentverification character varying, vpasprverification character varying)
	    LANGUAGE plpgsql

 
--------------------------------------------------------------------
-- B-97901 CIDM-8153 11-13 CJAMS-CW-IV-E - SILA youth and placement updates _ Veera Nadimpalli
-------------------------------------------------------------------


AS $function$ 
BEGIN 
	RETURN QUERY 
	SELECT 
 	  ives.ivessissadataid, 
	  ives.childreceivingssiorssa::varchar, 
	  ives.suspendssipaymentflag::varchar, 
	  ives.agencyrepresentativeflag::varchar, 
	  ives.notefornotsuspendingssi, 
	  ives.noteforagencynotaspayee, 
	  ives.representativepayee, 
	  ives.activeflag, 
	  ives.clientid, 
	  ives.removalid, 
	  ives.doesagencyhasmedicaldocstostateincapabilityofchild::varchar, 
	  ives.hasagencyapplytobecomerepresentativepayee::varchar, 
	  ives.typeofbenefit, 
	  ives.amountofbenefit, 
	  ives.dateofmedicaldetermination, 
	  ives.dateofapplicationtobecomerepresentativepayee, 
	  ives.dateofrequesttosuspendthessipaymentandclaimive,
	  ives.ischildageabove18::varchar,
      ives.detperiodtype, 
      ives.infoaboutincomenresources,
      ives.incomeresourcesverification,
      ives.issillaagreementvalid,
	  ives.issilayouth,
      ives.silaagreementdate,
      ives.citizenshipverification,
      ives.ageverification,
      ives.assetinfoverification,
      ives.ssissainfoverification,
	  ives.homeassessmentverification,
      ives.vpasprverification
	FROM 
	  ivessissadata ives
	where 
	  ives.clientid = al_client_id and ives.removalid = al_removal_id and ives.detperiodtype = al_period_type;
	END 
$function$