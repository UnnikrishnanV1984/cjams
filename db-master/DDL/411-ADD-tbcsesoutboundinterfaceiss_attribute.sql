-- ADD a column to match the csesoutboundinterface table
-- This table is populated by daily AFS snap script

alter table tb_cses_outbound_interface_iss 
add column cses_out_id bigint;
