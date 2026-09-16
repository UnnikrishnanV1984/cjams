--CIDM-9273
-- Primary key for tb_afs_interfaces table.
ALTER TABLE  tb_afs_interfaces ADD PRIMARY KEY (afs_interface_record_id);

-- Primary key for tb_ive_component_status table.
ALTER TABLE  tb_ive_component_status ADD PRIMARY KEY (ive_component_status_id);

-- Step 3: Create the primary key
ALTER TABLE  tb_afs_interfaces_iss ADD PRIMARY KEY (afs_interface_record_id);
