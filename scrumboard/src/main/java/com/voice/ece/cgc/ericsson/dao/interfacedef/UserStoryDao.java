package com.voice.ece.cgc.ericsson.dao.interfacedef;

import java.util.List;

import com.sun.org.apache.xml.internal.resolver.helpers.PublicId;
import com.voice.ece.cgc.ericsson.pojo.UserStory;

public interface UserStoryDao {
	
	public void saveUserStory(UserStory[] userStories);
	
//	public void deleteUserStory(UserStory userStory);
	
//	public void updateUserStory(UserStory userStory);
	
//	public UserStory getUserStoryById(int id);
	
	public List<UserStory> getLatestUserStoriesByTeamId(int teamId);
	
	public List<UserStory> getUserStoriesByReleaseId(int releaseId);
	
//	public List<UserStory> getUserStoriesBySprintId(int sprintId);
	
	public List<UserStory> getOtherUSByTeamId(int teamId);

//	public List<UserStory> getUserStoriesByReleaseIsNull();
}
