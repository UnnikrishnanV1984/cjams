-- D-20719 - update merged md id
UPDATE personidentifier SET personidentifiervalue = 'MDT-130807566', updatedon = now() WHERE personidentifiervalue = 'MDT-131005770';     

-- 20390 update person suffix
UPDATE person SET suffix = 'III', updatedon = now() WHERE cjamspid = 200000030;

-- Supervisor list update
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=6004156) where old_id =6023892;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=6027927) where old_id =6025802;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=6027927) where old_id =6025574;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=6027927) where old_id =6022538;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=6004156) where old_id =6027434;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=6014770) where old_id =603;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=6027131) where old_id =6026156;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=617) where old_id =6022539;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=6027927) where old_id =605;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=6018072) where old_id =6004156;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=6027927) where old_id =6024172;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=6004200) where old_id =6004157;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=6018072) where old_id =6013692;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=617) where old_id =6025639;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=6004172) where old_id =6026957;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=6004156) where old_id =6026255;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=617) where old_id =632;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=6004145) where old_id =6027927;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=6014770) where old_id =611;
UPDATE  userprofile set updatedon = now(), supervisorid=(select securityusersid from userprofile where old_id=6004172) where old_id =6025872;
