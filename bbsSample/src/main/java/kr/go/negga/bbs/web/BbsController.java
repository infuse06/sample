package kr.go.negga.bbs.web;

import java.util.List;

import javax.annotation.Resource;

import kr.go.negga.bbs.service.BbsService;
import kr.go.negga.bbs.service.BbsVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BbsController {

	@Resource(name = "bbsService")
	private BbsService bbsService;
	
	// 처음
	@RequestMapping(value = "/bbsMain.do")
	public String bbsMain(@ModelAttribute("bbsVO") BbsVO bbsVO, Model model) throws Exception {

		return "/bbs/bbsList";
	}

	// 전체보기
	@RequestMapping(value = "/bbs/bbsList.do")
	public ModelAndView bbsList(@ModelAttribute("bbsVO") BbsVO bbsVO, ModelAndView mv) throws Exception {

		List<BbsVO> bbsVO2 = bbsService.selectBbsList(bbsVO);
		
		ModelAndView resultMv = new ModelAndView("jsonView");
		
		resultMv.addObject("resultList", bbsVO2);

		return resultMv;
	}

	// 상세보기
	@RequestMapping(value = "/bbs/getBoard.do")
	@ResponseBody
	public ModelAndView getBoard(@ModelAttribute("bbsVO") BbsVO bbsVO, ModelAndView mv) throws Exception {

		System.out.println("클릭한 게시글 번호 : " + bbsVO.getBno());

		// bbsService.selectBbs에 bbsVO를 넣어 보내고 가져온 값을 BbsVO bbsVO3에 넣는다.
		BbsVO bbsVO3 = bbsService.selectBbs(bbsVO);

		ModelAndView resultMv = new ModelAndView("jsonView");

		resultMv.addObject("bbsVO", bbsVO3);

		return resultMv;
	}

	// 글등록
	@RequestMapping(value = "/bbs/saveBoard.do")
	public ModelAndView saveBoard(@ModelAttribute("bbsVO") BbsVO bbsVO, ModelAndView mv) throws Exception {

		System.out.println("입력한 제목 : " + bbsVO.getTitle());
		System.out.println("입력한 작성자: " + bbsVO.getId());
		System.out.println("입력한 내용: " + bbsVO.getContent());

		bbsService.insertBbs(bbsVO);
		String message = "글등록되었습니다.";
		
		ModelAndView resultMv = new ModelAndView("jsonView");

		resultMv.addObject("resultMsg", message);

		return resultMv;
	}

	// 글삭제
	@RequestMapping(value = "/bbs/deleteBoard.do")
	public ModelAndView deleteBoard(@ModelAttribute("bbsVO") BbsVO bbsVO, ModelAndView mv) throws Exception {
		System.out.println("삭제할 글번호값 : " + bbsVO.getBno());
		
		bbsService.deleteBbs(bbsVO);
		String message = "삭제되었습니다.";
		
		ModelAndView resultMv = new ModelAndView("jsonView");
		resultMv.addObject("resultMsg", message);
		
		return resultMv;
	}
	
	// 글편집
	@RequestMapping(value = "/bbs/modifyBoard.do")
	public ModelAndView modifyBoard(@ModelAttribute("bbsVO") BbsVO bbsVO, ModelAndView mv) throws Exception {
		System.out.println("편집할 글번호값 : " + bbsVO.getBno());
		System.out.println("편집할 제목값 : " + bbsVO.getTitle());
		System.out.println("편집할 내용값 : " + bbsVO.getContent());
		
		bbsService.modifyBbs(bbsVO);
		
		String message = "편집되었습니다.";
		
		ModelAndView resultMv = new ModelAndView("jsonView");
		resultMv.addObject("resultMsg", message);
		
		return resultMv;
	}

}