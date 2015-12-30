package com.voice.ece.cgc.ericsson.service.interfacedef;

import java.util.List;

import com.voice.ece.cgc.ericsson.pojo.Release;
import com.voice.ece.cgc.ericsson.pojo.response.SimpleResponse;

public interface ReleaseService {
	
	public List<Release> showAllReleasesByTeamId(int teamId);
	
	public Release getLatestReleaseByTeamId(int teamId);
	
	public Release getReleaseById(int releaseId);
	
	public void deleteRelease(Release release);
	
	public SimpleResponse saveRelease(Release release,int teamId);	

}
