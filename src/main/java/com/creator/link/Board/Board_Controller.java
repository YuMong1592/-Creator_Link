package com.creator.link.Board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.creator.link.Paging;
import com.creator.link.Member.Member_DTO;

@Controller
public class Board_Controller {
	@Autowired
	SqlSession sqlSession;
	String path = "C:\\이젠디지탈12\\spring\\Creator_Link\\src\\main\\webapp\\resources\\board\\";
	
	@RequestMapping(value = "board_main")
	public String board_main(HttpServletRequest request, Model mo) {
		String now_page = request.getParameter("now_page");
		if (now_page == null) now_page = "1";
		String view_per_page = request.getParameter("view_per_page");
		if (view_per_page == null) view_per_page = "5";
		String mb_number = request.getParameter("mb_number");
		if (mb_number == null) mb_number = "1";
		String bat_number = request.getParameter("bat_number");
		String search = request.getParameter("search");
		String value = request.getParameter("value");
		int value_of_total = 0;
		
		ArrayList<Attribute_DTO> attribute_list = new ArrayList<Attribute_DTO>();
		Board_Service sv = sqlSession.getMapper(Board_Service.class);
		attribute_list = sv.attribute_list(mb_number);
		value_of_total = sv.value_of_total(mb_number, bat_number, search, value);
		Paging paging = new Paging(Integer.parseInt(now_page), Integer.parseInt(view_per_page), value_of_total);
		ArrayList<Board_DTO> board_list = sv.board_list(mb_number, paging, bat_number, search, value);
		
		mo.addAttribute("board_list", board_list);
		mo.addAttribute("attribute_list", attribute_list);
		mo.addAttribute("page", paging);
		mo.addAttribute("bat_number", bat_number);
		mo.addAttribute("search", search);
		mo.addAttribute("value", value);
		
		return "board_main";
	}
	@RequestMapping(value = "board_creator")
	public String board_creator() {
		return "board_creator";
	}
	@RequestMapping(value = "board_write")
	public String board_write(HttpServletRequest request, Model mo) {
		String mb_number = request.getParameter("mb_number");
		ArrayList<Attribute_DTO> attribute_list = new ArrayList<Attribute_DTO>();
		
		Board_Service sv = sqlSession.getMapper(Board_Service.class);
		if (mb_number == null) {
			mb_number = "1";
			attribute_list = sv.attribute_list(mb_number);
		}
		else {
			attribute_list = sv.attribute_list(mb_number);
		}
		
		mo.addAttribute("attribute_list", attribute_list);
		
		return "board_write";
	}
	@RequestMapping(value = "board_save")
	public String board_save(HttpServletRequest request) throws IllegalStateException, IOException {
		String bct_title = request.getParameter("title");
		String bct_content = request.getParameter("content");
		String bat_number = request.getParameter("attribute");
		String mb_number = "1";
		
		HttpSession hs = request.getSession();
		Member_DTO dto = (Member_DTO)hs.getAttribute("member");
		String bct_writer = dto.getMb_nick_name();
		
		Board_Service sv = sqlSession.getMapper(Board_Service.class);
		sv.board_save(bct_writer, bct_title, bct_content, bat_number, mb_number);
		
		return "redirect:board_main";
	}
	@RequestMapping(value = "board_view")
	public String board_view(HttpServletRequest request, Model mo) {
		String bct_content_number = request.getParameter("bct_content_number");
		
		
		Board_Service sv = sqlSession.getMapper(Board_Service.class);
		sv.board_view_cntup(bct_content_number);
		Board_DTO post = sv.board_view(bct_content_number);
		ArrayList<Comment_DTO> comment = sv.comment_list(bct_content_number);
		
		mo.addAttribute("post", post);
		mo.addAttribute("comment", comment);
		
		return "board_view";
	}
	@RequestMapping(value = "board_delete")
	public String board_delete(HttpServletRequest request) {
		String bct_content_number = request.getParameter("bct_content_number");
		
		Board_Service sv = sqlSession.getMapper(Board_Service.class);
		sv.board_delete(bct_content_number);
		
		return "redirect:board_main";
	}
	@RequestMapping(value = "board_modify")
	public String board_modify(HttpServletRequest request, Model mo) {
		String bct_content_number = request.getParameter("bct_content_number");
		
		Board_Service sv = sqlSession.getMapper(Board_Service.class);
		Board_DTO post = sv.board_view(bct_content_number);
		ArrayList<Attribute_DTO> attribute_list = sv.attribute_list(String.valueOf(post.mb_number));
		
		mo.addAttribute("post", post);
		mo.addAttribute("attribute_list", attribute_list);
		
		return "board_modify";
	}
	@RequestMapping(value = "board_modify_do")
	public String board_modify_do(HttpServletRequest request, Model mo) {
		String bct_content_number = request.getParameter("bct_content_number");
		String bct_title = request.getParameter("title");
		String bct_content = request.getParameter("content");
		
		Board_Service sv = sqlSession.getMapper(Board_Service.class);
		sv.board_modify(bct_title, bct_content, bct_content_number);
		
		return "redirect:board_main";
	}
	@RequestMapping(value = "comment_save")
	public String comment_save(HttpServletRequest request, Model mo) {
		String cm_content = request.getParameter("cm_content");
		String bct_content_number = request.getParameter("bct_content_number");
		String cm_inheritance = request.getParameter("cm_inheritance");
		String cm_indent = request.getParameter("cm_indent");
		if (cm_inheritance == null) cm_inheritance = "0";
		if (cm_indent == null) cm_indent = "0";
		
		HttpSession hs = request.getSession();
		Member_DTO member = (Member_DTO)hs.getAttribute("member");
		String mb_id = member.getMb_id();
		String mb_nick_name = member.getMb_nick_name();
		
		Board_Service sv = sqlSession.getMapper(Board_Service.class);
		sv.comment_save(cm_content, bct_content_number, mb_id, cm_inheritance, mb_nick_name, cm_indent);
		
		mo.addAttribute("bct_content_number", bct_content_number);
		
		return "redirect:board_view";
	}
	@RequestMapping(value = "comment_delete")
	public String comment_delete(HttpServletRequest request, Model mo) {
		String cm_number = request.getParameter("cm_number");
		String cm_indent = request.getParameter("cm_indent");
		
		String url = request.getHeader("referer");
		Board_Service sv = sqlSession.getMapper(Board_Service.class);
		if (Integer.parseInt(cm_indent) == 0) sv.comment_deleteall(cm_number);
		sv.comment_delete(cm_number);
		
		
		return "redirect:"+url;
	}
}