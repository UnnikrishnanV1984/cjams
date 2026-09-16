DROP FUNCTION IF EXISTS deletenotes(text);
CREATE OR REPLACE FUNCTION deletenotes(progressnoteids text)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE 

v_progressnoteids text[];

BEGIN

v_progressnoteids :=progressnoteids;

    UPDATE progressnoteroletype SET activeflag =0
	WHERE progressnoteid = ANY( v_progressnoteids::uuid[]) 
	AND activeflag =1;

	UPDATE progressnote  SET activeflag =0 
	WHERE progressnoteid = ANY( v_progressnoteids::uuid[]) 
	AND activeflag =1;
	
	
	
RETURN 'Deleted Successfully';
END;
$function$;
