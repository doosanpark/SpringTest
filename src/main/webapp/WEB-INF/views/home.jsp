<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<title>Home</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"
	integrity="sha512-d9xgZrVZpmmQlfonhQUvTR7lMPtO7NkZMkA0ABN3PHCbKA5nqylQ/yWlFAyY6hYgdF1Qh6nYiuADWwKB4C2WSw=="
	crossorigin="anonymous"></script>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/themes/redmond/jquery-ui.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>


<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/css/ui.jqgrid.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/chart.js@2.7.3/dist/Chart.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@0.7.0"></script>
<script type="text/javascript"
	src="/myapps/resources/js/jqGrid/jQuery.jqGrid.setColWidth.js"></script>

<!-- 차트 -->
<script type="text/javascript"
	src="/myapps/resources/js/chart/fbarChart.js"></script>
<script type="text/javascript"
	src="/myapps/resources/js/chart/fgridChart.js"></script>
<script type="text/javascript"
	src="/myapps/resources/js/chart/fpieChart.js"></script>

<!-- 달력 -->
<link rel="stylesheet"
	href="/myapps/resources/datepicker/air-datepicker/dist/css/datepicker.min.css">
<script
	src="/myapps/resources/datepicker/air-datepicker/dist/js/datepicker.min.js"></script>
<script
	src="/myapps/resources/datepicker/air-datepicker/dist/js/i18n/datepicker.ko.js"></script>
<script type="text/javascript"
	src="/myapps/resources/datepicker/datepicker.js"></script>


<style>
body {
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.charts {
	text-align: center;
}

.base_config {
	margin: 10px;
	display: flex;
	justify-content: space-between;
	min-width: 500px;
}

section {
	margin: 20px;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.charts canvas {
	max-width: 330px;
}

.history {
	display: flex;
	flex-direction: column;
	align-items: center;
}
</style>

</head>

<body onload="getHistoryData()">


	<section class="nav">
		<div class="term base_config">
			<span>기간 설정: </span> <input id="datepicker1" type="text"> - <input
				id="datepicker2" type="text">
		</div>

		<div class="isLogin base_config">
			<span>로그인 성공 여부: </span>
			<div>
				Y <input type="radio" class="log_suc" name="log_suc" value="y">
				N <input type="radio" class="log_suc" name="log_suc" value="n">
			</div>
		</div>

		<div class="emailSearch base_config">
			<span>이메일 검색: </span><input id="searchContent" style="width: 400px;">
		</div>

		<div class="base_config">
			<button onclick="onSearch()">검색 조건 추가</button>
		</div>
	</section>

	<section class="charts">
		<h1>Login Statistics</h1>
		<div class="container">
			<canvas id="barChart" width="400" height="400"></canvas>
			<canvas id="pieChart" width="400" height="400"></canvas>
		</div>

	</section>

	<section class="history">

		<h1>Login History</h1>
		<div>
			<table id="grid"></table>
		</div>

	</section>


	<script>
		//두개짜리 제어 연결된거 만들어주는 함수
		datePickerSet($("#datepicker1"), $("#datepicker2"), true); //다중은 시작하는 달력 먼저, 끝달력 2번째

		function getHistoryData(searchedData) {

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
	</script>
	<script>
		function onSearch() {
			var date1 = document.getElementById("datepicker1").value;	//기간 시작일
			var date2 = document.getElementById("datepicker2").value;	//기간 종료일

			var access = $('input[name="log_suc"]:checked').val();		//로그인 성공 여부

			var email = document.getElementById("searchContent").value; //이메일 검색 키워드

			$.ajax({
				url : "/myapps/getData",
				type : "POST",
				data : {
					date1 : date1,
					date2 : date2,
					access : access,
					email : email
				},
				success : function(data) {
					getHistoryData(data);
				},
				error : function(request, status, error) {
					alert("리퀘스트 에러");
				}
			})
		}
	</script>
</body>
</html>
