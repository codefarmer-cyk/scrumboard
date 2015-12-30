package com.voice.ece.cgc.ericsson.aspect;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;

@Aspect
public class MethodLogger {

	private static final Logger logger = Logger.getLogger(MethodLogger.class);

	@Around("execution(* com.voice.ece.cgc.ericsson.dao.*.*(..))")
	public Object daoLog(ProceedingJoinPoint point) throws Throwable {
		long start = System.currentTimeMillis();
		Object result = null;
			result = point.proceed();
		logger.info("Call " + point.getTarget() + ":"
				+ MethodSignature.class.cast(point.getSignature()).getMethod().getName() + "(" + point.getArgs() + "):"
				+ result + " in " + (System.currentTimeMillis() - start) + "ms");
		return result;
	}

	@AfterThrowing(throwing = "ex", pointcut = "execution(* com.voice.ece.cgc.ericsson.*.*.*(..))")
	public void exceptionLog(JoinPoint point, Throwable ex) {
		logger.error("Call " + point.getTarget() + ":"
				+ MethodSignature.class.cast(point.getSignature()).getMethod().getName() + "(" + point.getArgs() + "):"
				+ "exception:" + ex);
	}

}
