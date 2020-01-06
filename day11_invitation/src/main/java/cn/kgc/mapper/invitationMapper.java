package cn.kgc.mapper;

import cn.kgc.domain.invitation;

import java.util.List;

public interface invitationMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(invitation record);

    int insertSelective(invitation record);

    invitation selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(invitation record);

    int updateByPrimaryKey(invitation record);
    List<invitation> selectBytitle(invitation invitation);
    List<invitation> selectBytitle2(String title);
}