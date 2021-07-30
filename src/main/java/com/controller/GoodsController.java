package com.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dto.CartDTO;
import com.dto.GoodsDTO;
import com.dto.MemberDTO;
import com.dto.OrderDTO;
import com.service.GoodsService;
import com.service.MemberService;

@Controller
public class GoodsController {
	@Autowired
	GoodsService service;
	@Autowired
	MemberService mService;
	
	@RequestMapping("/goodsList")
	public ModelAndView goodsList(@RequestParam("gCategory") String gCategory) {
		if(gCategory==null) {
			gCategory ="top";
		}
		List<GoodsDTO> list = service.goodsList(gCategory);//카테고리 해당 목록 가져오기
		ModelAndView mav =new ModelAndView();
		mav.addObject("goodsList", list);
		//request.setAttribute("goodsList",list) 와 동일
		mav.setViewName("main");//main.jsp => goodList.jsp에서 목록을 뿌려줌
		return mav;
	}	
	
	@RequestMapping("/goodsRetrieve")//goodsRetrieve.jsp //view 에대한 지정이 없음 url= 뷰파일.jsp
	@ModelAttribute("goodsRetrieve")//키값을 goodsRetrieve로 지정
	public GoodsDTO goodsRetrieve(@RequestParam("gCode") String gCode) {
		GoodsDTO dto = service.goodsRetrieve(gCode);
		return dto;
	}
	
	@RequestMapping("/loginCheck/cartAdd")
	public String cartAdd(CartDTO cart, HttpSession session) {
		MemberDTO mDTO =(MemberDTO)session.getAttribute("login");
		cart.setUserid(mDTO.getUserid());//cart에 session에 들어잇는 id 정보 저장
		session.setAttribute("mesg", cart.getgCode()); //goodsREtrieve.jsp 경고창에서 활용
		service.cartAdd(cart); //add한 갯수 출력
		
		return "redirect:../goodsRetrieve?gCode="+cart.getgCode();
	}
	
	@RequestMapping("/loginCheck/cartList")
	public String cartList(RedirectAttributes attr,HttpSession session) {
		MemberDTO dto = (MemberDTO)session.getAttribute("login");
		//System.out.println(dto.getUserid());
		String userid = dto.getUserid();
		List<CartDTO> list = service.cartList(userid);
		//System.out.println(list);
		attr.addFlashAttribute("cartList", list); //리다이렉트시 데이터 유지
		return "redirect:../cartList";
	}
	
	@RequestMapping("loginCheck/cartUpdate")
	@ResponseBody
	public void cartUpdate(@RequestParam Map<String, String> map) {
		//System.out.println(map);
		service.cartUpdate(map);
	}
	
	@RequestMapping("loginCheck/cartDelete")
	@ResponseBody
	public void cartDelete(@RequestParam("num") int num) {//자동 형 변환 파싱
		int n = service.cartDelete(num);
		//System.out.println(n);
	}
	
	@RequestMapping(value = "/loginCheck/delAllCart")
	public String delAllCart(@RequestParam("check") ArrayList<String> list) {
		//System.out.println(list);
		int n =service.delAllCart(list);
		//System.out.println(n);
		return "redirect:../loginCheck/cartList"; //카트리스트 다시 읽어오기
	}
	
	@RequestMapping("loginCheck/orderConfirm")
	public String orderConfirm(@RequestParam("num") int num, HttpSession session,
			RedirectAttributes xxx) {
		MemberDTO mDTO=(MemberDTO)session.getAttribute("login");
		String userid = mDTO.getUserid();
		mDTO = mService.myPage(userid); //id이용 사용자 정보 가져오기
		CartDTO cart = service.orderConfirmByNum(num); //장바구니 정보가져오기
		xxx.addFlashAttribute("mDTO", mDTO); //request에 회원정보저장
		xxx.addFlashAttribute("cDTO", cart); //request에 카트정보 저장
		return "redirect:../orderConfirm"; //servlet-context에 등록
	}
	
	@RequestMapping("loginCheck/orderDone")
	public String orderDone(OrderDTO oDTO,
			int orderNum, HttpSession session, RedirectAttributes xxx) {
		System.out.println(oDTO+"\t"+orderNum);
		MemberDTO dto=(MemberDTO)session.getAttribute("login");
		
		oDTO.setUserid(dto.getUserid());//주문정보에 사용자 id 추가
		service.orderDone(oDTO,orderNum);
		xxx.addFlashAttribute("oDTO",oDTO);
		return "redirect:../orderDone"; //servlet-context.xml에 주소등록
	}
	
}
