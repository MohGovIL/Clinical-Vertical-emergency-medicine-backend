DELIMITER $$

DROP FUNCTION IF EXISTS `GetOptionTitle` $$

CREATE FUNCTION GetOptionTitle(p_list_id varchar(255), p_option_id varchar(100)) RETURNS varchar(255) READS SQL DATA
BEGIN

   DECLARE v_title varchar(255);

   select lo.title
   INTO v_title
   from `list_options` lo
   where lo.list_id = p_list_id and
		 lo.option_id = p_option_id;

   RETURN v_title;

END$$

DELIMITER ;

-- select GetOptionTitle('moh_profession_category', fvc.prof_catego
