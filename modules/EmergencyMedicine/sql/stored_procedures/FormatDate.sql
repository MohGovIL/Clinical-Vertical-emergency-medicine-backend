DELIMITER $$

DROP FUNCTION IF EXISTS FormatDate $$

CREATE FUNCTION FormatDate (p_date DATE) RETURNS VARCHAR(255) READS SQL DATA
BEGIN
    DECLARE return_date VARCHAR(255);
    DECLARE date_format TINYINT(1);

    SELECT gl_value
    INTO date_format
    FROM globals WHERE gl_name = 'date_display_format';

    SELECT
        CASE
        WHEN date_format = 0 THEN CAST(p_date AS CHAR)
        WHEN date_format = 1 THEN DATE_FORMAT(p_date, '%m/%d/%Y')
        WHEN date_format = 2 THEN DATE_FORMAT(p_date, '%d/%m/%Y')
        END
    INTO return_date;

    RETURN return_date;


END $$

DELIMITER ;
