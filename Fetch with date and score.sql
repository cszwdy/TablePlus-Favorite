SELECT
	a.id				id,
-- 	u.username 			phone,
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
			CONCAT(mref.module_cn_name, ' ', mref.module_en_name)
		FROM
			xes_lesson_module_room mr
			JOIN xes_lesson_module_ref mref ON mref.lid = mr.module_ref_lid
		WHERE
			a.lesson_module_room_lid = mr.lid
		LIMIT 1
	) AS 				module,
	
-- 	a.node_lid,
-- 	
-- 	a.speaking_lid,
	
-- 	a.quiz_id,
	
	CASE
	WHEN a.node_lid IS NOT NULL AND a.node_lid <> '' AND a.node_lid != '-1' THEN
		(
		SELECT
			ks.knowledge
		FROM
			xes_engine_tree_node n
			JOIN xes_knowledge k ON k.lid = n.knowledge_lid
			JOIN xes_knowledge_sub ks ON ks.knowledge_lid = k.lid
		WHERE
			a.node_lid = n.lid
			
		LIMIT 1
		)
	ELSE
		CASE a.speaking_lid
		WHEN  NULL THEN
			CASE
			WHEN a.quiz_id IS NOT NULL AND a.quiz_id <> '' THEN
			(
			SELECT
				ks.knowledge
			FROM
				xes_quiz q
			JOIN xes_knowledge k ON k.lid = q.knowledge_lid
			JOIN xes_knowledge_sub ks ON ks.knowledge_lid = k.lid
			WHERE
				a.quiz_id = q.id
			
			LIMIT 1
			)
			ELSE
				''
			END
		ELSE
			(
			SELECT
				ks.knowledge
			FROM
				xes_speaking s
			JOIN xes_knowledge k ON k.lid = s.knowledge_lid
			JOIN xes_knowledge_sub ks ON ks.knowledge_lid = k.lid
			WHERE
				a.speaking_lid = s.lid
			
			LIMIT 1
			)
		END
	END AS knowledge,
	
	
	CASE
	WHEN a.node_lid IS NOT NULL AND a.node_lid <> '' THEN
		(
		SELECT
			k.knowledge_type
		FROM
			xes_engine_tree_node n
			JOIN xes_knowledge k ON k.lid = n.knowledge_lid
		WHERE
			a.node_lid = n.lid
			
		LIMIT 1
		)
	ELSE
		CASE a.speaking_lid
		WHEN  NULL THEN
			CASE
			WHEN a.quiz_id IS NOT NULL AND a.quiz_id <> '' THEN
			(
			SELECT
				k.knowledge_type
			FROM
				xes_quiz q
			JOIN xes_knowledge k ON k.lid = q.knowledge_lid
-- 			JOIN xes_knowledge_sub ks ON ks.knowledge_lid = k.lid
			WHERE
				a.quiz_id = q.id
			
			LIMIT 1
			)
			ELSE
				''
			END
		ELSE
			(
			SELECT
				k.knowledge_type
			FROM
				xes_speaking s
			JOIN xes_knowledge k ON k.lid = s.knowledge_lid
			WHERE
				a.speaking_lid = s.lid
			
			LIMIT 1
			)
		END
	END AS 				knowledgeType,
	
		(
		SELECT
			f.file_url
		FROM
			xes_etn_stu_answer_file f
		WHERE
			f.file_type = 2
		AND f.answer_file_id = a.answer_file_id
		AND f.`status` = 1
-- 		AND f.file_url != ''
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
-- 		AND f.file_url != ''
		LIMIT 1
	) AS 				pcm,
	
	a.device_type		device,
	a.ai_raw_string		raw
	

	
FROM
	xes_etn_stu_keyword_check_answer a
-- 	JOIN xes_user u ON u.lid = a.user_lid
WHERE
-- 	u.username = "13681725063" 
	a.ai_best_score >=81
	AND a.ai_best_score <=90
	AND a.create_time >= '2020-06-06 00:00'	
	AND a.create_time <= '2020-07-06 23:59:59'
ORDER BY
		RAND()
-- 	a. `create_time` DESC
LIMIT
	1000