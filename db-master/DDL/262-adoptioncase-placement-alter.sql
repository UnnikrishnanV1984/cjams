ALTER TABLE cjams.adoptioncase ADD COLUMN IF not EXISTS narrative varchar(5000) NULL;
ALTER TABLE cjams.placement ADD COLUMN if not EXISTS ischildplacedoutside bool NULL;