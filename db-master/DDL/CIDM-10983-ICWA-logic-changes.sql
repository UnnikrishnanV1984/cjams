-- B-202765 - ICWA Logic Changes Notifications Optimisation.
ALTER TABLE personauditlog 
ALTER COLUMN personjson SET DATA TYPE jsonb 
USING personjson::jsonb;

CREATE INDEX idx_personaudit_icwaunderdefinition
ON personauditlog USING GIN ((personjson -> 'icwaunderdefinition'));