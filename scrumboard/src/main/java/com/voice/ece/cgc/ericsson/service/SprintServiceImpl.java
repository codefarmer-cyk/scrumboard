package com.voice.ece.cgc.ericsson.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.voice.ece.cgc.ericsson.dao.interfacedef.GeneralDao;
import com.voice.ece.cgc.ericsson.dao.interfacedef.SprintDao;
import com.voice.ece.cgc.ericsson.pojo.Sprint;
import com.voice.ece.cgc.ericsson.service.interfacedef.SprintService;

@Service(value = "sprintService")
public class SprintServiceImpl implements SprintService {

	@Resource(name = "sprintDao")
	private SprintDao sprintDao;

	@Resource(name = "generalDao")
	private GeneralDao generalDao;
	
	public SprintDao getSprintDao() {
		return sprintDao;
	}

	public void setSprintDao(SprintDao sprintDao) {
		this.sprintDao = sprintDao;
	}
	
	public GeneralDao getGeneralDao() {
		return generalDao;
	}

	public void setGeneralDao(GeneralDao generalDao) {
		this.generalDao = generalDao;
	}

	@Transactional(readOnly = true)
	public List<Sprint> showAllSprintByReleaseId(int releaseId) {

		return sprintDao.getAllSprintByReleaseId(releaseId);
	}

	@Transactional(readOnly = true)
	public Sprint getLatestSprintByReleaseId(int releaseId) {
		return sprintDao.getLatestSprintByReleaseId(releaseId);
	}

	@Transactional(readOnly = true)
	public Sprint getSprintById(int sprintId) {
//		return sprintDao.getSprintById(sprintId);
		return generalDao.get(Sprint.class, sprintId);
	}

	@Transactional
	public void addNewSprint(Sprint sprint) {
//		sprintDao.saveSprint(sprint);
		generalDao.save(sprint);
	}

	@Transactional
	public void deleteSprint(Sprint sprint) {
		
//		sprintDao.deleteSprint(sprint);
		generalDao.delete(sprint);
	}

	@Transactional
	public void updateSprint(Sprint sprint) {
//		sprintDao.updateSprint(sprint);
		generalDao.update(sprint);
	}

}
