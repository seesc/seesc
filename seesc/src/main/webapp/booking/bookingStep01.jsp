<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.esc.thema.*"%>
<jsp:useBean id="thdao" class="com.esc.thema.ThemaDAO" scope="session"></jsp:useBean>
<jsp:useBean id="bdao" class="com.esc.booking.BookingDAO" scope="session"></jsp:useBean>
<jsp:useBean id="udao" class="com.esc.userinfo.UserinfoDAO" scope="session"></jsp:useBean>
<%
String time_date=request.getParameter("time_date");

if(time_date==null || time_date.equals("")){
	Calendar now=Calendar.getInstance();
	
	int yy=now.get(Calendar.YEAR);
	int mm=now.get(Calendar.MONTH)+1;
	int dd=now.get(Calendar.DATE);
	int ww_i=now.get(Calendar.DAY_OF_WEEK);
	String ww="";
	
	switch(ww_i){
	case 1:ww="일요일";break;
	case 2:ww="월요일";break;
	case 3:ww="화요일";break;
	case 4:ww="수요일";break;
	case 5:ww="목요일";break;
	case 6:ww="금요일";break;
	case 7:ww="토요일";
	}
	
	time_date=yy+"-"+mm+"-"+dd+" "+ww;
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
a{text-decoration:none;color:white;}
#a1{margin:0px 100px;}
#a1-1{margin:20px auto;}
#a1-2{color:red;}
#a1-3{color:#327FFA;}
select{margin:0px 960px;}
#a2{width:500px;float:left;}
#a3{width:580px;float:left;}
.a2-0{margin:10px 150px;}
.a2-1{margin:10px 0px;}
#a2-2{font-size:22px;}
.a2-3{margin-bottom:7px;}
.button1{background-color:gray;color:lightgray;border-radius:5px;margin:10px 0px;height:40px;width:120px;}
.button2{background-color:green;color:white;border-radius:5px;border:solid 1px green;margin:10px 0px;width:40px;height:40px;width:120px;}
</style>
</head>
<body>
<%@include file="/header.jsp"%>
<section>
 <div>
 <article>
 <br><br>
 <h2 class="h1">테마 예약하기</h2>
 <br><hr width="200px" align="center">
 <br><br>
 <h4 align="center"><img src="/seesc/thema_img/Step01_1.png" alt="STEP 01" height="110"> &nbsp; <img src="/seesc/thema_img/Step02_2.png" alt="STEP 02" height="100"> &nbsp; <img src="/seesc/thema_img/Step03_2.png" alt="STEP 03" height="100"></h4>
 <br>
 <table id="a1-1" cellspacing="10">
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
 			<td width="30" id="a1-2"><h3><%out.print(w[z]);%></h3></td>
 			<%
 		}else if(w_i[z]==7){
 			%>
 			<td width="30" id="a1-3"><h3><%out.print(w[z]);%></h3></td>
 			<%
 		}else{
 			%>
 			<td width="30"><h3><%out.print(w[z]);%></h3></td>
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
		w_i[z]=now.get(Calendar.DAY_OF_WEEK);
 		
 		switch(w_i[z]){
 			case 1:w[z]="일요일";break;
	 		case 2:w[z]="월요일";break;
	 		case 3:w[z]="화요일";break;
	 		case 4:w[z]="수요일";break;
	 		case 5:w[z]="목요일";break;
	 		case 6:w[z]="금요일";break;
	 		case 7:w[z]="토요일";
 		}
 		
 		ymd[z]=y[z]+"-"+m[z]+"-"+d[z]+" "+w[z];
 		
 		if(w_i[z]==1){
 			%>
 			<td id="a1-2" class="date"><a href="bookingStep01.jsp?time_date=<%=ymd[z]%>" style="color:red;"><h3><%out.print(d[z]);%></h3></a></td>
 			<%
 		}else if(w_i[z]==7){
 			%>
 			<td id="a1-3" class="date"><a href="bookingStep01.jsp?time_date=<%=ymd[z]%>" style="color:#327FFA;"><h3><%out.print(d[z]);%></h3></a></td>
 			<%
 		}else{
 			%>
 			<td class="date"><a href="bookingStep01.jsp?time_date=<%=ymd[z]%>"><h3><%out.print(d[z]);%></h3></a></td>
 			<%
 		}
 		
 		now.add(Calendar.DATE,1);
 	}
 	%>
 	</tr>
 </table>
