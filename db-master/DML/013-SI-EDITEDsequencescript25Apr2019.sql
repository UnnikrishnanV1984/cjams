create sequence SQ_CRB_FACTS_INTERMEDIATE start 101;

alter  table interfaceserrorlog alter column errorcode type varchar(10000);


alter  table interfaceserrorlog alter column interfaceid type varchar(100);