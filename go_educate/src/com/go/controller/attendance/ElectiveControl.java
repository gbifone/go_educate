package com.go.controller.attendance;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.go.common.util.ExtendDate;
import com.go.common.util.SqlUtil;
import com.go.common.util.SysUtil;
import com.go.controller.base.BaseController;
import com.go.po.common.PageBean;
import com.go.po.common.Syscontants;
import com.go.service.attendance.ElectiveService;
import com.go.service.platform.CurriculumService;
/**
 * 选课控制类
 * @author Administrator
 *
 */
@Controller
@RequestMapping("/elective")
public class ElectiveControl extends BaseController {
	  @Resource
	  private  ElectiveService  electiveService;
	  @Resource
	  private  CurriculumService  curriculumService;
	  /**
	   * 添加数据页面
	   * @return
	   */
	  @RequestMapping("add.do")
	  public  String add(HttpServletRequest request,HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  parameter.put("today", ExtendDate.getYMD(new Date()));
		  List<Map<String,Object>> list=electiveService.findOptionalLesson(parameter);
		  model.addAttribute("timeList", list);
		  model.addAttribute("parameter", parameter);
		  return  "attendance/elective/edit";
	  }  
	  /**
	   * 导出数据
	   * @param request
	   * @param response
	   * @return
	   */
	  @RequestMapping("load.do")
	  public  String load(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object>  parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object>  res = this.electiveService.load(parameter);
		  model.addAttribute("vo", res);
		  
		  return "forward:add.do";
	  }
	  /**
	   * 保存后台的菜单
	   * @param request
	   * @param response
	 * @throws Exception 
	   */
	  @RequestMapping("save.do")
	  public  void save(HttpServletRequest request, HttpServletResponse response,String[] LESSONID) throws Exception{
		  Map<String,Object> user=SysUtil.getSessionUsr(request, "user");//当前用户
		  //获取请求参数
		  Map<String,Object> parameter = sqlUtil.setParameterInfo(request);
		  Map<String,Object> elective=new HashMap<String,Object>();
		  elective.put("USERID", user.get("ID"));//学生ID
		  elective.put("CURRICULUMID", parameter.get("CURRICULUMID"));
		  elective.put("MUCHLESSON", LESSONID.length);
		  elective.put("CREATEDATE", ExtendDate.getYMD(new Date()));
		  String electiveid=SqlUtil.uuid();
		  elective.put("id", electiveid);
		  electiveService.add(elective);//添加选课
		  
		  List<Map<String,Object>> electiveLessonList=new ArrayList<Map<String,Object>>();
		  for(String str:LESSONID){
			  String[] arr=str.split("-");
			  Map<String,Object> electiveLesson=new HashMap<String,Object>();//选课课时表
			  electiveLesson.put("ELECTIVEID", electiveid);
			  electiveLesson.put("LESSONID", arr[1]);
			  electiveLesson.put("TIMEID", arr[0]);
			  electiveLesson.put("id", SqlUtil.uuid());
			  electiveLessonList.add(electiveLesson);
		  }
		  electiveService.addElectiveLesson(electiveLessonList);
		  this.ajaxMessage(response, Syscontants.MESSAGE,"添加成功");
		  
	  }
	  /**
	   * 查询课程列表
	   * @param request
	   * @param response
	   */
	  @RequestMapping("findList.do")
	  public  String  findList(HttpServletRequest request, HttpServletResponse response,Model  model){
		  Map<String,Object> parameter = sqlUtil.queryParameter(request);
		  parameter.put("ISACTIVES", 1);
		  PageBean<Map<String,Object>> pb = curriculumService.findList(parameter);
		  model.addAttribute("pageBean", pb);
		  model.addAttribute("parameter", parameter);
		  return  "attendance/elective/list";
	  }
	  /**
	   * 删除数据
	   * @param request
	   * @param response
	   */
	  @RequestMapping("delete.do")
	  public  void  delete(HttpServletRequest request, HttpServletResponse response){
		  List<String> parameter = sqlUtil.getIdsParameter(request);
		  this.electiveService.delete(parameter);
		  this.ajaxMessage(response, Syscontants.MESSAGE, "删除成功");
	  }
}