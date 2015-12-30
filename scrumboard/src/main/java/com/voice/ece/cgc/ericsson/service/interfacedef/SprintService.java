package com.voice.ece.cgc.ericsson.service.interfacedef;

import java.util.List;

import com.voice.ece.cgc.ericsson.pojo.Sprint;

public interface SprintService {
	
	public List<Sprint> showAllSprintByReleaseId(int releaseId);
	
	public Sprint getLatestSprintByReleaseId(int releaseId);
	
	public Sprint getSprintById(int sprintId);
	
	public void updateSprint(Sprint sprint);

	public void addNewSprint(Sprint sprint);
	
	public void deleteSprint(Sprint sprint);

}
