package com.voice.ece.cgc.ericsson.dao.interfacedef;

import java.util.List;

import com.voice.ece.cgc.ericsson.pojo.Release;

public interface ReleaseDao {
	
//	public Release getReleaseById(int id);
	
	public List<Release> getAllReleasesByTeamId(int teamId);
	
	public Release getLatestReleaseByTeamId(int teamId);
	
//	public void saveRelease(Release release);
	
//	public void deleteRelease(Release release);

}
