 ALTER TABLE cjams.tb_foster_care_judicial ALTER COLUMN dateoffindingctwdecision TYPE TIMESTAMP without time zone USING dateoffindingctwdecision::TIMESTAMP without time zone;
 ALTER TABLE cjams.tb_foster_care_judicial ALTER COLUMN dateofreasonableeffortscourthearing TYPE TIMESTAMP without time zone USING dateofreasonableeffortscourthearing::TIMESTAMP without time zone;
 ALTER TABLE cjams.tb_foster_care_judicial ALTER COLUMN dateofjudicialfindingofrefpp TYPE TIMESTAMP without time zone USING dateofjudicialfindingofrefpp::TIMESTAMP without time zone;
 ALTER TABLE cjams.tb_foster_care_judicial ALTER COLUMN dateofsubsequentjudicialfindingofrefpp TYPE TIMESTAMP without time zone USING dateofsubsequentjudicialfindingofrefpp::TIMESTAMP without time zone;
 ALTER TABLE cjams.tb_foster_care_judicial ALTER COLUMN dateofpreviousjudicialfindingofrefpp TYPE TIMESTAMP without time zone USING dateofpreviousjudicialfindingofrefpp::TIMESTAMP without time zone;
 ALTER TABLE cjams.tb_foster_care_judicial ALTER COLUMN dateofcurrentjudicialfindingofbestinterest TYPE TIMESTAMP without time zone USING dateofcurrentjudicialfindingofbestinterest::TIMESTAMP without time zone;
 ALTER TABLE cjams.tb_foster_care_judicial ALTER COLUMN dateofsubsequentfindingofbestinterest TYPE TIMESTAMP without time zone USING dateofsubsequentfindingofbestinterest::TIMESTAMP without time zone;
 ALTER TABLE cjams.tb_foster_care_judicial ALTER COLUMN dateofpreviousbestinterestfinding TYPE TIMESTAMP without time zone USING dateofpreviousbestinterestfinding::TIMESTAMP without time zone;
  
alter table tb_foster_care_judicial add primary key (client_id,removal_id,period_type);
