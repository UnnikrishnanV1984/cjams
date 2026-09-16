-- FUNCTION: cjams.sp_cares_outbound_interface_gen_data(integer, character varying, character varying, integer, timestamp without time zone)
DROP FUNCTION if exists sp_cares_outbound_interface_gen_data_rev(integer, bigint, character varying, integer, timestamp without time zone);

create or replace
function sp_cares_outbound_interface_gen_data(vl_client_id integer,
vl_other_id bigint,
vs_transaction_type_cd character varying,
vl_transaction_sequence integer,
vd_transaction_ts timestamp without time zone,
VL_SERVICECASENUMBER	varchar,
VL_ADOPTIONCASENUMBER	varchar,-- new variable 
out vs_message character varying,
out vl_output_sqlcode character varying) returns record language plpgsql as $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Author: Sudhin
-- Date Created :08/01/2005
-- generates Cares Interface Outbound Data
------------------------------------------------------------------------
 declare VS_EXCEP_MESSAGE varchar;
begin
VS_EXCEP_MESSAGE := '';


RAISE NOTICE 'INPUT FOR GEN DATA  '; 
			RAISE NOTICE 'VL_CLIENT_ID %',VL_CLIENT_ID; 
			RAISE NOTICE 'vl_other_id %',vl_other_id; 
			RAISE NOTICE 'VS_TRANSACTION_TYPE_CD %',VS_TRANSACTION_TYPE_CD; 
			RAISE NOTICE 'VL_TRANSACTION_SEQUENCE %',VL_TRANSACTION_SEQUENCE; 
			RAISE NOTICE 'VD_TRANSACTION_TS %',VD_TRANSACTION_TS; 
			RAISE NOTICE 'VL_SERVICECASENUMBER %',VL_SERVICECASENUMBER; 
			RAISE NOTICE 'VL_ADOPTIONCASENUMBER %',VL_ADOPTIONCASENUMBER; 

select
	* into
		VS_MESSAGE,
		VL_OUTPUT_SQLCODE
	from
		SP_CARES_OUTBOUND_INTERFACE_GEN_DATA_01(VL_CLIENT_ID,
		VL_OTHER_ID,
		VS_TRANSACTION_TYPE_CD,
		VL_TRANSACTION_SEQUENCE,
		VD_TRANSACTION_TS);
--
 if VL_OUTPUT_SQLCODE <> '00000' then VS_EXCEP_MESSAGE := '01-' || VS_MESSAGE || ';' ;
--
-- RETURN;--
end if ;
--
 select
	* into
		VS_MESSAGE,
		VL_OUTPUT_SQLCODE
	from
		SP_CARES_OUTBOUND_INTERFACE_GEN_DATA_10(VL_CLIENT_ID,
		VL_OTHER_ID,
		VS_TRANSACTION_TYPE_CD,
		VL_TRANSACTION_SEQUENCE,
		VD_TRANSACTION_TS);
--
 if VL_OUTPUT_SQLCODE <> '00000' then VS_EXCEP_MESSAGE := '10-' || VS_MESSAGE || ';' ;
--
--RETURN ;--
end if ;
--
 select
	* into
		VS_MESSAGE,
		VL_OUTPUT_SQLCODE
	from
		SP_CARES_OUTBOUND_INTERFACE_GEN_DATA_15(VL_CLIENT_ID,
		VL_OTHER_ID,
		VS_TRANSACTION_TYPE_CD,
		VL_TRANSACTION_SEQUENCE,
		VD_TRANSACTION_TS);
--
 if VL_OUTPUT_SQLCODE <> '00000' then VS_EXCEP_MESSAGE := '15-' || VS_MESSAGE || ';' ;
--
-- RETURN;--
end if ;
--
 select
	* into
		VS_MESSAGE,
		VL_OUTPUT_SQLCODE
	from
		SP_CARES_OUTBOUND_INTERFACE_GEN_DATA_20(VL_CLIENT_ID,
		VL_OTHER_ID,
		VS_TRANSACTION_TYPE_CD,
		VL_TRANSACTION_SEQUENCE,
		VD_TRANSACTION_TS);
--
 if VL_OUTPUT_SQLCODE <> '00000' then VS_EXCEP_MESSAGE := '20-' || VS_MESSAGE || ';' ;
--
--RETURN ;--
end if ;
--
 select
	* into
		VS_MESSAGE,
		VL_OUTPUT_SQLCODE
	from
		SP_CARES_OUTBOUND_INTERFACE_GEN_DATA_25(VL_CLIENT_ID,
		VL_OTHER_ID,
		VS_TRANSACTION_TYPE_CD,
		VL_TRANSACTION_SEQUENCE,
		VD_TRANSACTION_TS);
