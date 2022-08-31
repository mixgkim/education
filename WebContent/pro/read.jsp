<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	td {border:1px solid black;}
	h2 {text-align: center;margin-bottom:30px;}
</style>    
<h1>교수정보</h1>
<form name="frm" method="post">
	<table>
		<tr>
			<td width=100 class="title">교수번호</td>
			<td width=100><input type="text" value="${vo.pcode}" name="pcode" size=5></td>
			<td width=100 class="title">교수학과</td>
			<td width=200>
				<select name="dept">
					<option value="전산" <c:out value="${vo.dept=='전산'?'selected':''}"/>>컴퓨터정보공학과</option>
					<option value="전자" <c:out value="${vo.dept=='전자'?'selected':''}"/>>전자공학과</option>
					<option value="건축" <c:out value="${vo.dept=='건축'?'selected':''}"/>>건축공학과</option>
				</select>
			</td>
			<td width=100 class="title">임용일자</td>
			<td width=300><input type="date" value="${vo.hiredate}" name="hiredate"></td>
		</tr>
		<tr>
			<td class="title">교수이름</td>
			<td><input type="text" value="${vo.pname}" name="pname" size="8"></td>
			<td class="title">교수급여</td>
			<td><input type="text" value="${vo.salary}" name="salary"></td>
			<td class="title">교수직급</td>
			<td>
				<input type="radio" name="title" value="정교수" <c:out value="${vo.title=='정교수'?'checked':''}"/>> 정교수&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="title" value="부교수" <c:out value="${vo.title=='부교수'?'checked':''}"/>> 부교수&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" name="title" value="조교수" <c:out value="${vo.title=='조교수'?'checked':''}"/>> 조교수
			</td>
		</tr>
	</table>
	<div class="buttons">
		<button type="submit">정보수정</button>
		<button type="reset">수정취소</button>
	</div>
</form>

<h2>담당과목</h2>
 	<table id="clist"></table>
 	<script id="temp" type="text/x-handlebars-template">
 		<tr class="title">
			<td width=100>강좌번호</td>
			<td width=300>강좌이름</td>
			<td width=100>강의실</td>
			<td width=100>강의시수</td>
			<td width=100>수강인원</td>
			<td width=110>강좌정보</td>
		</tr>
 		{{#each .}}
 		<tr class="row" style = "text-align: center;">
 			<td class="lcode">{{lcode}}</td>
 			<td class="lname">{{lname}}</td>
 			<td class="room">{{room}}</td>
 			<td class="hours">{{hours}}</td>
 			<td class="per_capacity">{{persons}}/{{capacity}}</td>
 			<td><button onclick="location.href='/cou/read?lcode={{lcode}}'">강좌정보</td>
 		</tr>
 		{{/each}}
 	</script>
<br></br>
<h2>담당학생</h2>
	<table id="slist"></table>
 	<script id="temp1" type="text/x-handlebars-template">
 		<tr class="title">
			<td width=100>학생번호</td>
			<td width=100>학생이름</td>
			<td width=100>학생학과</td>
			<td width=100>학생학년</td>
			<td width=200>생년월일</td>
			<td width=110>강좌정보</td>
		</tr>
 		{{#each .}}
 		<tr class="row" style = "text-align: center;">
 			<td class="scode">{{scode}}</td>
 			<td class="sname">{{sname}}</td>
 			<td class="dept">{{dept}}</td>
 			<td class="year">{{year}}</td>
 			<td class="birthday">{{birthday}}</td>
 			<td><a href="/stu/read?scode={{scode}}"><button>학생정보</button></a></td>
 		</tr>
 		{{/each}}
	</script>

<script>
	var pcode="${vo.pcode}";
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		if(!confirm("교수정보를 수정하시겠습니까?")) return;
		frm.action="/pro/update";
		frm.submit();
	})
	
	//담당과목 출력
	$.ajax({
		tpye: "get",
		url : "/pro/clist.json",
		data:{pcode:pcode},
		dataType: "json",
		success:function(data) {
			var temp=Handlebars.compile($("#temp").html());
			 	$("#clist").html(temp(data));
			if(data.length==0) {
				$("#clist").append("<tr><td colspan=6 class='none'>검색된 자료가 없습니다!</td></tr>");
			}
		}
	})
	
	//담당학생 출력
		$.ajax({
		tpye: "get",
		url : "/pro/slist.json",
		data: {pcode:pcode},
		dataType: "json",
		success:function(data) {
			var temp=Handlebars.compile($("#temp1").html());
			 	$("#slist").html(temp(data));
			if(data.length==0) {
				$("#slist").append("<tr><td colspan=6 class='none'>검색된 자료가 없습니다!</td></tr>");
			}
		}
	})
	
</script>