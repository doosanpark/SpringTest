package com.mycompany.myapps;

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
		
		List<LogInHistory> loginHistory = accountService.getLogInHistory();
		
		model.addAttribute("serverTime", formattedDate);
		model.addAttribute("loginHistory", loginHistory);

		return "home";
	}
	
	@ResponseBody
	@RequestMapping(value="/getDataFromPeriod", method = RequestMethod.POST)
	public List<LogInHistory> getSearchedDataFromPeriod(LogInHistory loginHistory) {
		//System.out.println(loginHistory);
		List<LogInHistory> searchedHistory = accountService.getPeriodHistory(loginHistory);
		
		return searchedHistory;
	}
	
	@ResponseBody
	@RequestMapping(value="/getDataFromSearched", method = RequestMethod.POST)
	public List<LogInHistory> getSearchedData(LogInHistory loginHistory) {
		System.out.println("login"+loginHistory);
		List<LogInHistory> searchedHistory = accountService.getSearchedHistory(loginHistory);
		
		return searchedHistory;
	}
	
}
