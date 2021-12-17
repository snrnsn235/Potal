<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>

</head>
<body>
<jsp:include page="menu.jsp"/>
<div align="center">
	<div><h1>Well Come to my Web-Site</h1></div>
	<!--  
	<button type="button" onclick="memberList()">멤버리스트 ajax 호출하기</button>
	<div id="memberList"></div> 
	-->
	<canvas id="myChart" style="width:100%;max-width:700px"></canvas>
</div>

<script>
var xValues = [];
var yValues = [];
generateData("Math.sin(x)", 0, 10, 0.5);

new Chart("myChart", {
  type: "line",
  data: {
    labels: xValues,
    datasets: [{
      fill: false,
      pointRadius: 2,
      borderColor: "rgba(0,0,255,0.5)",
      data: yValues
    }]
  },    
  options: {
    legend: {display: false},
    title: {
      display: true,
      text: "y = x * 2 + 7",
      fontSize: 16
    }
  }
});
function generateData(value, i1, i2, step = 1) {
  for (let x = i1; x <= i2; x += step) {
    yValues.push(eval(value));
    xValues.push(x);
  }
}
</script>



<script type="text/javascript">
	function memberList() {
		$.ajax({
			url : "ajaxMemberList.do",
			type : "post",
			dataType : "json",
			success : function(data){  //넘어온 데이터를 가공해서 원하는 곳에 출력해준다.
				//데이터 존재시 html로 보여주기
				if(data.length > 0){
					viewHtml(data);
				}else{
					alert("데이터가 존재하지 않습니다.");
				}
			},
			error : function() {
				alert("데이터 가져오기 실패!!!!")
			}
		});		
	}
	
	function viewHtml(data) {
		var html = "<br><table border='1'>";
		html += "<tr>";
		html += "<th width='150'>아이디</th>";
		html += "<th width='150'>이 름</th>";
		html += "<th width='150'>전화번호</th>";
		html += "<th width='200'>주 소</th>";
		html += "<th width='150'>권 한</th><tr/>";
		$(data).each(function(index, item) {  //data를 item 변수로 반복하겠다는 의미
			html += "<tr align='center'>";
			html += "<td>" + item.id + "</td>";
			html += "<td>" + item.name + "</td>";
			html += "<td>" + item.tel + "</td>";
			html += "<td>" + item.address + "</td>";
			html += "<td>" + item.author + "</td></tr>";
		});
		html += "</table>";
		html += "<br>";
		html += "<button type='button' onclick='clsoeData()'>";
		html += "데이터창 닫기</button>";
		$("#memberList").append(html);
	}
	
	function clsoeData(){
		$("#memberList").empty(); 
	}
</script>
</body>
</html>