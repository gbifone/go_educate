<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<%@include file="/WEB-INF/common/head.jsp"%>
	<script type="text/javascript" src="<%=request.getContextPath()%>/script/platform/bmenu.js"></script>
</head>
<body>
	<%@include file="/WEB-INF/common/banner.jsp"%>
	<div class="page">
		<div class="box mtop">
			<%@include file="/WEB-INF/common/nav.jsp"%>
			<div class="rightbox">
				<h2 class="mbx">系统管理 &gt; 菜单管理</h2>
				<%@include file="/WEB-INF/platform/nav.jsp"%>
				<div class="cztable">
					<div class="tis">
						<form action="findList.do" method="post" id="searchForm">
							名称:<input size="20" name="MNAME" value="${parameter.MNAME }" class="input_2"  />
							<input class="input2" type="submit" value="查询"   />
							<input class="input2" type="button" value="清空"  onclick="clearData('searchForm')"  />
							<input class="input2" type="button" value="添加" onclick="addxx()"  />
							<input class="input2" type="button" value="删除" onclick="deleteAll()"  />
						</form>
					</div>
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tbody>
							<tr style="height: 25px" align="center">
								<th scope="col"><input type="checkbox" id="checkAll" onclick="checkAll(this);"  /><label for="checkAll">全选</label></th>
								<th scope="col">菜单名称 </th>
								<th scope="col">编码</th>
								<th scope="col">父编码</th>
								<th scope="col">操作</th>
							</tr>
							<c:forEach items="${pageBean.list }" var="vo" >
								<tr align="center">
									<td><input type="checkbox" name="ID" value="${vo.ID }" /></td>
									<td>${vo.MNAME }</td>
									<td>${vo.MCODE }</td>
									<td>${vo.PMCODE }</td>
									<td>
										<a href="javascript:void(0);"  onclick="loadxx('${vo.ID}')">修改</a> | 
										<a href="javascript:void(0);" onclick="deleteOne('${vo.ID}')" >删除</a> 
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<%@include file="/WEB-INF/common/page.jsp"%>
				</div>
			</div>
		</div>
	<%@include file="/WEB-INF/common/footer.jsp"%>
	</div>
</body>
</html>
