<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
    <script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
	<button onclick="getData()">데이터 호출</button>
    <div id="wrapper"></div>

    <script>
    
    	function getData(){
	    	$.ajax({
	    		url: "/myapps/get/test/data",
				type: "POST",
				success: function(res){
					console.log("res", res);
				},
				error: function(err){
					console.log("err", err);
				}
	    	})
    		
    	}
    
        const dataSource = {
        		  contentType: 'application/json',
        		  api: {
        		    readData: {
        	    		url: "/myapps/get/test/data",
        		      method: 'POST'
        		    },
        		  }
        		};
        const grid = new tui.Grid({
            el: document.getElementById('wrapper'),
            data: dataSource,
        columns: [
          {
            header: 'Name',
            name: 'name',
            editor: 'text'
          },
          {
            header: 'Artist',
            name: 'artist'
          },
          {
            header: 'Type',
            name: 'type'
          },
          {
            header: 'Release',
            name: 'release'
          },
          {
            header: 'Genre',
            name: 'genre'
          },
          {
            header: 'Price',
            name: 'price'
          },
          {
            header: 'Download',
            name: 'download'
          },
          {
            header: 'Listen',
            name: 'listen'
          }
        ]
      });
  

    </script>
</body>
</html>