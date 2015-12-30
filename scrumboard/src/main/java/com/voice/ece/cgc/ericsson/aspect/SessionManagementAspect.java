package com.voice.ece.cgc.ericsson.aspect;

import java.util.Arrays;
import java.util.List;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import com.voice.ece.cgc.ericsson.dao.BaseDao;

//@Aspect
//@Component
public class SessionManagementAspect {

	//@Before("execution(* com.voice.ece.cgc.ericsson.dao.*.get*(..))")
	public void beforeMethod(JoinPoint joinpoint) {
		
		BaseDao baseDao=(BaseDao) joinpoint.getTarget();
		
		
	}
	
	//@After("execution(* com.voice.ece.cgc.ericsson.dao.*.get*(..))")
	public void afterMethod(JoinPoint joinpoint)
	{
		
		BaseDao baseDao=(BaseDao) joinpoint.getTarget();
		
		
	}

}
