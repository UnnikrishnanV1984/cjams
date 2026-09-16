CREATE OR REPLACE FUNCTION cjams.sp_audit_log_change_history_account_receivable(v_screenid bigint, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

DECLARE  

	v_pagenumber int;
	v_pageoffset int;
    accreceivableLog json;
    ll_revision_key_id int;
    ls_revision_type_cd varchar;
    ll_transaction_id bigint;
BEGIN 
	
v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;

-- 1007 - Receivable
SELECT FA.event_id AS REVISION_ID,
	   FA.event_type_cd AS CHANGE_TYPE_CD
INTO ll_revision_key_id,
	 ls_revision_type_cd
FROM TB_FISCAL_AUDIT_TRAIL FA,
		TB_FISCAL_AUDIT_TRAIL_ENTITY_LINK FL
WHERE FA.FISCAL_AUDIT_TRAIL_ID = FL.FISCAL_AUDIT_TRAIL_ID
	AND FL.ENTITY_ID = v_screenid
	AND FL.ENTITY_TYPE_CD = '1007'
	AND FA.DELETE_SW = 'N'
	AND FL.DELETE_SW = 'N' limit 1;

raise notice 'll_revision_key_id%',ll_revision_key_id;
raise notice 'ls_revision_type_cd%',ls_revision_type_cd;

IF ll_revision_key_id > 0 then 
   IF ls_revision_type_cd = '1001' then --Placement changes

   ll_transaction_id := ll_revision_key_id;
  -- SELECT alternateid into ll_transaction_id from placementrevision where alternateid = ll_revision_key_id and activeflag=1;
  
 		  if (ll_transaction_id is null) then 
   	 		accreceivableLog := '{"accreceivableLog":"Error in getting Placement ID from Placement Revision"}';
  		 else   
    		select sp_audit_log_placement_changes into accreceivableLog from sp_audit_log_placement_changes(ll_transaction_id,v_lipagenumber,v_lipagesize);
  		 end if;
  
   end if;
  
     IF ls_revision_type_cd = '1004' then --Placement void
     
--    	 SELECT pr.alternateid into ll_transaction_id from placementrevision pr 
-- 		 inner join tb_placement tp on tp.placementid= pr.placementid and tp.void_sw='Y' 
--		 where pr.alternateid = ll_revision_key_id and pr.activeflag=1;
    	
     ll_transaction_id := ll_revision_key_id;
    
   		if (ll_transaction_id is null) then 
    		accreceivableLog := '{"accreceivableLog":"Error in getting Placement ID from Placement Revision Void"}';
  	 	else 
   			select sp_audit_log_placement_changes into accreceivableLog from sp_audit_log_placement_changes(ll_transaction_id,v_lipagenumber,v_lipagesize);
   		end if;
   	
     end if;
  
    
    IF ls_revision_type_cd = '1002' then --Foster care rate changes
  -- SELECT placementid into ll_transaction_id from placementrevision where alternateid = REVISION_ID and isvoided=1 and activeflag=1;
 --  if (ll_transaction_id is null) then 
    accreceivableLog := '{"accreceivableLog":"Error in getting RATE ID from FC Rate Revision"}';
  -- else 
   --select sp_audit_log_placement_changes into accreceivableLog from sp_audit_log_placement_changes(ll_transaction_id,v_pagenumber,v_pageoffset);
  -- end if;
   end if;
  
  
    IF ls_revision_type_cd = '1011' then --GAP Rate Changes
    
--       select gap.alternateid into ll_transaction_id from gapratesrevision gr 
--       inner join guardianship gap on gap.gapid = gr.guardiansubsidyid
--       where gr.alternateid = ll_revision_key_id and gr.activeflag=1;
		ll_transaction_id := ll_revision_key_id;
      
  			if (ll_transaction_id is null) then 
    			accreceivableLog := '{"accreceivableLog":"Error in getting GAP_RATE_ID from GAP  Rate Revision"}';
  			else 
   				select sp_audit_log_gaprate_changes into accreceivableLog from sp_audit_log_gaprate_changes(ll_transaction_id,v_lipagenumber,v_lipagesize);
   			end if;
   		
    end if;
  
   
    IF ls_revision_type_cd = '1012' then --GAP Suspension Changes
    
--  		select gap.alternateid into ll_transaction_id from gapsuspensionrevision gs
--  	    inner join guardiansubsidy ga on gs.suspensionid = ga.gapsuspensionid
--  	    inner join guardianship gap on gap.gapid = gs.guardiansubsidyid
--  		where gs.alternateid = ll_revision_key_id and gs.activeflag=1;

    	ll_transaction_id := ll_revision_key_id;
  	
  			if (ll_transaction_id is null) then 
    			accreceivableLog := '{"accreceivableLog":"Error in getting SUSPENSION_ID from GAP  Suspension Revision"}';
  			else 
   				select sp_audit_log_gapsuspension_changes into accreceivableLog from sp_audit_log_gapsuspension_changes(ll_transaction_id,v_lipagenumber,v_lipagesize);
   			end if;
   		
   end if;
  
    IF ls_revision_type_cd = '1013' then --Adoption Subsidy Rate Changes
    
--  		select acd.alternateid into ll_transaction_id from adoptioncaserevision ar
--  		inner join adoptioncaseagreementrate aca on  ar.agreementrateid = aca.adoptionagreementrateid
--  		inner join adoptioncaseagreement acaa on  aca.adoptionagreementid = acaa.adoptionagreementid
--  		inner join adoptioncase acd on  acaa.adoptioncaseid =  acd.adoptioncaseid
--  	    where ar.alternateid = ll_revision_key_id and ar.activeflag=1;
	ll_transaction_id := ll_revision_key_id;
  	
  			if (ll_transaction_id is null) then 
   				 accreceivableLog := '{"accreceivableLog":"Error in getting SUBSIDY_AGREEMENT_ID from Adoption Subsidy Rate  Revision"}';
  			else 
   				select sp_audit_log_adoptionrate_changes into accreceivableLog from sp_audit_log_adoptionrate_changes(ll_transaction_id,v_lipagenumber,v_lipagesize);
   			end if;
   		
   end if;

     IF ls_revision_type_cd = '1014' then --Adoption Subsidy Suspension Changes
    
--  		select acd.alternateid into ll_transaction_id from adoptioncasesuspensionrevision asr 
--  		inner join adoptioncasesuspension acs on asr.adoptionsuspensionid = acs.adoptionsuspensionid
--  		inner join adoptioncase acd on acs.adoptioncaseid = acd.adoptioncaseid
--  	    where asr.alternateid = ll_revision_key_id and activeflag=1;
--  	
	ll_transaction_id := ll_revision_key_id;
  			if (ll_transaction_id is null) then 
   				 accreceivableLog := '{"accreceivableLog":"Error in getting SUBSIDY_AGREEMENT_ID from Adoption Subsidy Suspension  Revision"}';
  			else 
   				select sp_audit_log_adoptionsuspension_changes into accreceivableLog from sp_audit_log_adoptionsuspension_changes(ll_transaction_id,v_lipagenumber,v_lipagesize);
   			end if;
   		
   end if;
  
else 
  
 accreceivableLog:= '{"accreceivableLog":"Failure"}'; 

end if;




return accreceivableLog; 

END;
$function$
