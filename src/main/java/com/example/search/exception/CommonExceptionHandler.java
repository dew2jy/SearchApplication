package com.example.search.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class CommonExceptionHandler {
	@ExceptionHandler(Exception.class)
	public ModelAndView common(Exception e) {
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/error/commonError");
		mv.addObject("exception", e);
		
		return mv;
	}
	
	@ExceptionHandler(ResourceNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public String handleNotFound() {
        return "/error/404";
    }
	

	public final class ResourceNotFoundException extends RuntimeException {
	
	}
}