</article>
<br>
<select onchange="if(this.value) location.href=(this.value);" style="width:90px;height:30px;">
	<option value="/seesc/booking/bookingStep01.jsp?time_date=<%=time_date%>">정렬순</option>
	<option value="/seesc/booking/bookingStep01_1.jsp?time_date=<%=time_date%>">이름순</option>
	<option value="/seesc/booking/bookingStep01_2.jsp?time_date=<%=time_date%>">난이도순</option>
	<option value="/seesc/booking/bookingStep01_3.jsp?time_date=<%=time_date%>">인기순</option>
</select>
<br>
<article>
 <%
 ArrayList<Integer> idx_idx=new ArrayList<Integer>();
 idx_idx=thdao.themaInfo_Idx();
 
 ArrayList<ThemaDTO> dto=new ArrayList<ThemaDTO>();
 
 Integer user_idx=(Integer)session.getAttribute("user_idx");
 
 StringBuffer time_date_b=new StringBuffer(time_date);
 time_date_b.delete(time_date_b.length()-4,time_date_b.length());
 String time_date_in=time_date_b.toString();

 ArrayList<Integer> booking_idx=new ArrayList<Integer>();
 %>
</article>
<%
SimpleDateFormat sdf=new SimpleDateFormat("yyyy-mm-dd HH:mm:ss");

int HH=now.get(Calendar.HOUR_OF_DAY);
int mm=now.get(Calendar.MINUTE);
int ss=now.get(Calendar.SECOND);
Date time=sdf.parse(y[0]+"-"+m[0]+"-"+d[0]+" "+HH+":"+mm+":"+ss);

StringBuffer time_date_sb=new StringBuffer(time_date);
time_date_sb.delete(time_date_sb.length()-4,time_date_sb.length());
String time_date_c=time_date_sb.toString();

Date ctime[]=new Date[6];
for(int i=0;i<6;i++){
	ctime[i]=sdf.parse(time_date_c+" "+(10+i*2)+":"+00+":"+00);
}

