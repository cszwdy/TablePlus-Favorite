SELECT
	COUNT(
		CASE WHEN a.ai_best_score >= - 1
			AND a.ai_best_score <= 0 THEN
			1
		END) AS '[-1,0]',
	COUNT(
		CASE WHEN a.ai_best_score >= 1
			AND a.ai_best_score <= 10 THEN
			1
		END) AS '[1,10]',
	COUNT(
		CASE WHEN a.ai_best_score >= 11
			AND a.ai_best_score <= 20 THEN
			1
		END) AS '[11,20]',
	COUNT(
		CASE WHEN a.ai_best_score >= 21
			AND a.ai_best_score <= 30 THEN
			1
		END) AS '[21,30]',
	COUNT(
		CASE WHEN a.ai_best_score >= 31
			AND a.ai_best_score <= 40 THEN
			1
		END) AS '[31,40]',
	COUNT(
		CASE WHEN a.ai_best_score >= 41
			AND a.ai_best_score <= 50 THEN
			1
		END) AS '[41,50]',
	COUNT(
		CASE WHEN a.ai_best_score >= 51
			AND a.ai_best_score <= 60 THEN
			1
		END) AS '[51,60]',
	COUNT(
		CASE WHEN a.ai_best_score >= 61
			AND a.ai_best_score <= 70 THEN
			1
		END) AS '[61,70]',
	COUNT(
		CASE WHEN a.ai_best_score >= 71
			AND a.ai_best_score <= 80 THEN
			1
		END) AS '[71,80]',
	COUNT(
		CASE WHEN a.ai_best_score >= 81
			AND a.ai_best_score <= 90 THEN
			1
		END) AS '[81,90]',
	COUNT(
		CASE WHEN a.ai_best_score >= 91
			AND a.ai_best_score <= 100 THEN
			1
		END) AS '[91,100]'
FROM
	xes_etn_stu_keyword_check_answer a
WHERE
	a.create_time >= '2020-06-28 00:00'
	AND a.create_time < '2020-07-06 00:00'