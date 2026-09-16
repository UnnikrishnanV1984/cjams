CREATE TABLE IF NOT EXISTS cjams.chessierequestlog (
	id uuid NOT NULL DEFAULT gen_random_uuid(),
	request jsonb NULL
);
