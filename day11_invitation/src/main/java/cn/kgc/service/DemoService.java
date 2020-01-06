package cn.kgc.service;


import cn.kgc.domain.invitation;
import cn.kgc.domain.replaydetail;
import com.github.pagehelper.PageInfo;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

public interface DemoService {
    //被舍弃了 这个方法
  //  PageInfo findByCondition(invitation inv, Integer pageNum, Integer pageSize);
    PageInfo findByCondition2(String title, Integer pageNum, Integer pageSize);
    boolean removeByid(Integer id);
   //删除评论的信息ID
    boolean removeContent(Integer id );

    List<replaydetail> findAll(Integer id);

    boolean addreplay(replaydetail repl);
    //评论的分页显示
    PageInfo findContent(Integer id, Integer pageNum, Integer pageSize );

    boolean updateReplaydetail(replaydetail replay);
}
