Drop function if exists public.createdynamnicuserprofile(v_provider_referral_id text);
DROP FUNCTION  IF EXISTS createnewuser3(v_email character varying(100),v_firstname character varying(50),v_lastname character varying(50),v_middlename Character varying,v_fullname Character varying,v_agencycode character varying(5),v_roletypekey character varying(15),v_countycd Character varying,
                                        v_teamcode Character varying,v_teamname character varying(50),	v_ldss Character varying,v_add1	Character varying,v_city Character varying,v_zipcode Character varying,v_phonenumber Character varying,v_staffid Character varying,v_positioncode Character varying,v_positiontitle	Character varying);          
Drop function if exists public.createuserbackend(sfirstname character varying, slastname character varying, semail character varying, steamtypekey character varying, nuserid bigint);
DROP FUNCTION IF EXISTS public.insert_user_data_provider(username character varying, firstname character varying, lname character varying, email character varying, teamtypekey character varying, rolenamex character varying, roletypecode character varying, roletypename character varying, shortname character varying, roletypecodexx character varying, teamname character varying, teamtypecode character varying);
DROP FUNCTION IF EXISTS public.bk_sp_list_payable_approvels(v_securityid character varying, v_role character varying, v_approveltype character varying, pagenumber bigint, pagesize bigint);
DROP FUNCTION IF EXISTS public.search_columns(needle text, haystack_tables name[], haystack_schema name[]);
DROP FUNCTION IF EXISTS public.sp_list_payable_approvelstest(v_securityid character varying, v_role character varying, v_approveltype character varying, v_status character varying, pagenumber bigint, pagesize bigint);
DROP FUNCTION IF EXISTS cjams.test_sp_list_payable_approvels(IN v_securityid character varying, IN v_role character varying, IN v_approveltype character varying, IN v_status character varying, IN pagenumber bigint, IN pagesize bigint);
DROP FUNCTION IF EXISTS public.usersservicerequest_cnt(userid character varying);
DROP FUNCTION IF EXISTS public.createdynamicproviderapplicant(userdada json); 
DROP FUNCTION IF EXISTS cjams.fn_client_investigation_ins();
DROP FUNCTION IF EXISTS cjams.fn_client_participation_ins();
DROP FUNCTION IF EXISTS cjams.posturl(character varying, character varying, json);
