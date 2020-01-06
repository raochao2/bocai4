package cn.kgc.service.impl;

import cn.kgc.domain.invitation;
import cn.kgc.domain.replaydetail;
import cn.kgc.mapper.invitationMapper;
import cn.kgc.mapper.replaydetailMapper;
import cn.kgc.service.DemoService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service("demoService")
public class DemoServiceImpl implements DemoService {

    @Autowired
    private invitationMapper inMapper;
    @Autowired
    private replaydetailMapper replMapper;

    //舍弃不用
    public PageInfo findByCondition(invitation inv, Integer pageNum, Integer pageSize) {
        //分页查询
        //1.开启分页
        PageHelper.startPage(pageNum,pageSize);
        //2.查询数据
        List<invitation> inList =inMapper.selectBytitle(inv);
        //3.封装pageInfo
        PageInfo pageInfo = new PageInfo(inList);
        return pageInfo;
    }
    //测试用包装类 String 接收数据
    @Override
    public PageInfo findByCondition2(String title, Integer pageNum, Integer pageSize) {
        //分页查询
        //1.开启分页
        PageHelper.startPage(pageNum,pageSize);
        //2.查询数据
        List<invitation> inList =inMapper.selectBytitle2(title);
        //3.封装pageInfo
        PageInfo pageInfo = new PageInfo(inList);
        return pageInfo;
    }
    @Override
    public boolean removeByid(Integer id) {
        replMapper.delByinvid(id);
        inMapper.deleteByPrimaryKey(id);
        return true;
    }

    @Override
    public boolean removeContent(Integer id) {
        replMapper.deleteByPrimaryKey(id);
        return true;
    }
    @Override
    public List<replaydetail> findAll(Integer id) {
       List<replaydetail> replaydetails = replMapper.selectByinvid(id);
        return replaydetails;
    }

    @Override
    public boolean addreplay(replaydetail repl) {
        return replMapper.insertSelective(repl)>0?true:false;
    }

    @Override
    public PageInfo findContent(Integer id, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        //2.查询数据
        List<replaydetail> reList =replMapper.selectByinvid(id);
        //3.封装pageInfo
        PageInfo pageInfo = new PageInfo(reList);
        return pageInfo;
    }

    @Override
    public boolean updateReplaydetail(replaydetail replay) {
      return  replMapper.updateByPrimaryKeySelective(replay)>0?true:false;
    }
}
