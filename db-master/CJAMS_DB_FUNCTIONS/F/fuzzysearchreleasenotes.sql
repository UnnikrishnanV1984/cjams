-- =========================================================================================
-- Revision History:
-- 2026-08-10     Michael Youngdahl      Initial creation
-- 2026-08-11     Michael Youngdahl      Added story/defect filter as parameter 10, added revision history
-- 2026-08-12     Michael Youngdahl      Added supportid to sort cases
-- =========================================================================================


DROP FUNCTION IF EXISTS defecttracking.fuzzysearchreleasenotes;
CREATE OR REPLACE FUNCTION defecttracking.fuzzysearchreleasenotes(
    search_term TEXT DEFAULT NULL,
    p_release_version TEXT DEFAULT NULL,
    p_start_date DATE DEFAULT NULL,
    p_end_date DATE DEFAULT NULL,
    p_limit INTEGER DEFAULT NULL,
    p_offset INTEGER DEFAULT NULL,
    p_sort_column TEXT DEFAULT 'releaseversionno',
    p_sort_order TEXT DEFAULT 'DESC',
    p_application TEXT DEFAULT NULL,
    p_itemtype TEXT DEFAULT NULL
)
RETURNS SETOF defecttracking.releasenotes AS $func$
DECLARE
    cleaned_search TEXT;
    v_order_desc BOOLEAN;
BEGIN
    -- Only format the search term if it was actually provided
    IF search_term IS NOT NULL THEN
        cleaned_search := '%' || replace(trim(search_term), ' ', '%') || '%';
    END IF;

    -- Normalize the sort order to a boolean for easier conditional logic
    v_order_desc := (UPPER(coalesce(p_sort_order, 'DESC')) = 'DESC');

    RETURN QUERY
    SELECT *
    FROM defecttracking.releasenotes
    WHERE
        -- Optional global fuzzy search
        (search_term IS NULL OR
         (releasenotesid::text || ' ' ||
          releaseversionno || ' ' ||
          application || ' ' ||
          itemtype || ' ' ||
          itemid || ' ' ||
          title || ' ' ||
          description || ' ' ||
          COALESCE(supportid, '') || ' ' ||
          COALESCE(documentlink, '') || ' ' ||
          COALESCE(raisedby, '')) ILIKE cleaned_search)

        -- Optional filtering by version number
        AND (p_release_version IS NULL OR releaseversionno = p_release_version)

        -- Optional filtering by date range
        AND (p_start_date IS NULL OR releasenotes.releasedate >= p_start_date)
        AND (p_end_date IS NULL OR releasenotes.releasedate <= p_end_date)

        -- Optional application filter; NULL means return all applications
        AND (p_application IS NULL OR application = p_application)

        -- Optional itemtype filter; NULL means return all types
        AND (p_itemtype IS NULL OR itemtype = p_itemtype)

    ORDER BY
        -- Text Sorting (ASC)
        CASE WHEN NOT v_order_desc AND LOWER(p_sort_column) = 'releaseversionno' THEN releaseversionno END ASC,
        CASE WHEN NOT v_order_desc AND LOWER(p_sort_column) = 'application'      THEN application      END ASC,
        CASE WHEN NOT v_order_desc AND LOWER(p_sort_column) = 'title'            THEN title            END ASC,
        CASE WHEN NOT v_order_desc AND LOWER(p_sort_column) = 'supportid'        THEN supportid        END ASC,

        -- Date Sorting (ASC)
        CASE WHEN NOT v_order_desc AND LOWER(p_sort_column) = 'releasedate' THEN releasedate END ASC,

        -- Integer Sorting (ASC)
        CASE WHEN NOT v_order_desc AND LOWER(p_sort_column) = 'releasenotesid' THEN releasenotesid END ASC,

        -- Text Sorting (DESC)
        CASE WHEN v_order_desc AND LOWER(p_sort_column) = 'releaseversionno' THEN releaseversionno END DESC,
        CASE WHEN v_order_desc AND LOWER(p_sort_column) = 'application'      THEN application      END DESC,
        CASE WHEN v_order_desc AND LOWER(p_sort_column) = 'title'            THEN title            END DESC,
        CASE WHEN v_order_desc AND LOWER(p_sort_column) = 'supportid'        THEN supportid        END DESC,

        -- Date Sorting (DESC)
        CASE WHEN v_order_desc AND LOWER(p_sort_column) = 'releasedate' THEN releasedate END DESC,

        -- Integer Sorting (DESC)
        CASE WHEN v_order_desc AND LOWER(p_sort_column) = 'releasenotesid' THEN releasenotesid END DESC

    LIMIT p_limit
    OFFSET p_offset;
END;
$func$ LANGUAGE plpgsql;
