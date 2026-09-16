update rolemapping set teamtypekey='CW' where teamtypekey='FNS';
update rolemapping set teamtypekey='CW' where teamtypekey is null;
update rolemapping set teamtypekey='CW' where teamtypekey not in ('OLM','PVPROV','LDSS');