
alter table guardianship add column if not exists switchprovider BOOLEAN;
alter table guardianship add column if not exists switchproviderreason varchar(500);
alter table guardianship add column if not exists effectiveswitchdate timestamp;
	