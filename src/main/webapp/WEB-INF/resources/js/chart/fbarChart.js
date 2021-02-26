/*
function fbarChart(curYear, dateDivision, dateCntArray) {
	// Bar Chart 구현 코드
	var barCtx = document.getElementById('barChart').getContext('2d');


	var myBarChart = new Chart(barCtx, {
		type : 'bar',
		data : {
			labels : dateDivision,
			datasets : [ {
				label : "조회년도: "+curYear+"년",
				data : dateCntArray,
				backgroundColor : [ 'rgba(255, 99, 132, 0.2)',
						'rgba(255, 99, 132, 0.2)', 'rgba(255, 99, 132, 0.2)',
						'rgba(255, 99, 132, 0.2)', 'rgba(255, 99, 132, 0.2)',
						'rgba(255, 99, 132, 0.2)', ],
				borderColor : [ 'rgba(255, 99, 132, 1)',
						'rgba(255, 99, 132, 1)', 'rgba(255, 99, 132, 1)',
						'rgba(255, 99, 132, 1)', 'rgba(255, 99, 132, 1)',
						'rgba(255, 99, 132, 1)', ],
				borderWidth : 1
			} ]
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
				xAxes: [
					{
						stacked: true
					}
				],
				yAxes: [
					{
						stacked: true
					}
				]
			},
			onClick: handleClick
		}

	});


	
	//막대차트 클릭
	function handleClick(evt){
		var activeElement = myBarChart.getElementAtEvent(evt);

		let searchVal = document.getElementById("searchContent").value;
		let date = new Date(curYear,dateDivision[activeElement[0]._index].split('-')[0],dateDivision[activeElement[0]._index].split('-')[1]);
		date.setDate(date.getDate())
		//let strDate = date.toLocaleDateString().split('.')[0]+"-"+date.toLocaleDateString().split('.')[1].split(' ')[1]+"-"+date.toLocaleDateString().split('.')[2].split(' ')[1];
		let year = date.getFullYear();
		let month = '' + (date.getMonth() + 1);
        let day = '' + date.getDate();
		if (month.length < 2) {
			month = '0' + month;
		}
        	
		if (day.length < 2) {
			day = '0' + day;
		}

		// 검색 조건 완성 
		// 차트 클릭 시 해당 일자 파싱
		let strDate = year+"-"+month+"-"+day;
		var email = document.getElementById("searchContent").value; //이메일 검색 키워드

		$.ajax({
			url : "/myapps/getDataFromSearched",
			type : "POST",
			data : {
				date1 : strDate,
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
}

*/