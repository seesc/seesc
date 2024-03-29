<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.esc.write.*"%>
<%@page import ="com.esc.userinfo.*" %>
<jsp:useBean id="idao" class="com.esc.write.ImgDAO" scope="session"></jsp:useBean>
<jsp:useBean id="udao" class="com.esc.userinfo.UserinfoDAO" scope = "session"></jsp:useBean>
<%
int user_idx = session.getAttribute("user_idx")==null||session.getAttribute("user_idx").equals("")?0:(int)session.getAttribute("user_idx");
int manager = session.getAttribute("manager")==null||session.getAttribute("manager").equals("")?0:(int)session.getAttribute("manager");
int comm_idx = request.getParameter("comm_idx")==null||request.getParameter("comm_idx").equals("")?0:Integer.parseInt(request.getParameter("comm_idx"));
int write_idx= request.getParameter("write_idx")==null||request.getParameter("write_idx").equals("")?0:Integer.parseInt(request.getParameter("write_idx"));
int write_notice= request.getParameter("write_notice")==null||request.getParameter("write_notice").equals("")?0:Integer.parseInt(request.getParameter("write_notice"));
int totalCnt=idao.getTotalCntComments(write_idx);
int listSize=10; 
int pageSize=5; 
String cp_s=request.getParameter("cp");
if(cp_s==null || cp_s.equals("")){
	cp_s="1";
}
int cp=Integer.parseInt(cp_s);

int totalPage=totalCnt/listSize+1;
if(totalCnt%listSize==0)totalPage--;

int userGroup=cp/pageSize;
if(cp%pageSize==0)userGroup--;

