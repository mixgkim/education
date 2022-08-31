<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.row {text-align:center;}
	.none {text-align:center; color:red;}
	#condition{overflow:hidden;}
	#condition form {float:left;}
	#condition a button{float:right;}
</style>    
<h1>학생목록</h1>
검색수:<span id="total"></span>
<div id="condition">
	<form name="frm">
		<select name="key" id="key">
			<option value="scode">학생번호</option>
			<option value="sname">학생이름</option>
			<option value="dept">학생학과</option>			
		</select>
		<input type="text" name="word" placeholder="검색어">
		<select name="per" id="per">
			<option value="2">2행</option>
			<option value="3" selected>3행</option>
			<option value="5">5행</option>
			<option value="10">10행</option>
		</select>
		<div style="float:right;">
		<select name="order" id="order">
			<option value="scode">학생번호</option>
			<option value="sname">학생이름</option>
			<option value="dept">학생학과</option>
		</select>
		<select name="desc" id="desc">
			<option value="asc">오름차순</option>
			<option value="desc">내림차순</option>
		</select>
		<button>검색</button>
		<a href="/stu/insert" style="margin-left: 270px;"><button type="button">학생등록</button></a>
		</div>
	</form>
</div>
<table id="tbl"></table>
<script id="temp" type="text/x-handlebars-template">
	<tr class="title">
		<td width=150>학생번호</td>
		<td width=100>학생이름</td>
		<td width=100>학생학과</td>
		<td width=100>학년</td>
		<td width=200>생년월일</td>
		<td width=200>지도교수</td>
	</tr>
	{{#each array}}
	<tr class="row" onclick="location.href='/stu/read?scode={{scode}}'">
		<td class="scode">{{scode}}</td>
		<td class="sname">{{sname}}</td>
		<td class="dept">{{dept}}</td>
		<td class="year">{{year}}</td>
		<td class="birthday">{{birthday}}</td>
		<td class="advisor">{{pname}}({{pdept}})</td>
	</tr>
	{{/each}}
</script>
<div class="buttons" style="text-align:center;">
	<button id="prev">이전</button>
	<span id="page">1/10</span>
	<button id="next">다음</button>
</div>

<script>
	var page=1;
	getList();
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		page=1;
		getList();
	});
	
	$("#key, #per, #order, #desc").on("change", function(){
		page=1;
		getList();
	});
	
	$("#next").on("click", function(){
		page++;
		getList();
	});
	
	$("#prev").on("click", function(){
		page--;
		getList();
	});
	
	function getList(){
		var key=$(frm.key).val();
		var word=$(frm.word).val();
		var per=$(frm.per).val();
		var order=$(frm.order).val();
		var desc=$(frm.desc).val();
		$.ajax({
			type:"get",
			url:"/stu/list.json",
			dataType:"json",
			data:{key:key,word:word,per:per,order:order,
						desc:desc,page:page},
			success:function(data){
				//console.log(JSON.stringify(data));
				var temp=Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
				$("#total").html(data.total);
				
				if(data.total==0){
					$("#tbl").append("<tr><td colspan=6 class='none'>검색된 자료가 없습니다!</td></tr>");
					$(".buttons").hide();
				}else{
					$("#page").html(page + "/" + data.last);
					
					if(page==1) $("#prev").attr("disabled", true);
					else $("#prev").attr("disabled", false);
					
					if(page==data.last) $("#next").attr("disabled", true);
					else $("#next").attr("disabled", false);
					$(".buttons").show();
				}
			}
		});
	}
</script>