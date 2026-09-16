create index Xie1_supportlog on defecttracking.supportlog(insertedby,application,activeflag);
create index Xie2_supportlog on defecttracking.supportlog(supportno);
create index Xie3_supportlog on defecttracking.supportlog(jirarequestsent);
create index Xie4_supportlog on defecttracking.supportlog(effectivedate,ldssregion,application);
create index Xie1_supportlogfiles on defecttracking.supportlogfiles(supportlogid);
create index Xie1_releasenotes on defecttracking.releasenotes(supportid,publish,activeflag);
create index Xie5_supportlog on defecttracking.supportlog using btree (to_char_yyyymm(insertedon),ldssregion,application);
create index Xie6_supportlog on defecttracking.supportlog using btree (to_char_yyyymmdd(insertedon),ldssregion,application);