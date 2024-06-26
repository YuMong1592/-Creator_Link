<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="resources/js/address.js"></script>
<script type="text/javascript">
function pd_updata_price(price,su,os_ele) {
	const total_price = price * su;
	document.getElementById("pdtot_price").value = total_price;
	all_up_price();
}
function os_updata_price(price,su) {
	const total_price = price * su;
	document.getElementById("ostot_price").value = total_price;
	all_up_price();
}
function all_up_price() {
	let os_totprice = 0;
	const os_elements = document.querySelectorAll("#ostot_price");
	os_elements.forEach(element=>{
		os_totprice += parseInt(element.value);
	});
	let pd_totprice = 0;
	const pd_elements = document.querySelectorAll("#pdtot_price");
	pd_elements.forEach(element=>{
		pd_totprice += parseInt(element.value);
	})
	
	const all_totprice = document.getElementById("all_tot_price");
	all_totprice.value = os_totprice + pd_totprice;

}
window.onload = function() {
	all_up_price(); // 페이지 로드 시 함수 실행
};
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="shoping_cart_buy_fix" method="post">
		<div class="shoping_container">
			<table>
				<tr>
					<th>아이템 리스트</th>
				</tr>
			<c:choose>
				<c:when test="${not empty os_list ne null}">
					<c:forEach items="${os_list }" var="os">
					<tr>
						<td>아이템 이름: ${os.pd_name}<input type="hidden" name="os_number" value="${os.os_number}">
						<input type="hidden" name="os_name" value="${os.os_1name}${os.os_2name}${os.os_3name}">
						<input type="hidden" name="os_pd_name" value="${os.pd_name}">
						<input type="hidden" name="os_pd_number" value="${os.pd_number}"></td>
					</tr>
						<c:choose>
							<c:when test="">
							<tr>
								<td>옵션 이름: ${os.os_1name}${os.os_2name}${os.os_3name}</td>
							</tr>
							</c:when>
						</c:choose>
					<tr>
						<td>이미지
							<img src="./resources/store/item_cover/${os.os_photo}" width="100"></td>
						<td>총 가격: <input type="number" name="ostot_price" id="ostot_price" value="${os.os_price*os.os_buy_su}" readonly>원<br>
							1개 가격: ${os.os_price}
						</td>
					</tr>
					<tr>
						<td>구매 수량: <input type="number" name="os_buy_quantity" value="${os.os_buy_su}" min="1" max="${os.os_stock}" onchange="os_updata_price(${os.os_price},this.value)" readonly>
						</td>
					</tr>
					</c:forEach>
				</c:when>
			</c:choose>
			
			<c:choose>
				<c:when test="${not empty pd_list ne null}">
					<c:forEach items="${pd_list }" var="pd">
						<tr>
							<td>아이템 이름: ${pd.pd_name}<input type="hidden" name="pd_number" value="${pd.pd_number}">
							<input type="hidden" name="pd_name" value="${pd.pd_name}"></td>
						</tr>
						<tr>
							<td>이미지
							<img src="./resources/store/item_cover/${pd.pd_photo}" width="100"></td>
							<td>총 가격: <input type="number" name="pdtot_price" id="pdtot_price" value="${pd.pd_price*pd.pd_buy_su}" readonly>원<br>
								1개 가격: ${pd.pd_price}원
							</td>
						</tr>
						<tr>
							<td>구매 수량: <input type="number" name="pd_buy_quantity" value="${pd.pd_buy_su}" min="1" max="${pd.pd_stock}" onchange="pd_updata_price(${pd.pd_price},this.value)" readonly>
							</td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
			
			<tr>
				<td>배송정보</td>
				<td><input type="text" name="zip_code" id="sample4_postcode" placeholder="우편번호" value="${member.mb_addr_post}">
					<input type="button" onclick="sample4_execDaumPostcode()"
					value="우편번호 찾기"><br> 
					<input type="text" name="dlvy_address" id="sample4_roadAddress" placeholder="도로명주소" required value="${member.mb_addr_road}">
					<input type="text" name="dlvy_address_dong" id="sample4_jibunAddress" placeholder="지번주소" required value="${member.mb_addr_local}">
					<span id="guide" style="color: #999; display: none"></span> 
					<input type="text" name="dlvy_detail" id="sample4_detailAddress" placeholder="상세주소" required maxlength="50" value="${member.mb_addr_detail}">
					<input type="text" name="dlvy_comment" placeholder="배송 메시지" maxlength="20">
				</td>
			</tr>
			<tr>
				<td>연락처<input type="text" value="${member.mb_phone}" required></td>
			</tr>
			<tr>
				<td>수취인<input type="text" value="${member.mb_name}" required></td>
			</tr>
			<tr>
				<td>쿠폰</td>
				<td>보유 쿠폰 0
				<td>
				<td><select name="od_cp_code" id="od_cp_code">
						<option value="co_code1">쿠폰1</option>
						<option value="co_code2">쿠폰2</option>
						<option value="co_code3">쿠폰3</option>
				</select></td>
				<td><input type="button" value="적용" onclick=""></td>
			</tr>
			<tr>
				<th>결제 방법</th>
				<td><input type="button" name="카드" id="카드" value="카드">
					<input type="button" name="계좌" id="계좌" value="계좌"> 
					<input type="button" name="페이" id="페이" value="페이">
				<td>
			</tr>
			<tr>
				<th>결제 금액</th>
					<td><input type="number" id="all_tot_price" name="all_tot_price" value="" readonly>원</td>
			</tr>
			<tr>
				<td><input type="submit" value="구매"> <input type="reset" value="취소" onclick="location.href='shopping_cart_view'"></td>
			</tr>
			</table>
		</div>
	</form>

</body>
</html>