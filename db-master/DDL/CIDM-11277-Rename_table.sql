-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Revision(s)
-- 06/05/2026 Varun Venugopal - CIDM-11277 - Create statements related to implementing the backup
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE cjams.tb_placement_revision_old RENAME TO tb_placement_revision_old_06172026; 
ALTER TABLE cjams.city RENAME TO city_06172026;
ALTER TABLE cjams.county_fcrate RENAME TO county_fcrate_06172026;
ALTER TABLE cjams.interfaceafspaymentoutbound RENAME TO interfaceafspaymentoutbound_06172026;
ALTER TABLE cjams.interfaceafsvendoroutbound RENAME TO interfaceafsvendoroutbound_06172026;
ALTER TABLE cjams.interfacescaresoutbound RENAME TO interfacescaresoutbound_06172026;
ALTER TABLE cjams.interfacescsesoutboundtrigger RENAME TO interfacescsesoutboundtrigger_06172026;
ALTER TABLE cjams.msdeextract_batchrun_data RENAME TO msdeextract_batchrun_data_06172026;
--ALTER TABLE cjams.neiceproviderreferral RENAME TO neiceproviderreferral_06172026;
ALTER TABLE cjams.petitionwitnessclients RENAME TO petitionwitnessclients_06172026;
ALTER TABLE cjams.subcategoryid RENAME TO subcategoryid_06172026;
ALTER TABLE cjams.tb_conv_county_codes RENAME TO tb_conv_county_codes_06172026;
ALTER TABLE cjams.tb_county_specific_unov RENAME TO tb_county_specific_unov_06172026;
ALTER TABLE cjams.tb_distinct_client_fnms RENAME TO tb_distinct_client_fnms_06172026;
ALTER TABLE cjams.tb_distinct_client_lnms RENAME TO tb_distinct_client_lnms_06172026;
ALTER TABLE cjams.tb_guardian_subsidy_delete RENAME TO tb_guardian_subsidy_delete_06172026;
ALTER TABLE cjams.tb_payment_detail_temp_del RENAME TO tb_payment_detail_temp_del_06172026;
ALTER TABLE cjams.tb_payment_status_fss RENAME TO tb_payment_status_fss_06172026;
ALTER TABLE cjams.tb_search_client RENAME TO tb_search_client_06172026;
ALTER TABLE cjams.zipcode RENAME TO zipcode_06172026;
DROP TABLE cjams.as_eicm_interface_1031;
ALTER TABLE cjams.ischildincare RENAME TO ischildincare_06172026;
ALTER TABLE cjams.targetid RENAME TO targetid_06172026;
ALTER TABLE cjams.test1 RENAME TO test1_06172026; 
ALTER TABLE cjams.v_countyid RENAME TO v_countyid_06172026;
ALTER TABLE cjams.v_intakejson RENAME TO v_intakejson_06172026;
ALTER TABLE cjams.v_isractorid RENAME TO v_isractorid_06172026;
ALTER TABLE cjams.vl_checklist_cnt RENAME TO vl_checklist_cnt_06172026;
ALTER TABLE cjams.vl_count RENAME TO vl_count_06172026;
ALTER TABLE cjams.vl_locn_add_id RENAME TO vl_locn_add_id_06172026;
ALTER TABLE cjams.v_notifystatus RENAME TO v_notifystatus_06172026;
ALTER TABLE cjams.v_payment_detail_id RENAME TO v_payment_detail_id_06172026;
ALTER TABLE cjams.v_permanencyplanid RENAME TO v_permanencyplanid_06172026;
ALTER TABLE cjams.v_role RENAME TO v_role_06172026;
ALTER TABLE cjams.v_teamdetails RENAME TO v_teamdetails_06172026;
ALTER TABLE cjams.v_teamid RENAME TO v_teamid_06172026;
ALTER TABLE cjams.v_username RENAME TO v_username_06172026; 
DROP TABLE cjams."vwda-1a_11292023";
DROP TABLE cjams."vwda-1a-ra_11292023";
DROP TABLE prov.providerstaff_09162022;
DROP TABLE prov.providerstaffconfig_20250226;
DROP TABLE prov.tb_provider_0829_cidm10776;

 
