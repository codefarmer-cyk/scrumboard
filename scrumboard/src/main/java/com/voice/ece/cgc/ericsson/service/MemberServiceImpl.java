package com.voice.ece.cgc.ericsson.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.voice.ece.cgc.ericsson.dao.interfacedef.GeneralDao;
import com.voice.ece.cgc.ericsson.dao.interfacedef.MemberDao;
import com.voice.ece.cgc.ericsson.dao.interfacedef.TaskDao;
import com.voice.ece.cgc.ericsson.dao.interfacedef.TeamDao;
import com.voice.ece.cgc.ericsson.pojo.Member;
import com.voice.ece.cgc.ericsson.pojo.Task;
import com.voice.ece.cgc.ericsson.pojo.Team;
import com.voice.ece.cgc.ericsson.pojo.response.SimpleResponse;
import com.voice.ece.cgc.ericsson.service.interfacedef.MemberService;

@Service(value = "memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDao memberDao;

	@Autowired
	private GeneralDao generalDao;

	@Transactional(readOnly = true)
	public List<Member> showAllMembersByTeamId(int teamId) {
		return memberDao.getAllMembersByTeamId(teamId);
	}

	@Transactional(readOnly = true)
	public Member getMemberById(int id) {
		return generalDao.get(Member.class, id);
	}

	@Transactional
	public SimpleResponse addNewMember(Member[] members, Integer teamId) {
		try {

			Team team = null;

			if (teamId != null) {
				team = generalDao.load(Team.class, teamId);

				if (team == null)
					return new SimpleResponse(10000, "Specific team does not exist!");
			}

			int size = members.length;

			for (int i = 0; i < size; i++) {
				members[i].setTeam(team);
			}

			memberDao.saveMember(members);

			return new SimpleResponse(20000, "Save successfully!");

		} catch (Exception e) {

			e.printStackTrace();

			return new SimpleResponse(30000, "Exception!");

		}
	}

	@Transactional
	public SimpleResponse deleteMemberById(int memberId) {
		try {
			Member member = getMemberById(memberId);
			for (Task task : member.getTaskSet()) {
				task.setChargedMember(null);
				generalDao.update(task);
			}
			Team team = member.getTeam();
			team.getMemberSet().remove(member);
			generalDao.update(team);
			member.getTaskSet().clear();
			member.setTeam(null);
			generalDao.delete(member);
			return new SimpleResponse(2000, "delete successfully!");

		} catch (Exception e) {

			e.printStackTrace();

			return new SimpleResponse(5000, "Exception!");
		}

	}

	@Transactional
	public SimpleResponse modifyMember(Member member) {
		try {
			Team team = generalDao.load(Team.class, member.getTeam().getId());
			member.setTeam(team);
			generalDao.merge(member);

			return new SimpleResponse(2000, "update successfully");

		} catch (Exception e) {

			e.printStackTrace();

			return new SimpleResponse(5000, "Exception!");

		}
	}

	@Transactional
	public void deleteMember(Member member) {
		generalDao.delete(member);
	}

}
