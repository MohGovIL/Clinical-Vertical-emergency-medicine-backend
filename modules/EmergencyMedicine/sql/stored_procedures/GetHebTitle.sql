DELIMITER $$

DROP FUNCTION IF EXISTS `GetHebTitle` $$

CREATE FUNCTION GetHebTitle(p_title varchar(255)) RETURNS varchar(255) READS SQL DATA
BEGIN

   DECLARE v_title varchar(255);

    select d.definition
    INTO v_title
	from lang_constants c
	join lang_definitions d on d.cons_id = c.cons_id and lang_id= (select lang_id from lang_languages where lang_code = 'he')
	where c.constant_name = p_title;

   RETURN ifnull(v_title, p_title);

END$$

DELIMITER ;

-- select GetHebTitle('Yes')
