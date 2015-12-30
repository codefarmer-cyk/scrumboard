package com.voice.ece.cgc.ericsson.dao.interfacedef;

import java.util.List;

import com.voice.ece.cgc.ericsson.pojo.Member;

public interface MemberDao{

	public List<Member> getAllMembersByTeamId(int teamId);

	public void saveMember(Member[] members);

}