WriteDTO dto = idao.writeEventContent(write_idx);
if (dto == null || dto.equals("")) {
%>
<script>
	window.alert('삭제된 게시글 입니다.');
	location.href='/seesc/community/community_eventcontent_list.jsp';
</script>

<%
return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/seesc/css/mainLayout.css">
<style>
.pagebutton{
		width: 25px;
        height: 20px;
        border: none;
        border-radius: 5px;
        background-color: #FFA300;
        color: white;
        font-size: 20px;
  }
.pagebutton:hover {
    background-color: #FF870C;
}
.listbutton{
		width: 80px;
        height: 40px;
        border: none;
        border-radius: 10px;
        background-color: #FFA300;
        color: white;
        font-size: 16px;
      }
.listbutton:hover {
    background-color: #FF870C;

}
.msrc{
   width:250px;
   height:250px;
}
table {
	width: 660px;
	margin: 0px auto;
	border: 3px solid #FFA300;
}
article{
	width: 660px;
	margin: 0px auto;
}
ul {
	list-style: none;
}
li {
	liste-style: none;
}
th {
	float:left;
	color:black;
}
td {
	color:black;
}
</style>
</head>
<body>
	<%@include file="/header.jsp"%>
	
	<%sid= (String) session.getAttribute("sid");
	UserinfoDTO udto = udao.userInfo(sid); %>
	<section>
		<article>
			<br><br><br>
		<% 	if(dto.getWrite_notice()==1){%>
			<h1 class ="h1">Event 공지사항</h1>
		<%}else{%>
			<h1 class ="h1">Event 본문</h1>
		<%}
		%>	
			<br>
			  <hr width="130px">
			  <br><br>
			<table style="background-color:white;">
				<tbody style="background-color:#f2f2f2;">
					<tr>
						<th>제목:</th>
						<td><%=dto.getWrite_title()%>
						<th>날짜:</th>
						<td><%=dto.getWrite_wdate()%></td>
					<tr>
						<th>작성자:</td>
						<td><%=dto.getWrite_writer()%></td>
						<th>조회수:</th>
						<td><%=dto.getWrite_readnum()%></td>
					</tr>
					<tr>
						<th>파일이름:</th>
						<%
						if (dto.getWrite_filename() != null) {
						%>
						<td colspan="3"><a href="/seesc/community/img/<%=dto.getWrite_filename()%>"
							target="_blank"><%=dto.getWrite_filename()%></a></td>
					</tr>
					<tr>
						<td colspan="4" align="center">
						<img src="/seesc/community/img/<%=dto.getWrite_filename()%>" class="msrc"></td>
						<%
						} else {
						%><td colspan="4">파일 없음</td>
						<%
						}
						%>
					</tr>
					<tr>
						<td colspan="4"><textarea rows="10" cols="92"
								name="write_content" readonly><%=dto.getWrite_content()%></textarea></td>
					</tr>
					
			  		<%
					if (dto.getWrite_notice()==1 && manager!=1) {%>
						<tr>
						<td colspan="4">
							<input type="button" class="listbutton" value="목록" onclick="location.href = 'community_eventcontent_list.jsp'">
						</td>
					</tr>
				<% }else if(manager==1){%>
				<tr>
					<td colspan="4">
						<input type="button" class="listbutton" value="삭제" onclick ="location.href ='community_eventcontent_delete_ok.jsp?flag=uDelete&write_idx=<%=write_idx%>'">
						<input type="button" class="listbutton" value="수정" onclick="location.href = 'community_eventcontent_update.jsp?flag=uUpdate&write_idx=<%=write_idx%>'">
						<input type="button" class="listbutton" value="목록" onclick="location.href = 'community_eventcontent_list.jsp'">
		
						<form name = "community_eventcontent_re" action="community_eventcontent_re.jsp" method ="post">
						<input type="hidden" name="write_idx" value="<%=write_idx%>">
						<input type = "hidden" name = "user_idx" value = "<%=user_idx %>">
						<input type = "hidden" name = "write_title" value = "<%=dto.getWrite_title()%>">
						<input type ="hidden" name = "write_ref" value = "<%=dto.getWrite_ref()%>">
						<input type = "hidden" name = "write_lev" value = "<%=dto.getWrite_lev()%>">
						<input type = "hidden" name = "write_step" value = "<%=dto.getWrite_step()%>">
				<!-- 	<input type="submit" value="답글">  -->
						</form>
					</td>
				</tr>
				<%}else {%> <!--비회원 비밀번호 입력후 수정과 삭제-->
				<tr>
					<td colspan="4">	
						이벤트 게시물 [수정] [삭제]는 <b style="color:red;">관리자</b>만 가능합니다.
					</td>
				</tr>
				<%} %>
			</tbody>
			</table>
		</article>
					
				<%if(dto.getWrite_notice()!=1){ %> 	<!-- 공지 댓글작성 막기 -->
				
		<article>
			<!--본문 댓글-->
			<form name="cm" action="community_eventcontent_contentRe.jsp" method="post">
				<input type="hidden" name="write_idx" value="<%=write_idx%>">
				<input type="hidden" name="user_idx" value=<%=user_idx%>>
				<fieldset>
				<legend>댓글작성</legend>
				<table style="background-color: #f2f2f2;">
				<%if(manager==1){%>
					<tr>
					<td><input type="text" name="comm_writer" value = "<%=udto.getUser_nic()%>" readonly>
					</td>
				
				<%}else if(user_idx!=0){%>
					<tr>
					<td><input type="text" name="comm_writer" value = "<%=udto.getUser_nic()%>" readonly>
					<input type="password" name="comm_pwd" placeholder="비밀번호" required>
					</td>	
				<%}else{%>
					<tr>
						<td>
						<input type="text" name="comm_writer" placeholder="작성자" required>
						<input type="password" name="comm_pwd" placeholder="비밀번호" required>
						</td>
					</tr>
					<%} %>
					<tr>
						<td><textarea rows="3" cols="91" name="comm_content" placeholder="내용을 작성해주세요" required></textarea>
						<br><input  class="listbutton" type="submit" value="등록"></td>
					</tr>
				</table>
				</fieldset>
			</form>
			<fieldset>
				<legend>댓글</legend>
				<table style="background-color: #f2f2f2;">
				<%
				ArrayList<CommentDTO> arr = idao.event_commentList(write_idx,listSize,cp);
				String flag = request.getParameter("flag");
				if (arr==null||arr.size()==0){
			       %>
					<tr>
			           <td align="center">			    
			           등록된 댓글이 없습니다.
			           </td>
			        </tr>
			        <% 
				}else
				if (arr != null && arr.size() != 0) {
					for (int i=0;i<arr.size();i++) {
						if(arr.get(i).getComm_lev() == 0){
							%>
							<tr>
							<td onclick="location.href = 'community_eventcontent_content.jsp?comm_idx=<%=arr.get(i).getComm_idx()%>&write_idx=<%=write_idx%>&flag=cw&cp=<%=cp%>'">
							<%
						}else{
							%>
							<tr>
							<td>
							<%
						}
				%>
				
					<%
					for (int j=0;j<arr.get(i).getComm_lev();j++) {
						out.print("&nbsp;&nbsp;");
					}
					if (arr.get(i).getComm_lev() > 0) {
						out.print("&nbsp;&nbsp;&#8627;");
					}
					%>
					<b style="color:orange;"><%=arr.get(i).getComm_writer()%></b>&nbsp;-&nbsp;<%=arr.get(i).getComm_content()%>&nbsp;|&nbsp;<%=arr.get(i).getComm_date()%>
					
					<%if(manager==1){%>
					<a href="event_comment_del.jsp?comm_idx=<%=arr.get(i).getComm_idx()%>&write_idx=<%=write_idx%>&manager=<%=manager%>&flag=cd">
					<img src="/seesc/img/s_delete.gif" alt = "댓글삭제">
					</a>
					</td>
							<%}else if(user_idx == dto.getUser_idx()&&user_idx!=0&&arr.get(i).getUser_idx()==user_idx){%>
								<a href="event_comment_del.jsp?comm_idx=<%=arr.get(i).getComm_idx()%>&write_idx=<%=write_idx%>&flag=cd">
								<img src="/seesc/img/s_delete.gif" alt = "댓글삭제">
								</a>
							<%}else{%>
							
							<a href="community_eventcontent_content.jsp?comm_idx=<%=arr.get(i).getComm_idx()%>&write_idx=<%=write_idx%>&flag=delete">
							<img src="/seesc/img/s_delete.gif" alt = "댓글삭제">
							</a>
							</td>
							</tr>
							<tr>
						<%
						if (comm_idx == arr.get(i).getComm_idx()&flag!=null&&flag.equals("delete")) {%>	
							<td>
							<form name= "commentdel" action = "event_comment_del.jsp">
							<input type="password" name="userinputpwd" placeholder="비밀번호" required>
							<input type="hidden" name="comm_pwd" value="<%=arr.get(i).getComm_pwd()%>">
							<input type="hidden" name="comm_idx" value="<%=arr.get(i).getComm_idx()%>">
							<input type="hidden" name="write_idx" value="<%=write_idx%>">
							<input type="submit" value="삭제">
							<input type="button"value="닫기" onclick="location.href = 'community_eventcontent_content.jsp?write_idx=<%=write_idx%>'">
							</form>
							</td>
							</tr>
					<%}
					}%>
								
				<!-------대댓------->
				<%
				if (comm_idx == arr.get(i).getComm_idx()&&flag!=null&&flag.equals("cw")) {
					if(manager==1){%>
						<tr>
						<td>&#8627; re) <%=udto.getUser_nic()%></td>
						</tr>
								<form name="co_co" action="community_eventcontent_contentReRe.jsp" method="post">
									<tr>
									<td>
									<input type="hidden" name="write_idx" value="<%=write_idx%>">
									<input type="hidden" name="user_idx" value="<%=user_idx%>">
									<input type="hidden" name="comm_ref"value="<%=arr.get(i).getComm_ref()%>">
									<input type="hidden" name="comm_lev" value="<%=arr.get(i).getComm_lev()%>">
									<input type="hidden" name="comm_step" value="<%=arr.get(i).getComm_step()%>"> 
									<input type="hidden" name="comm_writer" value = "<%=udto.getUser_nic()%>">
									</td>
									</tr>
									<tr>
									<td>
									<textarea rows="2" cols="40" name="comm_content" placeholder="내용을 작성해주세요" required></textarea>
									<br><input type="submit" value="등록">
									<input type="button"value="닫기" onclick="location.href = 'community_eventcontent_content.jsp?write_idx=<%=write_idx%>'">
									</td>
									</tr>								
								</form>
						<%}else{%>
							<form name="co_co" action="community_eventcontent_contentReRe.jsp" method="post">
							<tr>
							<td>
							&#8627; re)
							<input type="text" name="comm_writer" placeholder="작성자" required>
							<input type="password" name="comm_pwd" placeholder="비밀번호" required>
							<input type="hidden" name="write_idx" value="<%=write_idx%>">
							<input type="hidden" name=user_idx value="<%=user_idx%>">
							<input type="hidden" name="comm_ref"value="<%=arr.get(i).getComm_ref()%>">
							<input type="hidden" name="comm_lev" value="<%=arr.get(i).getComm_lev()%>">
							<input type="hidden" name="comm_step" value="<%=arr.get(i).getComm_step()%>"> 
							<input type="hidden" name="flag" value = "commentwrite">
							
							</td>
							</tr>
							<tr>
							<td>
							<textarea rows="3" cols="60" name="comm_content" placeholder="내용을 작성해주세요" required></textarea>
							<br><input type="submit" value="등록">
							<input type="button"value="닫기" onclick="location.href = 'community_eventcontent_content.jsp?write_idx=<%=write_idx%>'">
							</td>
						</tr>
						</form>

				<%
							}	
						}
					}
				}
				%>
			<tfoot>
				<tr>
					<td align="center">
					<%
					if(userGroup!=0){
						%><a style="text-decoration:none;" href="community_eventcontent_content.jsp?write_idx=<%=write_idx %>&cp=<%=(userGroup-1)*pageSize+pageSize%>">&lt;&lt;</a><%
					}
					%>

					<%
					for(int i=userGroup*pageSize+1;i<=userGroup*pageSize+pageSize;i++){
						%>&nbsp;&nbsp;<a style="text-decoration:none;" href="community_eventcontent_content.jsp?write_idx=<%=write_idx %>&cp=<%=i%>"><b class="pagebutton"><%=i %></b>&nbsp;&nbsp;</a><% 
						if(i==totalPage)break;
					}
					%>
					<%
					if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){
						%><a style="text-decoration:none;" href="community_eventcontent_content.jsp?write_idx=<%=write_idx %>&cp=<%=(userGroup+1)*pageSize+1%>">&gt;&gt;</a>
					<%
					}
					%>
					</td>
				</tr>
			</tfoot>
			</table>
			</fieldset>
			<br>
		</article>
		<%} %>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>