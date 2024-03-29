<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.*" %>
    <%@page import="com.esc.booking.*" %>
    <jsp:useBean id="boodao" class="com.esc.booking.BookingDAO" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
table {
  width: 100%;
  border-collapse: collapse;
}

th, td {
  text-align: left;
  padding: 8px;
  text-align: center;
}

th {
  background-color: #f2f2f2;
  color: black;
}
</style>
<%
int user_idx=(int)session.getAttribute("user_idx");
int totalCnt=boodao.getTotalCnt(user_idx);
int listSize=5;
int pageSize=5;

String cp_s=request.getParameter("cp");
if(cp_s==null||cp_s.equals("")){
	cp_s="1";
}
int cp=Integer.parseInt(cp_s);

int totalPage=totalCnt/listSize+1;
if(totalCnt%listSize==0)totalPage--;


int userGroup=cp/pageSize;
if(cp%pageSize==0)userGroup--;
%>
<link rel = "stylesheet" type = "text/css" href = "/seesc/css/mainLayout.css">
	<link rel = "stylesheet" type = "text/css" href = "/seesc/css/subLayout.css">
	<link rel = "stylesheet" type = "text/css" href = "/seesc/css/button.css">
<body>
<%@include file="/header.jsp" %>
<section>
<br><br>
<h1 class ="h1">마이 페이지</h1>
         <br>
           <hr width="130px">
           <br>
<article>
	<a href="mypage.jsp"><button class="tbutton"><span>예약내역</span></button></a>
	<a href="payment.jsp"><button class="rbutton"><span>결제내역</span></button></a>
	<a href="myinfo.jsp"><button class="tbutton"><span>내정보</span></button></a>
	<a href="mycoupon.jsp"><button class="tbutton"><span>쿠폰함</span></button></a>
	<table>
	<tfoot>
			<tr>
				<td colspan="5" align="center">
				<!-- ---------------- -->
				<%
				if(userGroup!=0){
					%><a href="payment.jsp?cp=<%=(userGroup-1)*pageSize+pageSize%>"><button class="onebutton">&lt;&lt;</button></a><%
				}
				%>
				<%
				for(int i=userGroup*pageSize+1;i<=userGroup*pageSize+pageSize;i++){
					if(cp==i){
						%>&nbsp;&nbsp;<a href="payment.jsp?cp=<%=i%>"><button class = "prbutton"><%=i %></button></a>&nbsp;&nbsp;<%
					}else{
						%>&nbsp;&nbsp;<a href="payment.jsp?cp=<%=i%>"><button class = "pagebutton"><%=i %></button></a>&nbsp;&nbsp;<%
					}
					
					if(i==totalPage)break;
				}
				%>
				<%
				if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){
					%><a href="payment.jsp?cp=<%=(userGroup+1)*pageSize+1%>"><button class="nextbutton">&gt;&gt;</button></a><%
				}
				%>
				<!-- ---------------- -->
				</td>
			</tr>
		</tfoot>
		<tr>
			<th>No</th>
			<th>예약날짜</th>
			<th>결제금액</th>
			<th>결제수단</th>
			<th>결제상태</th>
		</tr>
		<%
	ArrayList<BookingDTO> arr=boodao.myBooking(user_idx,listSize,cp);
	if(arr==null||arr.size()==0){
		%>
		<tr>
			<td colspan="5">예약정보가 없습니다.</td>
		</tr>
		<%
	}else{
		for(int i=0;i<arr.size();i++){
			%>
			<tr>
				<td><%=arr.get(i).getBooking_idx() %></td>
				<td><%=arr.get(i).getBooking_time() %></td>
				<td><%=arr.get(i).getBooking_money() %></td>
				<td><%String pay= arr.get(i).getBooking_pay()>0?"현장결제":"무통장";%><%=pay %></td>
				<td><%String pay_ok=arr.get(i).getBooking_pay_ok()>0?"결제미완료":"결제완료"; %><%=pay_ok %></td>
			</tr>
			<%
		}
	}
	%>
		<tr>
			<td></td>
		</tr>
	</table>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>


