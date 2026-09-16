-- To add index on usernotification - CDM-35090

CREATE INDEX xie3_usernotification ON cjams.usernotification USING btree (DATE(insertedon),securityusersid,objectcasenumber,activeflag);