SELECT
	a.id				id,
	
	(
		SELECT
			u.username
		FROM
			xes_user u
		WHERE
			a.user_lid = u.lid
		LIMIT 1
	) AS 				phone,

	a.create_time		date,
	a.ai_key_words 		keywords,
	a.ai_answer			answer,
	a.ai_best_score		score,
	
	(
		SELECT
			t.`name`
		FROM
			xes_lesson l
			JOIN xes_courseware c ON c.lid = l.courseware_lid
			JOIN xes_unit unit ON  unit.lid = c.unit_lid
			JOIN xes_textbook t ON t.lid = unit.textbook_lid
		WHERE
			a.lesson_lid = l.lid
		LIMIT 1
	) AS 				textbook,
	
	(
		SELECT
			unit.`name`
		FROM
			xes_lesson l
			JOIN xes_courseware c ON c.lid = l.courseware_lid
			JOIN xes_unit unit ON  unit.lid = c.unit_lid
		WHERE
			a.lesson_lid = l.lid
		LIMIT 1
	) AS 				unit,
	
	(
		SELECT
			l.courseware_name
		FROM
			xes_lesson l
		WHERE
			a.lesson_lid = l.lid
		LIMIT 1
	) AS 				lesson,
	
	(
		SELECT
			mref.module_type
		FROM
			xes_lesson_module_room mr
			JOIN xes_lesson_module_ref mref ON mref.lid = mr.module_ref_lid
		WHERE
			a.lesson_module_room_lid = mr.lid
		LIMIT 1
	) AS 				module_type,
	
	(
		SELECT
			mref.module_cn_name
		FROM
			xes_lesson_module_room mr
			JOIN xes_lesson_module_ref mref ON mref.lid = mr.module_ref_lid
		WHERE
			a.lesson_module_room_lid = mr.lid
		LIMIT 1
	) AS 				module_cn_name,
	
	(
		SELECT
			mref.module_en_name
		FROM
			xes_lesson_module_room mr
			JOIN xes_lesson_module_ref mref ON mref.lid = mr.module_ref_lid
		WHERE
			a.lesson_module_room_lid = mr.lid
		LIMIT 1
	) AS 				module_en_name,
	
	
	(
		SELECT
			f.file_url
		FROM
			xes_etn_stu_answer_file f
		WHERE
			f.file_type = 2
		AND f.answer_file_id = a.answer_file_id
		AND f.`status` = 1
		LIMIT 1
	) AS 				mp3,
	
	(
		SELECT
			f.file_url
		FROM
			xes_etn_stu_answer_file f
		WHERE
			f.file_type = 1
		AND f.answer_file_id = a.answer_file_id
		AND f.`status` = 1
		LIMIT 1
	) AS 				pcm,
	
	a.device_type		device,
	a.ai_raw_string		raw
	

	
FROM
	xes_etn_stu_keyword_check_answer a
WHERE
	a.ai_key_words = 'They spot an eagle and a dragonfly.'
	AND a.create_time >= '2020-06-06 00:00'	
	AND a.create_time <= '2020-07-06 23:59:59'
ORDER BY
	a. `create_time` DESC