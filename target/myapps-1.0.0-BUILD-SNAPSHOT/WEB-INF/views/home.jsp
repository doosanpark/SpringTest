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


<!-- font awesomeCDN 링크 -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" 
	rel="stylesheet"> 

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


<!-- 달력 -->
<link rel="stylesheet"
	href="/myapps/resources/datepicker/air-datepicker/dist/css/datepicker.min.css">
<script
	src="/myapps/resources/datepicker/air-datepicker/dist/js/datepicker.min.js"></script>
<script
	src="/myapps/resources/datepicker/air-datepicker/dist/js/i18n/datepicker.ko.js"></script>
<script type="text/javascript"
	src="/myapps/resources/datepicker/datepicker2.js"></script>

	<style>
		body {
			display: flex;
			flex-direction: column;
			justify-content: center;
		}
		
		span{
			font-size: 20px;
		}

		header {
			height: 50px;
			display: flex;
			justify-content: flex-end;
			align-items: center;
			padding: 20px;

			background-color: skyblue;
		}

		#logoutBtn {
			margin-left: 20px;
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

		.history {
			display: flex;
			flex-direction: column;
			align-items: center;
			justify-content: center;
		}

		.nav {
			display: flex;
			flex-direction: row;
			justify-content: center;
			align-items: center;
		}

		.charts .container {
			display: flex;
			width: 100%;
			justify-content: space-around;
		}

		.charts .canvas {
			display: flex;
			width: 30%;
			
			border: 1px solid grey;
			justify-content: center;
		}

		.blank {
			width: 30px;
		}

		.chartTitle {
			display: flex; 
			align-items: center; 
			min-width: 440px; 
			justify-content: space-between;
		}

		#refresh{
			width: 30px;
			height: 30px;
		}

		#grid{
			width: 1000px;
		}

		#gridSec{
			width: 80%
		}

	</style>

</head>

