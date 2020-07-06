SELECT
	r.id ,
	r.ai_key_words ,
	(
		SELECT
			f.file_url
		FROM
			xes_etn_stu_answer_file f
		WHERE
			f.file_type = 1
		AND f.answer_file_id = r.answer_file_id
		AND f.`status` = 1
		AND f.file_url != ''
		LIMIT 1
	) AS pcm ,
	(
		SELECT
			f.file_url
		FROM
			xes_etn_stu_answer_file f
		WHERE
			f.file_type = 2
		AND f.answer_file_id = r.answer_file_id
		AND f.`status` = 1
		AND f.file_url != ''
		LIMIT 1
	) AS mp3 ,
	CASE r.result
WHEN 0 THEN
	'答错'
ELSE
	'答对'
END AS result ,
 r.ai_best_score ,
 r.ai_raw_string ,
 r.create_time
FROM
	xes_etn_stu_keyword_check_answer r
WHERE
	r.`status` = 1
AND r.result IN('0' , '1')
AND r.`answer_file_id` != ''
AND r.ai_best_score >= 91
AND r.ai_best_score <= 100
AND r.create_time >= '2020-05-15 00:00'
AND r.create_time <= '2020-05-15 23:59:59'
AND r.quiz_id > 0
order by RAND()
LIMIT 100