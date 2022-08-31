<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>학생등록</h1>
<form name="frm" method="post">
	<table>
		<tr>
			<td width=100>학생번호</td>
			<td width=500><input type="text" name="scode" value="${code}" readonly></td>
		</tr>
		<tr>
			<td>학생이름</td>
			<td><input type="text" name="sname"></td>
		</tr>
		<tr>
			<td>학생학과</td>
			<td>
				<select name="dept">
					<option value="전산">컴퓨터정보공학과</option>
					<option value="전자">전자공학과</option>
					<option value="건축">건축공학과</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>학생학년</td>
			<td>
				<input type="radio" name="year" value="1"> 1학년&nbsp;&nbsp;
				<input type="radio" name="year" value="2" checked> 2학년&nbsp;&nbsp;
				<input type="radio" name="year" value="3"> 3학년&nbsp;&nbsp;
				<input type="radio" name="year" value="4"> 4학년&nbsp;&nbsp;
			</td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td><input type="date" name="birthday" value="${birthday}"></td>
		</tr>
		<tr>
			<td>지도교수</td>
			<td><select name="advisor" id="advisor"></select></td>
		</tr>
	</table>
	<div class="buttons">
		<button type="submit">학생등록</button>
		<button type="reset">등록취소</button>
	</div>
</form>
<!-- 해당학과에 해당하는 교수 -->
<script id="temp" type="text/x-handlebars-template">
	{{#each array}}
		<option value="{{pcode}}">{{pname}}({{dept}}:{{pcode}})</option>
	{{/each}}
</script>

<script>

	changeDept();
	
	function changeDept() {
		var dept=$(frm.dept).val();
		$.ajax({
			type:"get",
			url:"/pro/list.json",
			dataType:"json",
			data:{key:"dept",word:dept,per:100,order:"pname",
						desc:"",page:1},
			success:function(data){
				var temp=Handlebars.compile($("#temp").html());
			 	$("#advisor").html(temp(data));
			}
		})
	}
	$(frm.dept).on("change", function(){
		changDept();
	
	})
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		var sname=$(frm.sname).val();
		
		if(sname==""){
			alert("학생이름을 입력하세요!");
			$(frm.sname).focus();
			return;
		}
		
		if(!confirm("새로운 학생를 등록하실래요?")) return;
		frm.submit();
	});
	
</script>