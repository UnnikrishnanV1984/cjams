update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='ASST';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='TSKR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='PWCR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='ASPR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='SPLR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='GADR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='GAAR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='GAYR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='GASR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='PPLR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='TPRR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='ADPR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='GARR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='ABLR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='INDR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='PLTR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='CHRR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='ASAR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='AARR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='SRVC';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='ADPC';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='ADSR' ;
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='SCDR';
update routingconfig set targetrolekey ='CWSP',activeflag =1 where targetrolekey='CWCW' and sourcerolekey ='CWSP' and eventcode='SPLAN';

DELETE FROM cjams.routingconfig WHERE routingconfigid ='6b35f5d0-9c15-4f11-9862-1d1a70d8d2a2';

INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey )
VALUES('6b35f5d0-9c15-4f11-9862-1d1a70d8d2a2', 'INTR', 'CWSP', 1, 'admin', '2019-05-03 11:54:01.213', NULL, '2019-05-03 11:54:01.213', '2019-05-03 11:54:01.213', NULL, NULL, 'CWCW', NULL, NULL );

 