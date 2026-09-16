ALTER TABLE cjams.gapsuspension add column if not exists approvalstatustypekey varchar(20) NULL;
ALTER TABLE cjams.gapsuspensionrevision add column if not exists  guardiansubsidyid uuid NULL;


