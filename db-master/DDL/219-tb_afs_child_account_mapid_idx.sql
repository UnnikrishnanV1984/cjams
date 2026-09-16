drop index if exists tb_afs_child_account_mapid_idx;
         
CREATE UNIQUE INDEX tb_afs_child_account_mapid_idx ON tb_afs_child_account_mapid (cjamspid);