<body onload="getHistoryOnLoad()">

	<header>
		<span id="loginId"></span> <span id="logoutBtn" onclick="logFunc();">Log In</span>
	</header>

	<section class="nav">
		<div class="term base_config">
			<span>기간 설정: </span> <input id="datepicker1" type="text" onchange="checkIsempty()"> - <input
				id="datepicker2" type="text">
		</div>

		<div class="emailSearch base_config">
			<span>이메일 검색: </span><input id="searchContent" style="width: 400px;">
		</div>	

		<div>
			<button onclick="onSearch()">검색 조건 추가</button>
		</div>
	</section>

	<section class="charts">
		<h1>Login Statistics</h1>
		<div class="container">
			<div class="canvas">
				<canvas id="barChart" width="400" height="400"></canvas>
			</div>
			<div class="canvas">
				<canvas id="pieChart" width="400" height="400"></canvas>
			</div>
		</div>
	</section>

	<section class="history">
		<div class="chartTitle">
			<div class="blank"></div>
			<h1>Login History</h1>
			<div class="blank">
				<button id="refresh" onclick="getHistoryOnLoad()">
					<i class="fas fa-sync-alt"></i>
				</button>
			</div>
		</div>
		<div id="gridSec">
			<table id="grid"></table>
			<div id="pager"></div><br/>
		</div>
	</section>

	<script>
		//기간 설정 두개짜리 만들어주는 함수
		datePickerSet($("#datepicker1"), $("#datepicker2"), true); //다중은 시작하는 달력 먼저, 끝달력 2번째
	</script>

	<script>
		function getHistoryOnLoad() {

			//홈 화면 쿠키 설정
			if (document.cookie.length > 3) {
				var cookie = document.cookie;
				if (cookie.split('=')[0] === "email") {
					var setEmail = document.getElementById('loginId');
					setEmail.innerText = cookie.split('=')[1] + "님";

					var setLogBtn = document.getElementById('logoutBtn');
					setLogBtn.innerText = "Log Out";
				}
			}

			/* 로그인 히스토리 종류별 구분 */
			let data;
			data = "["
				+ "LogInHistory [email=erid3232@naver.com, access=y, date=2021-02-22, date1=null, date2=null],"
				+ "LogInHistory [email=asdf, access=n, date=2021-02-22, date1=null, date2=null], "
				+ "LogInHistory [email=erid3232@naver.com, access=n, date=2021-02-22, date1=null, date2=null], "
				+ "LogInHistory [email=erid3232, access=n, date=2021-02-21, date1=null, date2=null], "
				+ "LogInHistory [email=erid3232, access=n, date=2021-02-20, date1=null, date2=null], "
				+ "LogInHistory [email=erid3232, access=n, date=2021-02-20, date1=null, date2=null], "
				+ "LogInHistory [email=erid3232, access=n, date=2021-02-19, date1=null, date2=null]]";
			data = '${loginHistory}';

			var emailDatas = {}; // 이메일
			var accessedDatas = []; // 로그인 성공 여부
			var dateDatas = []; // 로그인 날짜
			var historyDatas = []; // 로그인 히스토리
			var dateCntArray = []; // 날짜별 로그인 시도 횟수
			var dateDivision = ['No Data', 'No Data', 'No Data', 'No Data',
				'No Data', 'No Data', 'No Data']; // 날짜 구분
			var accessedCase = [0, 0, 0]; // 로그인 성공 횟수
			var dateArray;
			var year; //조회년도

			// 전체 기간
			var arrayData = data.split(',');
			for (var i = 0; i < arrayData.length - 1; i = i + 5) {
				let email = arrayData[i].split('=')[1];
				let accessed = arrayData[i + 1].split('=')[1];
				let date = arrayData[i + 2].split('=')[1].split(']')[0];

				if(emailDatas[email] === undefined){
					emailDatas[email] = 1;
				} else {
					emailDatas[email]++;
				}

				accessedDatas.push(accessed);

				dateArray = date.split("-");
				dateDatas.push(dateArray[1] + "-" + dateArray[2]);

				historyDatas.push({
					Email: email,
					Accessed: accessed,
					Date: date
				});
			}
			year = dateArray[0];

			var title = year; //검색기간. 파이차트 제목
			/* 로그인 날짜 정리 */
			var recentDate = dateDatas[0]; // 최근 날짜

			var cnt = 0;
			var dateCnt = 1; // 날짜 수

			// bar chart에 표시될 날짜 계산.
			for (var i = 1; i <= dateDatas.length; i++) {
				cnt++;
				if (dateDatas[i] !== recentDate) {
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

			// 로그인 성공 횟수 
			for (var i = 0; i < accessedDatas.length; i++) {
				if (accessedDatas[i] === 'y') {
					accessedCase[0]++;
					accessedCase[1]++;
				} else {
					accessedCase[0]++;
					accessedCase[2]++;
				}
			}

			fbarChart(year, dateDivision, dateCntArray);
			fpieChart(title, emailDatas);
			fgridChart(historyDatas);
		}
	</script>

	<script>
		function getHistoryOnSearch(searchedData) {

			var emailDatas = {}; // 이메일
			var accessedDatas = []; // 로그인 성공 여부
			var dateDatas = []; // 로그인 날짜
			var historyDatas = []; // 로그인 히스토리
			var dateCntArray = []; // 날짜별 로그인 시도 횟수
			var dateDivision = ['No Data', 'No Data', 'No Data', 'No Data',
				'No Data', 'No Data', 'No Data']; // 날짜 구분
			var accessedCase = [0, 0, 0]; // 로그인 성공 횟수
			var dateArray;

			// 특정 검색 날짜
			data = searchedData;
			for (var i = 0; i < data.length; i++) {
				
				let email = data[i].email;
				let access = data[i].access;
				let date = data[i].date;
				
				if(emailDatas[email] === undefined){
					emailDatas[email] = 1;
				} else {
					emailDatas[email]++;
				}

				accessedDatas.push(access);

				dateArray = date.split("-");
				dateDatas.push(dateArray[1] + "-" + dateArray[2]);

				historyDatas.push({
					Email: email,
					Accessed: access,
					Date: date
				});
			}

			var year = dateArray[0];

			/* 로그인 날짜 정리 */
			var recentDate = dateDatas[0]; // 최근 날짜

			var cnt = 0;	//날짜별 데이터 수
			var dateCnt = 1; // 날짜 수

			// bar chart에 표시될 날짜 계산. 
			for (var i = 1; i <= dateDatas.length; i++) {

				cnt++;
				if (dateDatas[i] !== recentDate) {

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
			dateCnt = 0;	//날짜 수

			//기간 수 체크
			for (let i = 0; i < dateDivision.length; i++) {
				if (dateDivision[i] === "No Data") {
					break;
				}
				dateCnt++;
			}

			var title; //검색기간. 파이차트 제목
			// 파이 차트 제목에 표시할 조회 기간
			if (dateCnt === 1) {
				title = dateDivision[0];
			} else if (dateCnt > 0) {
				title = dateDivision[cnt - 1] + " ~ " + dateDivision[0];
			}

			/* 로그인 성공 횟수 */
			for (var i = 0; i < accessedDatas.length; i++) {
				if (accessedDatas[i] === 'y') {
					accessedCase[0]++;
					accessedCase[1]++;
				} else {
					accessedCase[0]++;
					accessedCase[2]++;
				}
			}

			fbarChart(year, dateDivision, dateCntArray);
			fpieChart(title, emailDatas);
			fgridChart(historyDatas);
		}
	</script>

	<script>
		function onSearch() {
			var date1 = document.getElementById("datepicker1").value; //기간 시작일
			var date2 = document.getElementById("datepicker2").value; //기간 종료일

			var email = document.getElementById("searchContent").value; //이메일 검색 키워드

			$.ajax({
				url: "/myapps/getDataFromPeriod",
				type: "POST",
				data: {
					date1: date1,
					date2: date2,
					email: email
				},
				success: function (data) {
					getHistoryOnSearch(data);
				},
				error: function (request, status, error) {
					alert("리퀘스트 에러");
				}
			})
		}
	</script>

	<script>
		function logFunc() {

			let logoutBtn = document.getElementById("logoutBtn");
			let loginId = document.getElementById("loginId");

			if (document.cookie.length > 3) {
				var cookie = document.cookie;
				if (cookie.split('=')[0] === "email") {
					document.cookie = 'email' + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;'
					logoutBtn.innerText = "Log In";
					loginId.innerText = "";
					location.href = "/myapps";
				}
			} else {
				location.href = "/myapps/login";
			}
		}
	</script>

	<!-- 막대 차트 -->
	<script>
		function fbarChart(curYear, dateDivision, dateCntArray) {
			/* Bar Chart 구현 코드 */
			var barCtx = document.getElementById('barChart').getContext('2d');

			var myBarChart = new Chart(barCtx, {
				type: 'bar',
				data: {
					labels: dateDivision,
					datasets: [{
						label: "조회년도: " + curYear + "년",
						data: dateCntArray,
						backgroundColor: ['rgba(255, 99, 132, 0.2)',
							'rgba(255, 99, 132, 0.2)',
							'rgba(255, 99, 132, 0.2)',
							'rgba(255, 99, 132, 0.2)',
							'rgba(255, 99, 132, 0.2)',
							'rgba(255, 99, 132, 0.2)',],
						borderColor: ['rgba(255, 99, 132, 1)',
							'rgba(255, 99, 132, 1)',
							'rgba(255, 99, 132, 1)',
							'rgba(255, 99, 132, 1)',
							'rgba(255, 99, 132, 1)',
							'rgba(255, 99, 132, 1)',],
						borderWidth: 1
					}]
				},
				options: {
					title: {
						display: false,
						text: 'Stacked Bars'
					},
					tooltips: {
						mode: 'label'
					},
					responsive: true,
					maintainAspectRatio: false,
					scales: {
						xAxes: [{
							stacked: true
						}],
						yAxes: [{
							stacked: true
						}]
					},
					events: ['click'],
					onClick: handleClick
				}

			});

			//막대차트 클릭 이벤트
			function handleClick(evt) {
				var activeElement = myBarChart.getElementAtEvent(evt);
				// index : activeElement[0]._index
				let index = activeElement[0]._index;
				let searchVal = document.getElementById("searchContent").value;
				let date = new Date(curYear,
					dateDivision[index].split('-')[0],
					dateDivision[index].split('-')[1]);
				date.setDate(date.getDate())
				//let strDate = date.toLocaleDateString().split('.')[0]+"-"+date.toLocaleDateString().split('.')[1].split(' ')[1]+"-"+date.toLocaleDateString().split('.')[2].split(' ')[1];
				let year = date.getFullYear();
				let month = '' + date.getMonth();
				let day = '' + date.getDate();
				if (month.length < 2) {
					month = '0' + month;
				}

				if (day.length < 2) {
					day = '0' + day;
				}

				/* 검색 조건 완성 */
				// 차트 클릭 시 해당 일자 파싱
				let strDate = year + "-" + month + "-" + day;
				var email = document.getElementById("searchContent").value; //이메일 검색 키워드

				$.ajax({
					url: "/myapps/getDataFromSearched",
					type: "POST",
					data: {
						date1: strDate,
						email: email
					},
					success: function (data) {
						getHistoryOnSearch(data);
					},
					error: function (request, status, error) {
						alert("리퀘스트 에러");
					}
				})

			}
		}
	</script>

	<!-- 원형 차트 -->
	<script>
		function fpieChart(title, emailDatas) {
			
			/* Pie Chart 구현 코드 */
			var pieCtx = document.getElementById('pieChart').getContext('2d');
			var myPieChart = new Chart(pieCtx, {
				type: 'pie',
				data: {
					labels: Object.keys(emailDatas),
					title: "ss",
					datasets: [{
						label: '# of Votes',
						data: Object.values(emailDatas),
						backgroundColor: [
							'rgba(54, 162, 235, 0.2)', 'rgba(255, 99, 132, 0.2)'
						],
						borderColor: [
							'rgba(54, 162, 235, 1)', 'rgba(255, 99, 132, 1)'
						],
						borderWidth: 1,
					}]
				},
				options: {
					title: {
						display: true,
						text: title
					},
					plugins: {
						datalabels: {
							color: 'black',
							font: {
								weight: 'bold',
								size: 30,
							}
						}
					},
					events: ['click'],
					onClick: handleClick
				}
			});

			function handleClick(evt) {
				var activeElement = myPieChart.getElementAtEvent(evt);
				
				// 배열의 index activeElement[0]._index
				let index = activeElement[0]._index;
				let email = Object.keys(emailDatas)[index];

				$.ajax({
					url: "/myapps/getDataFromSearched",
					type: "POST",
					data: {
						date1: "",
						email: email
					},
					success: function (data) {
						getHistoryOnSearch(data);
					},
					error: function (request, status, error) {
						alert("리퀘스트 에러");
					}
				})
			}
		}
	</script>

	<!--  jqGrid 구현 코드 -->
	<script>
		function fgridChart(historyDatas) {


			$(function() {
				"use strict";
				$("#grid").jqGrid({
					colModel: [{
						name: "Email"
					}, {
						name: "Accessed"
					}, {
						name: "Date"
					}],
					data: historyDatas,
					pager: '#pager',
					rowNum: 10,
					onCellSelect: cellClick,
					shrinkToFit: true,
					autowidth: true,
				});
			});

			function cellClick(id){
				let index = id.split('jqg')[1];

				$.ajax({
						url: "/myapps/getDataFromSearched",
						type: "POST",
						data: {
							date1: "",
							email: historyDatas[index-1].Email
						},
						success: function (data) {
							getHistoryOnSearch(data);
						},
						error: function (request, status, error) {
							alert("리퀘스트 에러");
						}
					})
			}
		}
	</script>

	
	<script>
	
		function checkIsEmpty(){
			let picker1 = document.getElementById("datepicker1");
			let picker2 = document.getElementById("datepicker2");
	
			let date1 = picker1.value;
	
			
	
			let date = new Date(date1.split('-')[0], date1.split('-')[1]-1, date1.split('-')[2]);
			let weekLater = new Date(date1.split('-')[0], date1.split('-')[1], date.getDate()+7);
	
			let year = weekLater.getFullYear();
			let week = weekLater.getMonth();
			let day = weekLater.getDate();
	
			if(week < 10){
				week = '0' + week;
			}
			if(day < 10){
				day = '0' + day;
			}
			
			if(picker2.value === ""){
				picker2.value=year+"-"+week+"-"+day;
			}
	
		}
	
	</script>

</body>

</html>