for(int j=0;j<idx_idx.size();j++){%>
	<article>
	<%
	dto.add(thdao.themaInfo(idx_idx.get(j)));
	
	if(j==0){
		if(dto.get(j)==null){
		%>
		<br><br><br>
		<h3 align="center">잘못된 접근입니다.</h3>
		<br><br><br>
		<%@include file="/footer.jsp"%>
		<%
		return;
		}
	}
	%>
	 <h3 class="a2-0"><%=dto.get(j).getThema_name()%></h3>
	 <div class="a2-0">난이도:<%
	 					for(int i=1;i<=dto.get(j).getThema_level();i++){out.print("★");}
	 					for(int i=1;i<=(5-dto.get(j).getThema_level());i++){out.print("☆");}%>&nbsp;&nbsp;
	 					인원:<%=dto.get(j).getThema_people_min()%>~<%=dto.get(j).getThema_people_max()%>명&nbsp;&nbsp;
	 					시간:<%=dto.get(j).getThema_time()%>분
	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%
	 if(user_idx!=null){
		 int manager=udao.mngnum(user_idx);
	 	 if(manager==1){%>
	 		 <a href="/seesc/booking/bookingStep01_up.jsp?thema_idx=<%=idx_idx.get(j)%>"><input type="button" name="themaUpdate" value="테마 수정" style="height:25px;width:80px;"></a> &nbsp; <input type="button" name="themaDelete" value="테마 삭제" onclick="window.open('/seesc/booking/del_popup.jsp?thema_idx=<%=idx_idx.get(j)%>','del_popup.jsp','width=550,height=300,top=100,left=300');" style="height:25px;width:80px;">
	 	 <%}%>
	 <%}%></div>
	 <hr width="950">
	</article>
	<article id="a2">
	 <img alt="방탈출 <%=idx_idx.get(j)%>" src="/seesc/thema_img/<%=thdao.imgSelect_N(dto.get(j).getImg_idx())%>" width="300" height="400" class="a2-0">
	</article>
	<article id="a3">
	 <br><br><br><br>
	 <label class="a2-1" id="a2-2">#<%=dto.get(j).getThema_tag1()%> #<%=dto.get(j).getThema_tag2()%> #<%=dto.get(j).getThema_tag3()%></label><br><br>
	 <label class="a2-1"><div class="a2-3"><%=dto.get(j).getThema_intro1()%></div>
					<div class="a2-3"><%=dto.get(j).getThema_intro2()%></div>
					<%if(dto.get(j).getThema_intro3()!=null){%><div class="a2-3"><%=dto.get(j).getThema_intro3()%></div></label><%}%><br>
	 <%
	 booking_idx.add(bdao.bookingIdx(idx_idx.get(j),time_date_in,1));
	 booking_idx.add(bdao.bookingIdx(idx_idx.get(j),time_date_in,2));
	 booking_idx.add(bdao.bookingIdx(idx_idx.get(j),time_date_in,3));
	 booking_idx.add(bdao.bookingIdx(idx_idx.get(j),time_date_in,4));
	 booking_idx.add(bdao.bookingIdx(idx_idx.get(j),time_date_in,5));
	 booking_idx.add(bdao.bookingIdx(idx_idx.get(j),time_date_in,6));
	 %>
	 <a href="bookingStep02.jsp?thema_idx=<%=idx_idx.get(j)%>&time_date=<%=time_date%>&time_ptime=1"><input type="button" <%
	 	if(time.after(ctime[0])){
	 		out.print("value='10:00 예약마감' disabled class='button1'");
	 	}else{
	 		if(booking_idx.get(j*6)>0){
	 			out.print("value='10:00 예약마감' disabled class='button1'");
	 		}else{
	 			out.print("value='10:00 예약가능' class='button2'");
	 		}
	 	}%>></a> &nbsp;
	 <a href="bookingStep02.jsp?thema_idx=<%=idx_idx.get(j)%>&time_date=<%=time_date%>&time_ptime=2"><input type="button" <%
	 	if(time.after(ctime[1])){
	 		out.print("value='12:00 예약마감' disabled class='button1'");
	 	}else{
	 		if(booking_idx.get(j*6+1)>0){
	 			out.print("value='12:00 예약마감' disabled class='button1'");
	 		}else{
	 			out.print("value='12:00 예약가능' class='button2'");
	 		}
	 	}%>></a> &nbsp;
	 <a href="bookingStep02.jsp?thema_idx=<%=idx_idx.get(j)%>&time_date=<%=time_date%>&time_ptime=3"><input type="button" <%
	 	if(time.after(ctime[2])){
	 		out.print("value='14:00 예약마감' disabled class='button1'");
	 	}else{
	 		if(booking_idx.get(j*6+2)>0){
	 			out.print("value='14:00 예약마감' disabled class='button1'");
	 		}else{
	 			out.print("value='14:00 예약가능' class='button2'");
	 		}
	 	}%>></a><br>
	 <a href="bookingStep02.jsp?thema_idx=<%=idx_idx.get(j)%>&time_date=<%=time_date%>&time_ptime=4"><input type="button" <%
	 	if(time.after(ctime[3])){
	 		out.print("value='16:00 예약마감' disabled class='button1'");
	 	}else{
	 		if(booking_idx.get(j*6+3)>0){
	 			out.print("value='16:00 예약마감' disabled class='button1'");
	 		}else{
	 			out.print("value='16:00 예약가능' class='button2'");
	 		}
	 	}%>></a> &nbsp;
	 <a href="bookingStep02.jsp?thema_idx=<%=idx_idx.get(j)%>&time_date=<%=time_date%>&time_ptime=5"><input type="button" <%
	 	if(time.after(ctime[4])){
	 		out.print("value='18:00 예약마감' disabled class='button1'");
	 	}else{
	 		if(booking_idx.get(j*6+4)>0){
	 			out.print("value='18:00 예약마감' disabled class='button1'");
	 		}else{
	 			out.print("value='18:00 예약가능' class='button2'");
	 		}
	 	}%>></a> &nbsp;
	 <a href="bookingStep02.jsp?thema_idx=<%=idx_idx.get(j)%>&time_date=<%=time_date%>&time_ptime=6"><input type="button" <%
	 	if(time.after(ctime[5])){
	 		out.print("value='20:00 예약마감' disabled class='button1'");
	 	}else{
	 		if(booking_idx.get(j*6+5)>0){
	 			out.print("value='20:00 예약마감' disabled class='button1'");
	 		}else{
	 			out.print("value='20:00 예약가능' class='button2'");
	 		}
	 	}%>></a><br><br><br><br><br><br><br><br><br>
	</article>
<%}%>
<article>
 <%
 if(user_idx!=null){
	 int manager=udao.mngnum(user_idx);
 	 if(manager==1){%>
 	 	<hr width="950">
 	 	<br><table><tr><td>
 		 <a href="/seesc/booking/bookingStep01_in.jsp"><input type="button" name="themaInsert" value="테마 추가" style="height:25px;width:80px;"></a>
 		</td></tr></table><br>
 	 <%}%>
 <%}%>
</article>
</div>
</section>
<%@include file="/footer.jsp"%>
</body>
</html>