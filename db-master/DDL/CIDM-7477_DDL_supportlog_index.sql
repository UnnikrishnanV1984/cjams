CREATE INDEX xie7_supportlog ON defecttracking.supportlog USING btree (jirarequestno);
CREATE INDEX xie8_supportlog ON defecttracking.supportlog USING btree (cjams.to_char_yyyymm((cjamsticketcreateddate)::timestamp without time zone), ldssregion, application);
CREATE INDEX xie9_supportlog ON defecttracking.supportlog USING btree (cjams.to_char_yyyymmdd((cjamsticketcreateddate)::timestamp without time zone), ldssregion, application);
CREATE INDEX xie10_supportlog ON defecttracking.supportlog USING btree (cjams.to_char_yyyymm((approveddate)::timestamp without time zone), ldssregion, application);
CREATE INDEX xie11_supportlog ON defecttracking.supportlog USING btree (cjams.to_char_yyyymmdd((approveddate)::timestamp without time zone), ldssregion, application);
CREATE INDEX xie12_supportlog ON defecttracking.supportlog USING btree (cjams.to_char_yyyymm((cdmticketcreateddate)::timestamp without time zone), ldssregion, application);
CREATE INDEX xie13_supportlog ON defecttracking.supportlog USING btree (cjams.to_char_yyyymmdd((cdmticketcreateddate)::timestamp without time zone), ldssregion, application);
CREATE INDEX xie1_cjamsjiratickets ON defecttracking.cjamsjiratickets USING btree (date(updatedon), activeflag);