--
 if VL_OUTPUT_SQLCODE <> '00000' then VS_EXCEP_MESSAGE := '25-' || VS_MESSAGE || ';' ;
--
--RETURN ;--
end if ;
--
 select
	* into
		VS_MESSAGE,
		VL_OUTPUT_SQLCODE
	from
		SP_CARES_OUTBOUND_INTERFACE_GEN_DATA_30(VL_CLIENT_ID,
		VL_OTHER_ID,
		VS_TRANSACTION_TYPE_CD,
		VL_TRANSACTION_SEQUENCE,
		VD_TRANSACTION_TS);
--
 if VL_OUTPUT_SQLCODE <> '00000' then VS_EXCEP_MESSAGE := '30-' || VS_MESSAGE || ';' ;
--
--RETURN ;--
end if ;
--
 select
	* into
		VS_MESSAGE,
		VL_OUTPUT_SQLCODE
	from
		SP_CARES_OUTBOUND_INTERFACE_GEN_DATA_35(VL_CLIENT_ID,
		VL_OTHER_ID,
		VS_TRANSACTION_TYPE_CD,
		VL_TRANSACTION_SEQUENCE,
		VD_TRANSACTION_TS);
--
 if VL_OUTPUT_SQLCODE <> '00000' then VS_EXCEP_MESSAGE := '35-' || VS_MESSAGE || ';' ;
--
--RETURN ;--
end if ;
--
 select
	* into
		VS_MESSAGE,
		VL_OUTPUT_SQLCODE
	from
		SP_CARES_OUTBOUND_INTERFACE_GEN_DATA_40(VL_CLIENT_ID,
		VL_OTHER_ID,
		VS_TRANSACTION_TYPE_CD,
		VL_TRANSACTION_SEQUENCE,
		VD_TRANSACTION_TS);
--
 if VL_OUTPUT_SQLCODE <> '00000' then VS_EXCEP_MESSAGE := '40-' || VS_MESSAGE || ';' ;
--
--RETURN ;--
end if ;
--
 select
	* into
		VS_MESSAGE,
		VL_OUTPUT_SQLCODE
	from
		SP_CARES_OUTBOUND_INTERFACE_GEN_DATA_45(VL_CLIENT_ID,
		VL_OTHER_ID,
		VS_TRANSACTION_TYPE_CD,
		VL_TRANSACTION_SEQUENCE,
		VD_TRANSACTION_TS);
--
 if VL_OUTPUT_SQLCODE <> '00000' then VS_EXCEP_MESSAGE := '45-' || VS_MESSAGE || ';' ;
--
--RETURN ;--
end if ;
--
 select
	* into
		VS_MESSAGE,
		VL_OUTPUT_SQLCODE
	from
		SP_CARES_OUTBOUND_INTERFACE_GEN_DATA_50(VL_CLIENT_ID,
		VL_OTHER_ID,
		VS_TRANSACTION_TYPE_CD,
		VL_TRANSACTION_SEQUENCE,
		VD_TRANSACTION_TS);
--
 if VL_OUTPUT_SQLCODE <> '00000' then VS_EXCEP_MESSAGE := '50-' || VS_MESSAGE || ';' ;
--
--RETURN ;--
end if ;
--
 select
	* into
		VS_MESSAGE,
		VL_OUTPUT_SQLCODE
	from
		SP_CARES_OUTBOUND_INTERFACE_GEN_DATA_55(VL_CLIENT_ID,
		VL_OTHER_ID,
		VS_TRANSACTION_TYPE_CD,
		VL_TRANSACTION_SEQUENCE,
		VD_TRANSACTION_TS,
		VL_SERVICECASENUMBER,
		VL_ADOPTIONCASENUMBER); -- passing the new variable 
--
 if VL_OUTPUT_SQLCODE <> '00000' then VS_EXCEP_MESSAGE := '55-' || VS_MESSAGE || ';' ;
--
--RETURN ;--
end if ;
--
 if VS_EXCEP_MESSAGE <> '' then VS_EXCEP_MESSAGE := 'FAILED TO GENERATE INTERFACE DATA FOR RECORD TYPE(s):' || VS_EXCEP_MESSAGE || ' AND CLIENT_ID:' || VL_CLIENT_ID::varchar;

raise exception '%',
VS_EXCEP_MESSAGE;
else VL_OUTPUT_SQLCODE = '00000' ;
--
 VS_MESSAGE := 'THE RUN WAS SUCCESSFUL.' ;
--
end if;
end ;

$function$ ;

alter function sp_cares_outbound_interface_gen_data(integer,
character varying,
character varying,
integer,
timestamp without time zone) owner to welfareadmin;
