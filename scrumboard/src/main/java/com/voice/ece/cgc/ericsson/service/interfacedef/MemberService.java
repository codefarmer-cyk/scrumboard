package com.voice.ece.cgc.ericsson.service.interfacedef;

import java.util.List;

import com.voice.ece.cgc.ericsson.pojo.Member;
import com.voice.ece.cgc.ericsson.pojo.response.SimpleResponse;

public interface MemberService {
	public List<Member> showAllMembersByTeamId(int teamId);

	public Member getMemberById(int id);

	public SimpleResponse addNewMember(Member[] members, Integer teamId);

	public SimpleResponse deleteMemberById(int memberId);

	public SimpleResponse modifyMember(Member member);
	
	public void deleteMember(Member member);
}
