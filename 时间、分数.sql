SELECT
	u. `username` username,
	a. create_time,
	a.ai_key_words,
	a.ai_best_score,
	f. `file_url` mp3,
	f1. `file_url` pcm,
	t.`name` textbook,
	unit.`name` unit,
	l.courseware_name courseware,
	m.module_cn_name,
	m.module_en_name,
	

-- 	knowledgesub.knowledge knowledge,
-- 	knowlege.knowledge_type knowledgeType
	CASE a.node_lid
	WHEN NULL THEN
		'Emiaostein'
	ELSE
		CASE 
		WHEN  a.ai_best_score >= 95 THEN
			'AAAAA'
		WHEN  a.ai_best_score < 95 THEN
			'BBBBBB'
		END
	END AS knowledge
	
	
	
	
-- 	c.title
-- 	a.*
FROM
	xes_etn_stu_keyword_check_answer a
	JOIN `xes_etn_stu_answer_file` f ON a. `answer_file_id` = f. `answer_file_id`
		AND f. `file_type` = 2
	JOIN `xes_etn_stu_answer_file` f1 ON a. `answer_file_id` = f1. `answer_file_id`
		AND f1. `file_type` = 1
	JOIN `xes_user` u ON a. `user_lid` = u. `lid` 
	JOIN xes_lesson l ON a.lesson_lid = l.lid
	JOIN xes_courseware c ON l.courseware_lid = c.lid
	JOIN xes_unit unit ON unit.lid = c.unit_lid
	JOIN xes_textbook t ON t.lid = unit.textbook_lid
	JOIN xes_lesson_module_room room ON room.lid = a.lesson_module_room_lid
	JOIN xes_lesson_module_ref m ON room.module_ref_lid = m.lid
-- 	JOIN xes_engine_tree_node node ON node.lid = a.node_lid
-- 	JOIN xes_knowledge knowlege ON knowlege.lid = node.knowledge_lid
-- 	JOIN xes_knowledge_sub knowledgesub ON knowledgesub.knowledge_lid = knowlege.lid
	
WHERE
-- 	a. `device_type` = 'iOS'
-- 	AND t.lid = '114cebedb09d4a30a890fc692000a45a'
	u.username = "13681725063"
-- 	AND u.lid = 'b7d98bafba434ab0b3dd0b0168c9148b'
	AND a.ai_best_score >=91
	AND a.ai_best_score <=100
	AND a.create_time like '2020-07-05%'
-- 	AND a.ai_best_score
ORDER BY
-- 	RAND()
	a. `create_time` DESC
LIMIT 1000;