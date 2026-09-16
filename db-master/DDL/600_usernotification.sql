ALTER TABLE cjams.usernotification ADD teamtypekey varchar(10) NULL;
ALTER TABLE cjams.intakedastaging ADD teamtypekey varchar(10) NULL;
update cjams.personprogramarea set sourcetype = 'CW' where sourcetype is null;
update cjams.usernotification set teamtypekey = 'CW' where teamtypekey is null;
update cjams.intakedastaging set teamtypekey = 'CW' where teamtypekey is null;
update cjams.intakedastatus set teamtypekey = 'CW' where teamtypekey is null;
