--B-62521: pre adoptive placement changes for adoption tpr
ALTER TABLE cjams.placement ADD COLUMN IF NOT EXISTS ischangepreadoptive bool NULL;
ALTER TABLE cjams.placementrevision ADD COLUMN IF NOT EXISTS ischangepreadoptive bool NULL;