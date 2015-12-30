package com.voice.ece.cgc.ericsson.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.voice.ece.cgc.ericsson.dao.TeamdaoImpl;
import com.voice.ece.cgc.ericsson.dao.interfacedef.GeneralDao;
import com.voice.ece.cgc.ericsson.dao.interfacedef.ReleaseDao;
import com.voice.ece.cgc.ericsson.dao.interfacedef.TeamDao;
import com.voice.ece.cgc.ericsson.dao.interfacedef.UserStoryDao;
import com.voice.ece.cgc.ericsson.pojo.Release;
import com.voice.ece.cgc.ericsson.pojo.Team;
import com.voice.ece.cgc.ericsson.pojo.UserStory;
import com.voice.ece.cgc.ericsson.pojo.response.SimpleResponse;
import com.voice.ece.cgc.ericsson.service.interfacedef.UserStoryManagementService;

@Service(value = "userStoryManagementService")
public class UserStoryManagementImpl implements UserStoryManagementService {

	@Resource(name = "userStoryDao")
	private UserStoryDao userStoryDao;

	@Resource(name = "releaseDao")
	private ReleaseDao releaseDao;

	@Resource(name = "generalDao")
	private GeneralDao generalDao;
	
	@Resource(name="teamDao")
	private TeamDao teamDao;

	public void setUserStoryDao(UserStoryDao userStoryDao) {
		this.userStoryDao = userStoryDao;
	}

	public void setReleaseDao(ReleaseDao releaseDao) {
		this.releaseDao = releaseDao;
	}

	public GeneralDao getGeneralDao() {
		return generalDao;
	}

	public void setGeneralDao(GeneralDao generalDao) {
		this.generalDao = generalDao;
	}

	public UserStoryDao getUserStoryDao() {
		return userStoryDao;
	}

	public ReleaseDao getReleaseDao() {
		return releaseDao;
	}
	
	public TeamDao getTeamDao() {
		return teamDao;
	}

	public void setTeamDao(TeamDao teamDao) {
		this.teamDao = teamDao;
	}

	@Transactional
	public SimpleResponse addNewUserStory(UserStory[] userStories, Integer releaseId,int teamId) {

		try {

			
			Release release=null;
			
			if(releaseId!=null)
			{
				release = generalDao.get(Release.class, releaseId);
				
				if (release == null)
					return new SimpleResponse(10000, "Specific release does not exist!");
			}
			  
			
			Team team=teamDao.getTeamById(teamId);

			
			int size = userStories.length;

			for (int i = 0; i < size; i++) {
				userStories[i].setRelease(release);
				userStories[i].setTeam(team);
			}

			userStoryDao.saveUserStory(userStories);

			return new SimpleResponse(20000, "Save successfully!");

		} catch (Exception e) {

			e.printStackTrace();

			return new SimpleResponse(30000, "Exception!");

		}

	}

	@Transactional
	public SimpleResponse deleteUserStoryById(int userStoryId) {

		try {
			UserStory userStory = new UserStory();

			userStory.setId(userStoryId);

			// userStoryDao.deleteUserStory(userStory);
			generalDao.delete(userStory);

			return new SimpleResponse(2000, "delete successfully!");

		} catch (Exception e) {

			e.printStackTrace();

			return new SimpleResponse(5000, "Exception!");
		}

	}

	@Transactional
	public SimpleResponse modifyUserStory(UserStory userStory) {

		try {

			// userStoryDao.updateUserStory(userStory);
			generalDao.update(userStory);

			return new SimpleResponse(2000, "update successfully");

		} catch (Exception e) {

			e.printStackTrace();

			return new SimpleResponse(5000, "Exception!");

		}

	}

	@Transactional(readOnly = true)
	public List<UserStory> showLatestUserStories(int teamId) {

		try {

			return userStoryDao.getLatestUserStoriesByTeamId(teamId);

		} catch (Exception e) {

			e.printStackTrace();

			return null;

		}

	}

	@Transactional(readOnly = true)
	public List<UserStory> showUserStoriesByReleaseId(int releaseId) {

		return userStoryDao.getUserStoriesByReleaseId(releaseId);

	}

//	@Transactional(readOnly = true)
//	public List<UserStory> showUserStoriesBySprintId(int sprintId) {
//		return userStoryDao.getUserStoriesBySprintId(sprintId);
//	}

	@Transactional(readOnly = true)
	public UserStory getUserStoryById(int id) {
		return generalDao.get(UserStory.class, id);
	}

	@Transactional(readOnly = true)
	public List<UserStory> showOhterUSByTeamId(int teamId){
		
		return userStoryDao.getOtherUSByTeamId(teamId);
		
	}
	
//	@Transactional(readOnly = true)
//	public List<UserStory> showNotUserStories() {
//		return userStoryDao.getUserStoriesByReleaseIsNull();
//	}

}
