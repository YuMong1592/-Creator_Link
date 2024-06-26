<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<link href="${pageContext.request.contextPath}/resources/css/board/board.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="background">
		<div class="container">
			<div class="sidebar">
				<div class="info_block">
					<div class="info_my">
						<div class="info_title">
							<div class="info_photo">
								<img src="./resources/member/
								<c:if test="${member.mb_photo == 'basic_photo.png'}">basic_photo</c:if>
								<c:if test="${member.mb_photo != 'basic_photo.png'}">profile</c:if>
								/${member.mb_photo}" width="180px">
							</div>
						</div>
						<div class="info_data">
							<div class="info_name">
							${member.mb_nick_name}
							</div>
							<div class="info_record">
								<span>내가 쓴 글</span>
								<span>${write_post}</span>
							</div>
							<div class="info_record">
								<span>내가 쓴 댓글</span>
								<span>${write_comment}</span>
							</div>
						</div>
					</div>
				</div>
				<aside class="category_list">
					<div class="category_title">
						<span>CreatorLink</span>
					</div>
					<div onclick="location.href='board_main'" class="category">전체글</div>
					<c:forEach items="${attribute_list}" var="atli">
					<div class="category" onclick="location.href='board_main?bat_number=${atli.bat_number}'">${atli.bat_cls}</div>
					</c:forEach>
				</aside>
				<div class="store" onclick="location.href='store_main'">STORE</div>
			</div>
			<div class="board">
				<form id="form_input" action="board_save" method="post">
					<input type="hidden" name="mb_number" value="${mb_number}">
					<div class="post_write">
						<div style="display: flex; align-items: center; justify-content: space-between;">
							<div style="width: 19%; display: flex; align-items: center;">
								<select name="attribute" style="width: 100%; height: 21px;">
									<c:forEach items="${attribute_list}" var="atli">
										<option value="${atli.bat_number}">${atli.bat_cls}</option>
									</c:forEach>
								</select>
							</div>
							<div style="width: 80%; display: flex; align-items: center;"><input type="text" name="title" placeholder="제목" style="width: 100%;"></div>
						</div>
						<div class="inputbox"><textarea name="content" id="editor"></textarea></div>
						<div style="float: right;"><input type="button" value="작성" onclick="val_check()"></div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="https://cdn.ckeditor.com/ckeditor5/34.2.0/super-build/ckeditor.js"></script>
	<script type="text/javascript" src="resources/js/editor_check.js"></script>
	<script type="text/javascript" src="resources/js/input_editor.js"></script>
</body>
</html>