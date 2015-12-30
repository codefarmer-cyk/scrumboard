package com.voice.ece.cgc.ericsson.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.voice.ece.cgc.ericsson.dao.interfacedef.GeneralDao;
import com.voice.ece.cgc.ericsson.dao.interfacedef.ReleaseDao;
import com.voice.ece.cgc.ericsson.dao.interfacedef.TeamDao;
import com.voice.ece.cgc.ericsson.pojo.Release;
import com.voice.ece.cgc.ericsson.pojo.Team;
import com.voice.ece.cgc.ericsson.pojo.response.SimpleResponse;
import com.voice.ece.cgc.ericsson.service.interfacedef.ReleaseService;

@Service(value="releaseService")
public class ReleaseServiceImpl implements ReleaseService {

	@Resource(name="releaseDao")
	private ReleaseDao releaseDao;
	
	@Resource(name="teamDao")
	private TeamDao teamDao;
	
	@Resource(name="generalDao")
	private GeneralDao generalDao;
	
	public ReleaseDao getReleaseDao() {
		return releaseDao;
	}

	public void setReleaseDao(ReleaseDao releaseDao) {
		this.releaseDao = releaseDao;
	}
	
	public TeamDao getTeamDao() {
		return teamDao;
	}

	public void setTeamDao(TeamDao teamDao) {
		this.teamDao = teamDao;
	}
	

	public GeneralDao getGeneralDao() {
		return generalDao;
	}

	public void setGeneralDao(GeneralDao generalDao) {
		this.generalDao = generalDao;
	}

	@Transactional(readOnly=true)
	public List<Release> showAllReleasesByTeamId(int teamId) {
		
		return releaseDao.getAllReleasesByTeamId(teamId);

	}

	@Transactional(readOnly=true)
	public Release getLatestReleaseByTeamId(int teamId) {
		return releaseDao.getLatestReleaseByTeamId(teamId);
	}

	@Transactional(readOnly=true)
	public Release getReleaseById(int releaseId) {
		return generalDao.get(Release.class,releaseId);
	}

	@Transactional
	public SimpleResponse saveRelease(Release release,int teamId) {
		
		try {
			
			Team team=teamDao.getTeamById(teamId);
			
			if(team==null)
				return new SimpleResponse(5000,"cannot find your team!");
			else
			{
				release.setTeam(team);
				generalDao.save(release);
			}
			
			return new SimpleResponse(2000,"save successfully");
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
			return new SimpleResponse(5000, "Exception");
		}
		
	}


	@Transactional
	public void deleteRelease(Release release) {
		generalDao.delete(release);
	}
	
}
