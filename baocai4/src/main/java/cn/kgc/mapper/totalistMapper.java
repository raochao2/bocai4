package cn.kgc.mapper;

import cn.kgc.domain.totalist;

import java.util.List;

public interface totalistMapper {
   
    int insertTo(totalist record);
    List<totalist> selectallbyId(Integer userid);

}