function test(clickObject) {
	console.log(clickObject);
	var elementList = clickObject.childNodes;
	
	console.log(elementList);
	
	var condition = {};
	condition.board_no = 0;
	
	var url = "./bbs/getBoard.do"
	$.ajax({ 
		type: "POST", 
		url: url, 
		data: condition, 
		dataType: "text", 
		success: function(response) {
			console.log(response);
		}, 
	});

	
}