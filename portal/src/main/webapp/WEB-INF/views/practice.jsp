<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>ExamStack</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="keywords" content="">
<!--<link rel="shortcut icon" href="http://localhost:8080/Portal/../resources/images/favicon.ico" />-->
<link href="resources/bootstrap/css/bootstrap-huan.css" rel="stylesheet">
<link href="resources/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link href="resources/css/style.css" rel="stylesheet">

<style>
.table>thead>tr>th, .table>tbody>tr>th, .table>tfoot>tr>th, .table>thead>tr>td,
	.table>tbody>tr>td, .table>tfoot>tr>td {
	padding: 8px 0;
	line-height: 1.42857143;
	vertical-align: middle;
	border-top: 1px solid #ddd;
}

a.join-practice-btn {
	margin-top: 0;
}
</style>

</head>

<body>
	<header>
		<div class="container">
			<div class="row">
				<div class="col-xs-5">
					<div class="logo">
						<h1>
							<a href="#"><img alt="" src="resources/images/logo.png"></a>
						</h1>
					</div>
				</div>
				<div class="col-xs-7" id="login-info">
					<c:choose>
							<c:when test="${not empty sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}">
								<div id="login-info-user">
									
									<a href="user-detail/${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}" id="system-info-account" target="_blank">${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}</a>
									<span>|</span>
									<a href="j_spring_security_logout"><i class="fa fa-sign-out"></i> ??????</a>
								</div>
							</c:when>
							<c:otherwise>
								<a class="btn btn-primary" href="user-register">????????????</a>
								<a class="btn btn-success" href="user-login-page">??????</a>
							</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</header>
	<!-- Navigation bar starts -->

	<div class="navbar bs-docs-nav" role="banner">
		<div class="container">
			<nav class="collapse navbar-collapse bs-navbar-collapse"
				role="navigation">
				<ul class="nav navbar-nav">
						<li>
							<a href="home"><i class="fa fa-home"></i>??????</a>
						</li>
						<li class="active">
							<a href="student/practice-list"><i class="fa fa-edit"></i>????????????</a>
						</li>
						<li>
							<a href="exam-list"><i class="fa  fa-paper-plane-o"></i>????????????</a>
						</li>
						<li>
							<a href="training-list"><i class="fa fa-book"></i>????????????</a>
						</li>
						<li>
							<a href="student/usercenter"><i class="fa fa-dashboard"></i>????????????</a>
						</li>
						<li>
							<a href="student/setting"><i class="fa fa-cogs"></i>????????????</a>
						</li>
					</ul>
			</nav>
		</div>
	</div>

	<!-- Navigation bar ends -->

	<!-- Slider starts -->
	<div class="content" style="margin-bottom: 100px;">

		<div class="container">
			<ul class="nav nav-pills " style="margin: 20px 0;">
				<c:forEach items="${fieldList }" var="item">
					<li role="presentation" <c:if test="${item.fieldId == fieldId }"> class="active"</c:if>><a href="student/practice-list?fieldId=${item.fieldId }">${item.fieldName }</a></li>
				</c:forEach>
			</ul>
			<div class="row">
				<div class="col-xs-6">
					<div style="border-bottom: 1px solid #ddd;">
						<h3 class="title">
							<i class="fa fa-cloud-upload"></i> ????????????
						</h3>
						<p>???????????????????????????????????????</p>
					</div>

					<div class="question-list">

						<c:forEach items="${kparl}" var="item">

							<table class="table-striped table">
								<thead>
									<tr>
										<td colspan="4"><h6>${item.knowledgePointName }</h6>
											<span style="color: #428bca;">???????????????<fmt:formatNumber
													value="${item.finishRate }" type="percent" /></span></td>
									</tr>
									<tr>
										<td>??????</td>
										<td>??????</td>
										<td>????????????</td>
										<td></td>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${item.typeAnalysis }" var="tp">
										<tr>
											<td>${tp.questionTypeName }</td>
											<td><span class="span-info question-number">${tp.restAmount + tp.rightAmount + tp.wrongAmount }</span></td>
											<td><span class="span-success question-number-2">${tp.rightAmount + tp.wrongAmount }</span></td>
											<td><a href="student/practice-improve/${fieldId }/${item.knowledgePointId }/${tp.questionTypeId }"
												class="btn btn-success btn-sm join-practice-btn">????????????</a></td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot></tfoot>
							</table>
						</c:forEach>

					</div>
				</div>
				<div class="col-xs-6">
					<div style="border-bottom: 1px solid #ddd;">
						<h3 class="title">
							<i class="fa fa-eraser"></i> ????????????
						</h3>
						<p>???????????????????????????</p>
					</div>
					<div class="question-list">

						<table class="table-striped table">
							<thead>

								<tr>
									<td>????????????</td>
									<td>????????????</td>
									<td></td>
									<td></td>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${historyMap }" var="item">
									<tr>
										<td>${pointMap[item.key].pointName }</td>
										<td><span class="span-info question-number">${item.value.wrongAmount }</span></td>
										<td><a href="student/practice-incorrect/${item.value.fieldId }/${item.value.pointId }"
											class="btn btn-success btn-sm join-practice-btn">????????????</a></td>
									</tr>
								</c:forEach>

							</tbody>
							<tfoot></tfoot>
						</table>

					</div>
					<div style="border-bottom: 1px solid #ddd; margin-bottom: 20px;">
						<h3 class="title">
							<i class="fa fa-superscript"></i> ????????????
						</h3>
						<p>????????????????????????????????????</p>

					</div>
					<a class="btn btn-success " href="student/practice-test/${fieldId }">?????????20??? </i>
					</a>
				</div>

			</div>


		</div>

	</div>

	<footer>
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="copy">
						<p>
							ExamStack Copyright ?? <a href="http://www.examstack.com/"
								target="_blank">ExamStack</a> - <a href="." target="_blank">??????</a>
							| <a href="http://www.examstack.com/" target="_blank">????????????</a> | <a
								href="http://www.examstack.com/" target="_blank">FAQ</a> | <a
								href="http://www.examstack.com/" target="_blank">????????????</a>
						</p>
					</div>
				</div>
			</div>

		</div>

	</footer>

	<!-- Slider Ends -->

	<!-- Javascript files -->
	<!-- jQuery -->
	<script type="text/javascript"
		src="resources/js/jquery/jquery-1.9.0.min.js"></script>
	<!-- Bootstrap JS -->
	<script type="text/javascript"
		src="resources/bootstrap/js/bootstrap.min.js"></script>
	<script>
		$(function() {
			bindQuestionKnowledage();
			var result = checkBrowser();
			if (!result) {
				alert("?????????????????????????????????IE8???????????????");
			}
		});

		function checkBrowser() {
			var browser = navigator.appName;
			var b_version = navigator.appVersion;
			var version = b_version.split(";");
			var trim_Version = version[1].replace(/[ ]/g, "");
			if (browser == "Microsoft Internet Explorer"
					&& trim_Version == "MSIE7.0") {
				return false;
			} else if (browser == "Microsoft Internet Explorer"
					&& trim_Version == "MSIE6.0") {
				return false;
			} else
				return true;
		}

		function bindQuestionKnowledage() {
			$(".knowledge-title").click(function() {
				var ul = $(this).parent().find(".question-list-knowledge");

				if (ul.is(":visible")) {
					$(this).find(".fa-chevron-down").hide();
					$(this).find(".fa-chevron-up").show();

					$(".question-list-knowledge").slideUp();

				} else {
					$(".fa-chevron-down").hide();
					$(".fa-chevron-up").show();

					$(this).find(".fa-chevron-up").hide();
					$(this).find(".fa-chevron-down").show();

					$(".question-list-knowledge").slideUp();
					ul.slideDown();

				}

			});
		}
	</script>
	<script type="text/javascript">
		var cnzz_protocol = (("https:" == document.location.protocol) ? " https://"
				: " http://");
		document
				.write(unescape("%3Cspan id='cnzz_stat_icon_1252987997'%3E%3C/span%3E%3Cscript src='"
						+ cnzz_protocol
						+ "s19.cnzz.com/z_stat.php%3Fid%3D1252987997' type='text/javascript'%3E%3C/script%3E"));
	</script>
</body>
</html>

