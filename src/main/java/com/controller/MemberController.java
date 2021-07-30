package com.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dto.MemberDTO;
import com.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	MemberService service; //Service클래스 @Service + Component-scan
	
	@RequestMapping(value = "/memberAdd") //회원가입
	public String memberAdd(MemberDTO m, Model model) {
		service.memberAdd(m);
		model.addAttribute("success", "회원가입성공");//main.jsp에서 success검사
		return "main";//main.jsp
	}//memberadd
	
	@RequestMapping(value = "/loginCheck/myPage")//interceptor 먼저 거쳐서옴
	public String myPage(HttpSession session) {
		System.out.println("myPage호출====");
		MemberDTO dto =(MemberDTO)session.getAttribute("login");
		String userid = dto.getUserid(); //세션에서 id 얻기
		dto= service.myPage(userid);
		session.setAttribute("login", dto);
		return "redirect:../myPage"; // 주소에 해당하는 페이지를 servlet-context에 등록사용
		//return "myPage";// 주소에 해당하는 페이지를 servlet-context에 등록사용
	}//mypage
	
	@RequestMapping(value = "/idDuplicateCheck", produces = "text/plain;charset=UTF-8")//한글처리
	public @ResponseBody String idDuplicateCheck(@RequestParam("id") String userid) {
		//비동기 방식 요청에 대한 mesg를 문자열로 전송
		MemberDTO dto = service.myPage(userid);
		System.out.println("idDuplicateCheck==="+userid);
		System.out.println(dto);
		String mesg="아이디 사용가능";
		if(dto != null) {//db에 같은 아이디가 존재
			mesg="아이디 중복";
		}
		return mesg; //view 페이지 가 아닌 mesg문자열 전송		
	}
	
	@RequestMapping(value = "/loginCheck/memberUpdate")
	public String memberUpdate(MemberDTO m) {
		System.out.println("memberUpdate==="+m);
		service.memberUpdate(m);//db업데이트 완료
		return "redirect:../loginCheck/myPage"; //db에서 사용자 데이터 가져와서 myPage 출력
	}
	
	
	
	
}//end controller
