function getHistoryDatas(searchedData) {
	console.log('dd');
	var emailDatas = []; // 이메일
	var accessedDatas = []; // 로그인 성공 여부
	var dateDatas = []; // 로그인 날짜
	var historyDatas = [] // 로그인 히스토리
	var dateCntArray = []; // 날짜별 로그인 시도 횟수
	var dateDivision = [ 'No Data', 'No Data', 'No Data', 'No Data', 'No Data',
			'No Data', 'No Data' ]; // 날짜 구분
	var accessedCase = [ 0, 0 ]; // 로그인 성공 횟수

	/* 로그인 히스토리 종류별 구분 */
	var data = '${loginHistory}';
	/*
	 * var data = "erid3232@naver.com,success,2021-02-19,"+
	 * "eris,fail,2021-02-19," + "erid3232@gmail.com,fail,2021-02-18,"+
	 * "erid3232@gmail.com,fail,2021-02-17,"+
	 * "erid3232@naver.com,fail,2021-02-16,"+
	 * "erid3232@naver.com,fail,2021-02-15,"+
	 * "erid3232@naver.com,success,2021-02-15,"
	 */

	var emailDatas = []; // 이메일
	var accessedDatas = []; // 로그인 성공 여부
	var dateDatas = []; // 로그인 날짜
	var historyDatas = [] // 로그인 히스토리

	if (searchedData != null) {
		data = searchedData;
		for (var i = 0; i < data.length; i++) {
			emailDatas.push(data[i].email);
			accessedDatas.push(data[i].access);
			dateDatas.push(data[i].date);

			historyDatas.push({
				Email : data[i].email,
				Accessed : data[i].access,
				Date : data[i].date
			});
		}
	} else {

		var arrayData = data.split(',');

		for (var i = 0; i < arrayData.length - 1; i = i + 5) {

			emailDatas.push(arrayData[i].split('=')[1]);
			accessedDatas.push(arrayData[i + 1].split('=')[1]);

			var date = arrayData[i + 2].split('=')[1].split(']')[0];

			dateDatas.push(date);

			historyDatas.push({
				Email : arrayData[i].split('=')[1],
				Accessed : arrayData[i + 1].split('=')[1],
				Date : date
			});
		}
	}

	/* 로그인 날짜 정리 */
	var recentDate = dateDatas[0]; // 최근 날짜

	var cnt = 0;
	var dateCnt = 1; // 날짜 수

	// 날짜 계산
	for (var i = 1; i <= dateDatas.length; i++) {
		cnt++;
		if (dateDatas[i] != recentDate) {
			dateDivision[dateCnt - 1] = recentDate; // 날짜가 바뀌면 현재까지 날짜를 배열에 넣기
			dateCntArray.push(cnt);

			recentDate = dateDatas[i]; // 날짜 변경
			cnt = 0;
			dateCnt++;
		}

		if (dateCnt > 7) {
			dateCntArray.push(cnt);
			break;
		}
	}
	var latestDate = dateDivision[0];

	/* 로그인 성공 횟수 */
	for (var i = 0; i < accessedDatas.length; i++) {
		if (accessedDatas[i] === 'y') {
			accessedCase[0]++;
		} else {
			accessedCase[1]++;
		}
	}

	fbarChart(dateDivision, dateCntArray);
	fpieChart(accessedCase);
	fgridChart(historyDatas);
}