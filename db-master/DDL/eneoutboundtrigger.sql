CREATE TABLE cjams.eneoutboundtrigger (
        eneoutboundtriggerid uuid NOT NULL DEFAULT gen_random_uuid(),
        fk_id varchar(12) NULL,
        transactionon timestamp NULL,
        transactiontypekey varchar NULL,
        batchrunon timestamp NULL,
        statusflag varchar(2) NULL,
        activeflag int4 NULL,
        batchnumber varchar(12) NULL,
        datavalidflag int4 NULL,
        old_id varchar(20) NULL,
        etl_userid varchar(30) NULL,
        etl_load_date date NULL
);
CREATE INDEX indx_eneoutbound_fkid_oldid_trantype ON cjams.eneoutboundtrigger USING btree (fk_id, old_id, transactiontypekey);
CREATE INDEX indx_eneoutboundtrigger_fkid_oldid ON cjams.eneoutboundtrigger USING btree (fk_id, old_id);

