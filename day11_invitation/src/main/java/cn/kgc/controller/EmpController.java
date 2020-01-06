package cn.kgc.controller;


import cn.kgc.domain.invitation;
import cn.kgc.domain.replaydetail;
import cn.kgc.service.DemoService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/init")
public class EmpController {

    @Autowired
    DemoService demoService;

    //分页动态条件查询
    @RequestMapping("/list")
    public ModelAndView list(@RequestParam(defaultValue ="") String title,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             ModelAndView mv,
                             HttpSession session){
        //动态查询
        PageInfo pageInfo = demoService.findByCondition2(title.trim(), pageNum, 5);
        //把数据封装到作用域对象
        mv.addObject("pageInfo",pageInfo);
        //回显条件
        mv.addObject("condition",title);
       //转发
        mv.setViewName("main");
        return mv;
    }
   //添加功能
    @RequestMapping("/addContent")
    public ModelAndView addcontent(replaydetail detail, ModelAndView mv){
        //添加数据
        boolean b = demoService.addreplay(detail);
        if(b){
            mv.addObject("insert","success");
        }else{
            mv.addObject("insert","fail");
        }
        mv.setViewName("forward:list");
        return mv;
    }
    @RequestMapping("/delete")
    public ModelAndView deleteEmp(Integer id, ModelAndView mv){
        //删除数据
        boolean b = demoService.removeByid(id);
        if(b){
            mv.addObject("delete","success");
        }else{
            mv.addObject("delete","fail");
        }
        mv.setViewName("forward:list");
        return mv;
    }
    @RequestMapping("/findplay")
    public ModelAndView findplay(Integer invid,
                                 @RequestParam(defaultValue = "1") Integer pageNum,
                                 ModelAndView mv){
       //分页查询结果
        PageInfo pageInfo =demoService.findContent(invid,pageNum,5);
        mv.addObject("pageInfo",pageInfo);
        mv.addObject("id",invid);
        mv.setViewName("replayUI");
        return mv;
    }
    @RequestMapping("/deleted")
    public ModelAndView delComment(Integer id, ModelAndView mv){
        //删除数据
        boolean b = demoService.removeContent(id);
        if(b){
            mv.addObject("delete","success");
        }else{
            mv.addObject("delete","fail");
        }
        mv.setViewName("forward:list");
        return mv;
    }

    @RequestMapping("/updateContent")
    public ModelAndView updatecomment(replaydetail replay, ModelAndView mv){
       boolean b=demoService.updateReplaydetail(replay);
        if(b){
            mv.addObject("update","success");
        }else{
            mv.addObject("update","fail");
        }
        mv.setViewName("forward:list");
        return mv;
    }
}
