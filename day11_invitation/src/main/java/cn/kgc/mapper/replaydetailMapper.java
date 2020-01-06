package cn.kgc.mapper;

import cn.kgc.domain.replaydetail;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface replaydetailMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(replaydetail record);

    int insertSelective(replaydetail record);

    replaydetail selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(replaydetail record);

    int updateByPrimaryKey(replaydetail record);
    @Delete(" delete  from replaydetail  where invid=#{id}" )
    int delByinvid(Integer id);
    @Select(" select  * from replaydetail  where invid=#{id}  order by  createdate desc  ")
    List<replaydetail> selectByinvid(Integer id);
}