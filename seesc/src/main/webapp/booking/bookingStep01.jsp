<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.esc.thema.*"%>
<jsp:useBean id="thdao" class="com.esc.thema.ThemaDAO" scope="session"></jsp:useBean>
<%
String time_date=request.getParameter("time_date");

if(time_date==null || time_date==""){
	Calendar now=Calendar.getInstance();
	int yy=now.get(Calendar.YEAR);
	int mm=now.get(Calendar.MONTH)+1;
	int dd=now.get(Calendar.DATE);
	time_date=yy+"-"+mm+"-"+dd;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/seesc/css/mainLayout.css">
<style>
section{width:1200px;margin:0px auto;}
#a1{margin:0px 100px;}
#a1-0{background:lightgray;}
#a1-1{margin:20px auto;}
#a1-2{color:red;}
#a1-3{color:blue;}
select{margin:0px 950px;}
#a2{width:500px;float:left;}
#a3{width:580px;float:left;}
.a2-0{margin:10px 150px;}
.a2-1{margin:10px 0px;}
#a2-2{font-size:22px;}
.a2-3{margin-bottom:7px;}
</style>
</head>
<body>
<%@include file="/header.jsp"%>
<section>
 <article>
 <br><br>
 <h2 id="a1">테마 예약하기</h2>
 <br>
 <h4 align="center"><label id="a1-0">STEP01 날짜/테마 선택</label> &nbsp; STEP02 정보입력 &nbsp; STEP03 예약확인</h4>
 <br>
 <table id="a1-1">
 	<tr align="center" height="20">
 	<%
 	Calendar now=Calendar.getInstance();
 	
 	int w_i[]=new int[10];
 	String w[]=new String[10];
 	
 	int y[]=new int[10];
 	int m[]=new int[10];
 	int d[]=new int[10];
 	String ymd[]=new String[10];
 	
 	for(int z=0;z<10;z++){
 		w_i[z]=now.get(Calendar.DAY_OF_WEEK);
 		
 		switch(w_i[z]){
 			case 1:w[z]="S";break;
	 		case 2:w[z]="M";break;
	 		case 3:w[z]="T";break;
	 		case 4:w[z]="W";break;
	 		case 5:w[z]="T";break;
	 		case 6:w[z]="F";break;
	 		case 7:w[z]="S";
 		}
 		
 		if(w_i[z]==1){
 			%>
 			<td width="30" id="a1-2"><%out.print(w[z]);%></td>
 			<%
 		}else if(w_i[z]==7){
 			%>
 			<td width="30" id="a1-3"><%out.print(w[z]);%></td>
 			<%
 		}else{
 			%>
 			<td width="30"><%out.print(w[z]);%></td>
 			<%
 		}
 		
 		now.add(Calendar.DATE,1);
 	}
 	%>
 	</tr>
 	<tr align="center" height="20">
 	<%
 	now.add(Calendar.DATE,-10);
 	
 	for(int z=0;z<10;z++){
 		y[z]=now.get(Calendar.YEAR);
 		m[z]=now.get(Calendar.MONTH)+1;
 		d[z]=now.get(Calendar.DATE);
 		
 		ymd[z]=y[z]+"-"+m[z]+"-"+d[z];
 		
 		if(w_i[z]==1){
 			%>
 			<td id="a1-2"><a href="bookingStep01.jsp?time_date=<%=ymd[z]%>"><%out.print(d[z]);%></a></td>
 			<%
 		}else if(w_i[z]==7){
 			%>
 			<td id="a1-3"><a href="bookingStep01.jsp?time_date=<%=ymd[z]%>"><%out.print(d[z]);%></a></td>
 			<%
 		}else{
 			%>
 			<td><a href="bookingStep01.jsp?time_date=<%=ymd[z]%>"><%out.print(d[z]);%></a></td>
 			<%
 		}
 		
 		now.add(Calendar.DATE,1);
 	}
 	%>
 	</tr>
 </table>
</article>
<select>
	<option value="이름순">이름순</option>
	<option value="난이도순">난이도순</option>
	<option value="인기순">인기순</option>
</select>
<article>
 <%
 ThemaDTO dto[]=new ThemaDTO[7];
 dto[0]=thdao.themaInfo(1);
 
 if(dto[0]==null){
	 %>
	 <br><br><br>
	 <h3 align="center">잘못된 접근입니다.</h3>
	 <br><br><br>
	 <%@include file="/footer.jsp"%>
	 <%
	 return;
 }
 %>
 <h3 class="a2-0"><%=dto[0].getThema_name()%></h3>
 <div class="a2-0">난이도:<%
 					for(int i=1;i<=dto[0].getThema_level();i++){out.print("★");}
 					for(int i=1;i<=(5-dto[0].getThema_level());i++){out.print("☆");}%>&nbsp;&nbsp;
 					인원:<%=dto[0].getThema_people_min()%>~<%=dto[0].getThema_people_max()%>명&nbsp;&nbsp;
 					시간:<%=dto[0].getThema_time()%>분</div>
 <hr width="950">
</article>
<article id="a2">
 <img alt="방탈출 1" src="/seesc/thema_img/001.jpg" width="300" height="400" class="a2-0">
</article>
<article id="a3">
 <br><br><br><br>
 <label class="a2-1" id="a2-2">#사내연애 #운명 #로맨스</label><br><br>
 <label class="a2-1"><div class="a2-3">대학생 철수와 직장인 유리의 만남은 결코 우연이 아니었다!!!</div>
				<div class="a2-3">그들의 운명적인 만남 이야기</div></label><br>
 <a href="bookingStep02.jsp?thema_idx=1&time_date=<%=time_date%>&time_ptime=1"><input type="button" value="10:00 예약마감" class="a2-1"></a>
 <a href="bookingStep02.jsp?thema_idx=1&time_date=<%=time_date%>&time_ptime=2"><input type="button" value="12:00 예약마감"></a>
 <a href="bookingStep02.jsp?thema_idx=1&time_date=<%=time_date%>&time_ptime=3"><input type="button" value="14:00 예약마감"></a><br>
 <a href="bookingStep02.jsp?thema_idx=1&time_date=<%=time_date%>&time_ptime=4"><input type="button" value="16:00 예약마감" class="a2-1"></a>
 <a href="bookingStep02.jsp?thema_idx=1&time_date=<%=time_date%>&time_ptime=5"><input type="button" value="18:00 예약마감"></a>
 <a href="bookingStep02.jsp?thema_idx=1&time_date=<%=time_date%>&time_ptime=6"><input type="button" value="20:00 예약마감"></a><br><br><br><br><br><br><br><br><br>
</article>

<article>
 <%
 dto[1]=thdao.themaInfo(2);
 %>
 <h3 class="a2-0"><%=dto[1].getThema_name()%></h3>
 <div class="a2-0">난이도:<%
 					for(int i=1;i<=dto[1].getThema_level();i++){out.print("★");}
 					for(int i=1;i<=(5-dto[1].getThema_level());i++){out.print("☆");}%>&nbsp;&nbsp;
 					인원:<%=dto[1].getThema_people_min()%>~<%=dto[1].getThema_people_max()%>명&nbsp;&nbsp;
 					시간:<%=dto[1].getThema_time()%>분</div>
 <hr width="950">
</article>
<article id="a2">
 <img alt="방탈출 2" src="/seesc/thema_img/002.jpg" width="300" height="400" class="a2-0">
</article>
<article id="a3">
 <br><br><br><br>
 <label class="a2-1" id="a2-2">#괴물 #할로윈 #공포</label><br><br>
 <label class="a2-1"><div class="a2-3">할로윈의 밤 수많은 괴물들이 깨어나는 시간</div>
				<div class="a2-3">괴물들이 당신을 맞이할 것입니다.!</div></label><br>
 <a href="bookingStep02.jsp?thema_idx=2&time_date=<%=time_date%>&time_ptime=1"><input type="button" value="10:00 예약마감" class="a2-1"></a>
 <a href="bookingStep02.jsp?thema_idx=2&time_date=<%=time_date%>&time_ptime=2"><input type="button" value="12:00 예약마감"></a>
 <a href="bookingStep02.jsp?thema_idx=2&time_date=<%=time_date%>&time_ptime=3"><input type="button" value="14:00 예약마감"></a><br>
 <a href="bookingStep02.jsp?thema_idx=2&time_date=<%=time_date%>&time_ptime=4"><input type="button" value="16:00 예약마감" class="a2-1"></a>
 <a href="bookingStep02.jsp?thema_idx=2&time_date=<%=time_date%>&time_ptime=5"><input type="button" value="18:00 예약마감"></a>
 <a href="bookingStep02.jsp?thema_idx=2&time_date=<%=time_date%>&time_ptime=6"><input type="button" value="20:00 예약마감"></a><br><br><br><br><br><br><br><br><br>
</article>

<article>
 <%
 dto[2]=thdao.themaInfo(3);
 %>
 <h3 class="a2-0"><%=dto[2].getThema_name()%></h3>
 <div class="a2-0">난이도:<%
 					for(int i=1;i<=dto[2].getThema_level();i++){out.print("★");}
 					for(int i=1;i<=(5-dto[2].getThema_level());i++){out.print("☆");}%>&nbsp;&nbsp;
 					인원:<%=dto[2].getThema_people_min()%>~<%=dto[2].getThema_people_max()%>명&nbsp;&nbsp;
 					시간:<%=dto[2].getThema_time()%>분</div>
 <hr width="950">
</article>
<article id="a2">
 <img alt="방탈출 3" src="/seesc/thema_img/003.jpg" width="300" height="400" class="a2-0">
</article>
<article id="a3">
 <br><br><br><br>
 <label class="a2-1" id="a2-2">#학교 #폭행 #추리</label><br><br>
 <label class="a2-1"><div class="a2-3">중학생 철수는 순조로운 학창생활을 하고 있었는데</div>
				<div class="a2-3">갑자기 폭행 사건에 휘말려 가해자가 되고 마는데,</div>
				<div class="a2-3">철수를 도와 철수의 누명을 풀어주자!</div></label><br>
 <a href="bookingStep02.jsp?thema_idx=3&time_date=<%=time_date%>&time_ptime=1"><input type="button" value="10:00 예약마감" class="a2-1"></a>
 <a href="bookingStep02.jsp?thema_idx=3&time_date=<%=time_date%>&time_ptime=2"><input type="button" value="12:00 예약마감"></a>
 <a href="bookingStep02.jsp?thema_idx=3&time_date=<%=time_date%>&time_ptime=3"><input type="button" value="14:00 예약마감"></a><br>
 <a href="bookingStep02.jsp?thema_idx=3&time_date=<%=time_date%>&time_ptime=4"><input type="button" value="16:00 예약마감" class="a2-1"></a>
 <a href="bookingStep02.jsp?thema_idx=3&time_date=<%=time_date%>&time_ptime=5"><input type="button" value="18:00 예약마감"></a>
 <a href="bookingStep02.jsp?thema_idx=3&time_date=<%=time_date%>&time_ptime=6"><input type="button" value="20:00 예약마감"></a><br><br><br><br><br><br><br><br><br>
</article>

<article>
 <%
 dto[3]=thdao.themaInfo(4);
 %>
 <h3 class="a2-0"><%=dto[3].getThema_name()%></h3>
 <div class="a2-0">난이도:<%
 					for(int i=1;i<=dto[3].getThema_level();i++){out.print("★");}
 					for(int i=1;i<=(5-dto[3].getThema_level());i++){out.print("☆");}%>&nbsp;&nbsp;
 					인원:<%=dto[3].getThema_people_min()%>~<%=dto[3].getThema_people_max()%>명&nbsp;&nbsp;
 					시간:<%=dto[3].getThema_time()%>분</div>
 <hr width="950">
</article>
<article id="a2">
 <img alt="방탈출 4" src="/seesc/thema_img/004.jpg" width="300" height="400" class="a2-0">
</article>
<article id="a3">
 <br><br><br><br>
 <label class="a2-1" id="a2-2">#탐정 #미스터리 #추리</label><br><br>
 <label class="a2-1"><div class="a2-3">당신이 셜록홈즈가 되어</div>
				<div class="a2-3">미스터리한 사건을 해결하자!!</div></label><br>
 <a href="bookingStep02.jsp?thema_idx=4&time_date=<%=time_date%>&time_ptime=1"><input type="button" value="10:00 예약마감" class="a2-1"></a>
 <a href="bookingStep02.jsp?thema_idx=4&time_date=<%=time_date%>&time_ptime=2"><input type="button" value="12:00 예약마감"></a>
 <a href="bookingStep02.jsp?thema_idx=4&time_date=<%=time_date%>&time_ptime=3"><input type="button" value="14:00 예약마감"></a><br>
 <a href="bookingStep02.jsp?thema_idx=4&time_date=<%=time_date%>&time_ptime=4"><input type="button" value="16:00 예약마감" class="a2-1"></a>
 <a href="bookingStep02.jsp?thema_idx=4&time_date=<%=time_date%>&time_ptime=5"><input type="button" value="18:00 예약마감"></a>
 <a href="bookingStep02.jsp?thema_idx=4&time_date=<%=time_date%>&time_ptime=6"><input type="button" value="20:00 예약마감"></a><br><br><br><br><br><br><br><br><br>
</article>

<article>
 <%
 dto[4]=thdao.themaInfo(5);
 %>
 <h3 class="a2-0"><%=dto[4].getThema_name()%></h3>
 <div class="a2-0">난이도:<%
 					for(int i=1;i<=dto[4].getThema_level();i++){out.print("★");}
 					for(int i=1;i<=(5-dto[4].getThema_level());i++){out.print("☆");}%>&nbsp;&nbsp;
 					인원:<%=dto[4].getThema_people_min()%>~<%=dto[4].getThema_people_max()%>명&nbsp;&nbsp;
 					시간:<%=dto[4].getThema_time()%>분</div>
 <hr width="950">
</article>
<article id="a2">
 <img alt="방탈출 5" src="/seesc/thema_img/005.jpg" width="300" height="400" class="a2-0">
</article>
<article id="a3">
 <br><br><br><br>
 <label class="a2-1" id="a2-2">#재판 #두뇌싸움 #분별력</label><br><br>
 <label class="a2-1"><div class="a2-3">당신은 청소년 재판의 재판관이 되어</div>
				<div class="a2-3">분별력 있는 판결로 재판을 끝내주세요!!</div></label><br>
 <a href="bookingStep02.jsp?thema_idx=5&time_date=<%=time_date%>&time_ptime=1"><input type="button" value="10:00 예약마감" class="a2-1"></a>
 <a href="bookingStep02.jsp?thema_idx=5&time_date=<%=time_date%>&time_ptime=2"><input type="button" value="12:00 예약마감"></a>
 <a href="bookingStep02.jsp?thema_idx=5&time_date=<%=time_date%>&time_ptime=3"><input type="button" value="14:00 예약마감"></a><br>
 <a href="bookingStep02.jsp?thema_idx=5&time_date=<%=time_date%>&time_ptime=4"><input type="button" value="16:00 예약마감" class="a2-1"></a>
 <a href="bookingStep02.jsp?thema_idx=5&time_date=<%=time_date%>&time_ptime=5"><input type="button" value="18:00 예약마감"></a>
 <a href="bookingStep02.jsp?thema_idx=5&time_date=<%=time_date%>&time_ptime=6"><input type="button" value="20:00 예약마감"></a><br><br><br><br><br><br><br><br><br>
</article>

<article>
 <%
 dto[5]=thdao.themaInfo(6);
 %>
 <h3 class="a2-0"><%=dto[5].getThema_name()%></h3>
 <div class="a2-0">난이도:<%
 					for(int i=1;i<=dto[5].getThema_level();i++){out.print("★");}
 					for(int i=1;i<=(5-dto[5].getThema_level());i++){out.print("☆");}%>&nbsp;&nbsp;
 					인원:<%=dto[5].getThema_people_min()%>~<%=dto[5].getThema_people_max()%>명&nbsp;&nbsp;
 					시간:<%=dto[5].getThema_time()%>분</div>
 <hr width="950">
</article>
<article id="a2">
 <img alt="방탈출 6" src="/seesc/thema_img/006.jpg" width="300" height="400" class="a2-0">
</article>
<article id="a3">
 <br><br><br><br>
 <label class="a2-1" id="a2-2">#첫사랑 #징검다리 #로맨스</label><br><br>
 <label class="a2-1"><div class="a2-3">사랑을 해본 적 없는 은지와 철수는</div>
				<div class="a2-3">서로 썸을 타고 있지만 서로에게 먼저 말을 건네기 어려운데</div>
				<div class="a2-3">그들의 징검다리가 되어 사랑을 이어주자!</div></label><br>
 <a href="bookingStep02.jsp?thema_idx=6&time_date=<%=time_date%>&time_ptime=1"><input type="button" value="10:00 예약마감" class="a2-1"></a>
 <a href="bookingStep02.jsp?thema_idx=6&time_date=<%=time_date%>&time_ptime=2"><input type="button" value="12:00 예약마감"></a>
 <a href="bookingStep02.jsp?thema_idx=6&time_date=<%=time_date%>&time_ptime=3"><input type="button" value="14:00 예약마감"></a><br>
 <a href="bookingStep02.jsp?thema_idx=6&time_date=<%=time_date%>&time_ptime=4"><input type="button" value="16:00 예약마감" class="a2-1"></a>
 <a href="bookingStep02.jsp?thema_idx=6&time_date=<%=time_date%>&time_ptime=5"><input type="button" value="18:00 예약마감"></a>
 <a href="bookingStep02.jsp?thema_idx=6&time_date=<%=time_date%>&time_ptime=6"><input type="button" value="20:00 예약마감"></a><br><br><br><br><br><br><br><br><br>
</article>

<article>
 <%
 dto[6]=thdao.themaInfo(7);
 %>
 <h3 class="a2-0"><%=dto[6].getThema_name()%></h3>
 <div class="a2-0">난이도:<%
 					for(int i=1;i<=dto[6].getThema_level();i++){out.print("★");}
 					for(int i=1;i<=(5-dto[6].getThema_level());i++){out.print("☆");}%>&nbsp;&nbsp;
 					인원:<%=dto[6].getThema_people_min()%>~<%=dto[6].getThema_people_max()%>명&nbsp;&nbsp;
 					시간:<%=dto[6].getThema_time()%>분</div>
 <hr width="950">
</article>
<article id="a2">
 <img alt="방탈출 7" src="/seesc/thema_img/007.jpg" width="300" height="400" class="a2-0">
</article>
<article id="a3">
 <br><br><br><br>
 <label class="a2-1" id="a2-2">#바이러스 #좀비 #공포</label><br><br>
 <label class="a2-1"><div class="a2-3">2023년 갑자기 좀비바이러스가 퍼진다</div>
				<div class="a2-3">쉘터의 마지막 생존자가 된 당신 어떻게 살아남을 것인가!</div></label><br>
 <a href="bookingStep02.jsp?thema_idx=7&time_date=<%=time_date%>&time_ptime=1"><input type="button" value="10:00 예약마감" class="a2-1"></a>
 <a href="bookingStep02.jsp?thema_idx=7&time_date=<%=time_date%>&time_ptime=2"><input type="button" value="12:00 예약마감"></a>
 <a href="bookingStep02.jsp?thema_idx=7&time_date=<%=time_date%>&time_ptime=3"><input type="button" value="14:00 예약마감"></a><br>
 <a href="bookingStep02.jsp?thema_idx=7&time_date=<%=time_date%>&time_ptime=4"><input type="button" value="16:00 예약마감" class="a2-1"></a>
 <a href="bookingStep02.jsp?thema_idx=7&time_date=<%=time_date%>&time_ptime=5"><input type="button" value="18:00 예약마감"></a>
 <a href="bookingStep02.jsp?thema_idx=7&time_date=<%=time_date%>&time_ptime=6"><input type="button" value="20:00 예약마감"></a><br><br><br><br><br><br><br><br><br>
</article>
</section>
<hr width="1200">
<%@include file="/footer.jsp"%>
</body>
</html>