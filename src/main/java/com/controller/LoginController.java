package com.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dto.MemberDTO;
import com.service.MemberService;

@Controller
public class LoginController {
	@Autowired
	MemberService service;
	
	@RequestMapping(value = "/login")
	public String login(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		//System.out.println(map);
		MemberDTO dto = service.login(map); // userid ='xxx',passwd='zzzz'
		//System.out.println(map);
		if(dto!=null) {//로그인 된 경우
			session.setAttribute("login", dto);
			return "redirect:/goodsList?gCategory=top"; //로그인시 top 카테고리를 보이도록 작성
		}else {
			model.addAttribute("mesg", "아이디 또는 비번이 잘못되었습니다.");
			return "loginForm";
		}
	}//login
	
	@RequestMapping(value = "/loginCheck/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		//return "../"; //xml에 main.jsp
		return "redirect:../"; //.xml 에 설정 main.jsp ../ 을 이용하여 /loginCheck 의 상위 주소로 이동
		//하여 주소를 사용함
	}
	
	
	
	
	
	
}
