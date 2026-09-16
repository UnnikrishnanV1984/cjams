alter table placementrevision add column if not exists requestedby varchar(50);
alter table placementrevision add column if not exists requesteddate timestamp ;
alter table placementrevision add column if not exists approvedby varchar(50);
alter table placementrevision add column if not exists approveddate timestamp ;
