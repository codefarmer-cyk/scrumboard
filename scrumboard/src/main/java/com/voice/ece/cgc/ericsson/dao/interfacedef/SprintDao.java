package com.voice.ece.cgc.ericsson.dao.interfacedef;

import java.util.List;

import com.voice.ece.cgc.ericsson.pojo.Sprint;

public interface SprintDao {

	public List<Sprint> getAllSprintByReleaseId(int releaseId);

	public Sprint getLatestSprintByReleaseId(int releaseId);

	// public Sprint getSprintById(int sprintId);

	// public void saveSprint(Sprint sprint);

	// public void deleteSprint(Sprint Sprint);

	// public void updateSprint(Sprint sprint);
}
