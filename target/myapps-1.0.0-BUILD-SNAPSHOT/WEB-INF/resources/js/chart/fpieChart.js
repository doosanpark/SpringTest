function fpieChart(accessedCase) {
			/* Pie Chart 구현 코드 */

			var pieCtx = document.getElementById('pieChart').getContext('2d');
			var myPieChart = new Chart(pieCtx, {
				type : 'pie',
				data : {
					labels : [ 'Login Successed', 'Login Failed' ],
					datasets : [ {
						label : '# of Votes',
						data : accessedCase,
						backgroundColor : [

						'rgba(54, 162, 235, 0.2)', 'rgba(255, 99, 132, 0.2)'

						],
						borderColor : [ 'rgba(54, 162, 235, 1)',
								'rgba(255, 99, 132, 1)'

						],
						borderWidth : 1,

					} ]
				},
				options : {

					plugins : {
						datalabels : {
							color : 'black',
							labels : {
								title : {
									font : {
										weight : 'bold',
										size : 30
									}
								}
							}
						}
					}
				}
			});
		}
		
		