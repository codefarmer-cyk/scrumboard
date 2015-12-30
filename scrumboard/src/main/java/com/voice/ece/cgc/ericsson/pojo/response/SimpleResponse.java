package com.voice.ece.cgc.ericsson.pojo.response;
/**
 * 
 * Use to encapsulate the simple response
 * 
 * @author Matt He
 *
 */
public class SimpleResponse {
	
	private int status;//status code
	
	private String message;
	
	public SimpleResponse(int status, String message) {
		super();
		this.status = status;
		this.message = message;
	}
	
	@Override
	public String toString()
	{
		return this.status+"-"+this.message;
		
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
