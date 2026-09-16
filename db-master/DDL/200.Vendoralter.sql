alter table tb_vendor_applicant add column if not exists issamepaymentaddress boolean null;
alter table tb_vendor_applicant add column if not exists approvalcomments varchar(100) null;
alter table tb_vendor_applicant add column if not exists providerid varchar(50) null;