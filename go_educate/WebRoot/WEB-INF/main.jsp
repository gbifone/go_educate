<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<%@include file="/WEB-INF/common/head.jsp"%>
	<style type="text/css">
	</style>
</head>
<body>
    <%@include file="/WEB-INF/common/banner.jsp" %>
    <div class="page">
        <div class="box mtop">
            <%@include file="/WEB-INF/common/nav.jsp" %>
            <div class="rightbox">
	    		<h2 class="mbx">我的工作台&nbsp;&nbsp;&nbsp;&nbsp;</h2>
			  	<div class="dhbg">
					<c:if test="${user.TYPE==1 }">
			    	<div class="dhwz" style="padding: 0px 0 0 120px;">
						<p>我的学员：<span class="red">
							<a href="../myStudent/findList.do">${studentcount }</a>
						</span></p>
						<p>本月已上课数：<span class="red">${attendcount } </span></p>
						<p>本月已排课数：<span class="red">
							
							<a href="../teacherkb/findList.do?STARTDATE=${aready.STARTDATE }&ENDDATE=${aready.ENDDATE }">${alreadycount }</a>
						</span></p>
						<p>下月已排课数：<span class="red"><a href="../teacherkb/findList.do?STARTDATE=${next.STARTDATE }&ENDDATE=${next.ENDDATE }">${nextcount }</a></span></p>
					</div>
					</c:if>
					<c:if test="${user.TYPE!=1 }">
						<div class="dhwz" style="padding: 0px 0 0 120px;">
						<p>我的学员：<span class="red">${studentcount }</span></p>
						<p>本月已上课数：<span class="red">${attendcount } </span></p>
						<p>本月已排课数：<span class="red">${alreadycount }</span></p>
						<p>下月已排课数：<span class="red">${nextcount }</span></p>
					</div>
					</c:if>
				</div>
			    <div class="xxlc">
			        <strong class="lcbt">最近情况</strong>
			    </div>
			    <div class="cztable">
			    	<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tbody>
							<tr style="height: 25px" align="center">
								<th scope="col">日期 </th>
								<th scope="col">星期几</th>
								<th scope="col">学生 </th>
								<th scope="col">课时 </th>
								<th scope="col">课程 </th>
								<th scope="col">课时段</th>
								<th scope="col">授课老师姓名</th>
								<th scope="col">上课状态</th>
								<th scope="col">操作</th>
								</tr>
							<c:forEach items="${classList}" var="vo" >
								<tr align="center">
									<td>${vo.DATE }</td>
									<td>${vo.weekDay }</td>
									<td>${vo.XSNAME }</td>
									<td>${vo.MUCHLESSON }</td>
									<td>${vo.CURRICULUMNAME }</td>
									<td>${vo.STARTTIME }-${vo.ENDTIME }</td>
									<td>${vo.LSNAME}</td>
									<td><%--
										${vo.STATUS=='0'?'正常':'未上课'}
										--%>
										<c:if test="${vo.STATUS==0 }">正常</c:if>
										<c:if test="${vo.STATUS==1 }">学生未上课</c:if>
										<c:if test="${vo.STATUS==2 }">老师未上课</c:if>
										<c:if test="${vo.STATUS==3 }">学生请假</c:if>
										<c:if test="${vo.STATUS==4 }">老师请假</c:if>
										<c:if test="${vo.STATUS==5 }">调课</c:if>
										<c:if test="${vo.STATUS==null }">未上课</c:if>
										<c:if test="${vo.STATUS=='' }">未上课</c:if>
									</td>
									<td>
										<a href="<%=request.getContextPath()%>/feedback/add.do?fbid=${vo.FEEDBACKID}&classId=${vo.ID}">
											反馈
										</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
			    </div>
            </div>
        </div>
        <%@include file="/WEB-INF/common/footer.jsp" %>
    </div>
</body>
</html>
