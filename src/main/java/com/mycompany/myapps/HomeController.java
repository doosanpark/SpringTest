package com.mycompany.myapps;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.myapps.model.LogInHistory;
import com.mycompany.myapps.service.AccountService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	
	@Autowired
	AccountService accountService;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		// 히스토리 로컬 데이터 저장 정보
//		
//		String loginHistoryFilePath = "C:\\Users\\bbd03\\Documents\\" 
//				+ "workspace-spring-tool-suite-4-4.9.0.RELEASE\\"
//				+ "SpringTest\\stream.txt";
//		
//		String loginHistory = "";
//		try {
//			FileInputStream fis = new FileInputStream(loginHistoryFilePath);
//			BufferedInputStream bis = new BufferedInputStream(fis);
//			
//			while(true) {
//				int i = fis.read();
//				if(i==-1) {
//					break;
//				}
//				loginHistory += (char) i;
//			}
//		} catch (Exception e) {
//			// TODO: handle exception
//			e.printStackTrace();
//		}
//		//System.out.println(loginHistory);
//		
		
		List<LogInHistory> loginHistory = accountService.getLogInHistory();
		
		model.addAttribute("serverTime", formattedDate);
		model.addAttribute("loginHistory", loginHistory);

		return "home";
	}
	
	
	@ResponseBody
	@RequestMapping(value="/getData", method = RequestMethod.POST)
	public List<LogInHistory> getSearchedData(LogInHistory loginHistory) {
		//System.out.println(loginHistory);
		List<LogInHistory> searchedHistory = accountService.getSearchedHistory(loginHistory);
		
		return searchedHistory;
	}
	

}
