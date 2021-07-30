<%@page import="com.dto.CartDTO"%>
<%@page import="com.dto.GoodsDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<script	type = "text/javascript" src = "js/jquery-3.3.1.js"></script>
<script type = "text/javascript">
$(function(){
	function totalXXX() { //총합 구하는 함수
		var totalSum=0;
		$(".sum").each(function(idx, data) {//idx,element
			totalSum += Number.parseInt($(data).text());
		});
		$("#totalSum").text(totalSum);
	}//totalXXX
	$(function() {//화면이 불러지면 
		totalXXX();//총합 구하기
	})
	
	
	//상품 삭제
	$(".delBtn").click(function(){
		var num = $(this).attr("data-num");//삭제할 번호
		var xxx = $(this); //td태그
		$.ajax({
			type : "get", 
            url : "loginCheck/cartDelete", 
            dataType : "text",
            data : {
					num : num
            },
            success : function(data, status, xhr){ 
				console.log("success");
				//dom삭제
				xxx.parents().filter("tr").remove();
				totalXXX();
            },
            error : function(xhr, status, e){ 
                console.log(error);
            }	
		})//end ajax
	})//end 삭제
	
	//개수 수정
	$(".updateBtn").click(function(){
		var num = $(this).attr("data-num");
		var gAmount = $("#cartAmount" + num).val();
		var gPrice = $(this).attr("data-price");
		console.log(num, gPrice, gAmount);
		 $.ajax(
		        {
		            type : "get", 
		            url : "loginCheck/cartUpdate", 
		            dataType : "text",
		            data : {
	  					num : num,
	  					gAmount : gAmount
		            },
		            success : function(data, status, xhr){ 
		            	var total = parseInt(gAmount) * parseInt(gPrice);
		            	$("#sum" +num).text(total);
		            	totalXXX();
		            },
		            error : function(xhr, status, e){ 
		                console.log("error", e);
		                console.log("status", status);
		            }
		        }
		        ); //end ajax
	 })
	 
	 //전체 선택
	 $("#allCheck").click(function(){
		 var result = this.checked;
		 $(".check").each(function(idx,data) {
			this.checked = result;
		});
	 })
	 
	 //전체삭제
	 $("#delAllCart").click(function(){
		  $("form").attr("action", "loginCheck/delAllCart");
		  $("form").submit();
	 })
	 
	 $("#delAllCart2").click(function(){
		 $("form").attr("action", "CartDelAllServlet2");
		 $("form").submit();
	 })
	 
	 //주문확인창
	 $(".orderBtn").click(function(){
		 var num = $(this).attr("data-num");
		 location.href = "loginCheck/orderConfirm?num=" + num;
	 })
	 
	
})


</script>  
<table width="90%" cellspacing="0" cellpadding="0" border="0">

	<tr>
		<td height="30">
	</tr>

	<tr>
		<td colspan="5" class="td_default">&nbsp;&nbsp;&nbsp; <font
			size="5"><b>- 장바구니-</b></font> &nbsp;
		</td>
	</tr>

	<tr>
		<td height="15">
	</tr>

	<tr>
		<td colspan="10">
			<hr size="1" color="CCCCCC">
		</td>
	</tr>

	<tr>
		<td height="7">
	</tr>

	<tr>
		<td class="td_default" align="center">
		<input type="checkbox" name="allCheck" id="allCheck"> <strong>전체선택</strong></td>
		<td class="td_default" align="center"><strong>주문번호</strong></td>
		<td class="td_default" align="center" colspan="2"><strong>상품정보</strong></td>
		<td class="td_default" align="center"><strong>판매가</strong></td>
		<td class="td_default" align="center" colspan="2"><strong>수량</strong></td>
		<td class="td_default" align="center"><strong>합계</strong></td>
		<td></td>
	</tr>

	<tr>
		<td height="7">
	</tr>
	
	
	
	<tr>
		<td colspan="10">
			<hr size="1" color="CCCCCC">
		</td>
	</tr>

	<form name="myForm">	
<!--반복시작  -->
<c:forEach var="x" items="${cartList}">    
<%-- <%
   
List<CartDTO> list = (List<CartDTO>)request.getAttribute("cartList");
for(int i=0;i<list.size();i++){
	CartDTO dto = list.get(i);
	
	int num = dto.getNum();
	String userid = dto.getUserid();
	String gCode = dto.getgCode();
	String gImage = dto.getgImage();
	String gName = dto.getgName();
	int gPrice = dto.getgPrice();
	int gAmount = dto.getgAmount();
	String gColor = dto.getgColor();
	String gSize = dto.getgSize();
	
%>	   --%>  
	  		

		<tr>
			<td class="td_default" width="80">
			<!-- checkbox는 체크된 값만 서블릿으로 넘어간다. 따라서 value에 삭제할 num값을 설정한다. -->
			<input type="checkbox"
				name="check" id="check81" class="check" value="${x.num}"></td>
			<td class="td_default" width="80">${x.num}</td>
			<td class="gImage" width="80"><img
				src="images/items/${x.gImage}.gif" border="0" align="center"
				width="80" /></td>
			<td class="td_default" width="300" style='padding-left: 30px'>
				${x.gName}
				<br> <font size="2" color="#665b5f">[옵션 : 사이즈(${x.gSize})
					, 색상(${x.gColor})]
			</font></td>
			<td class="td_default" align="center" width="110" >
				${x.gPrice}
			</td>
			<td class="td_default" align="center" width="90"><input
				class="gAmount" type="text" name="cartAmount"
				id="cartAmount${x.num}" style="text-align: right" maxlength="3"
				size="2" value="${x.gAmount}"></input></td>
				
			<td><input type="button" value="수정" class = "updateBtn"
				data-num = "${x.num}" data-price="${x.gPrice}"/>
			</td>
			
			<td class="sum" align="center" width="80" style='padding-left: 5px'>
				<span id="sum${x.num}">
				${x.gAmount * x.gPrice}
				</span>
			</td>
			
			<td><input type="button" value="주문" class = "orderBtn" data-num = "${x.num}"></td>
				
			<td class="td_default" align="center" width="30" style='padding-left: 10px'>
				<input type="button" value="삭제" id="xx${x.num}" class = "delBtn" data-num="${x.num}"></td>
			<td height="10"></td>
		</tr>

</c:forEach><!--반복 끝  -->
<%-- <%
	} 
%> --%>
	</form>
	<tr>
		<td colspan="10">
		총합 : <span id="totalSum"></span>
			<hr size="1" color="CCCCCC">
		</td>
	</tr>
	<tr>
		<td height="30">
	</tr>

	<tr>
		<td align="center" colspan="5"><a class="a_black"
			href="javascript:orderAllConfirm(myForm)"> 전체 주문하기 </a>&nbsp;&nbsp;&nbsp;&nbsp; 
			<button id = "delAllCart"> 전체 상품 삭제하기 </button>&nbsp;&nbsp;&nbsp;&nbsp;
			<a class="a_black" href="#" id = "delAllCart2"> 전체 상품 삭제하기2</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a class="a_black" href="main"> 계속 쇼핑하기 </a>&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
	</tr>
	<tr>
		<td height="20">
	</tr>

</table>
    