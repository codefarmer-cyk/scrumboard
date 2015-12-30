package com.voice.ece.cgc.ericsson.service.interfacedef;

import java.util.List;

import com.voice.ece.cgc.ericsson.pojo.Release;
import com.voice.ece.cgc.ericsson.pojo.UserStory;
import com.voice.ece.cgc.ericsson.pojo.response.SimpleResponse;

/**
 * 
 * User story management service
 * 
 * @author Matt He
 *
 */
public interface UserStoryManagementService {
	
	/**
	 * add new user story to specific release
	 * @param userStories the user story list
	 * @param releaseId the specific release's id
	 * @return boolean save successfully or not
	 */
	public SimpleResponse addNewUserStory(UserStory[] userStories,Integer releaseId,int teamId);
	
	public SimpleResponse deleteUserStoryById(int userStoryId);
	
	public SimpleResponse modifyUserStory(UserStory userStory);
	
	public List<UserStory> showLatestUserStories(int teamId);
	
	public List<UserStory> showUserStoriesByReleaseId(int releaseId);
	
	public UserStory getUserStoryById(int id);
	
	public List<UserStory> showOhterUSByTeamId(int teamId);

//	public List<UserStory> showNotUserStories();
}
