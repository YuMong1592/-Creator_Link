<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="login_do" method="post">
		<table border="1">
			<tr>
				<th>아이디</th>
				<td><input type="text" name="id">
					<input type="button" value="중복확인" id="idcheck"></td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td><input type="text" name="pw"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="로그인"></td>
			</tr>
		</table>
	</form>
</body>
</html>