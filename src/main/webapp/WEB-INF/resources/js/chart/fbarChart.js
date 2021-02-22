function fbarChart(dateDivision, dateCntArray) {
	/* Bar Chart 구현 코드 */
	var barCtx = document.getElementById('barChart').getContext('2d');
	var myBarChart = new Chart(barCtx, {
		type : 'bar',
		data : {
			labels : dateDivision,
			datasets : [ {
				label : 'Login Cnt',
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
		options : {
			scales : {
				yAxes : [ {
					ticks : {
						beginAtZero : true,
						callback : function(value) {
							if (0 === value % 1) {
								return value;
							}
						}
					}
				} ]
			}
		}

	});
}