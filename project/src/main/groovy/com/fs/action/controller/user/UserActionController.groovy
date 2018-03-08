package com.fs.action.controller.user;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody
import com.fs.dao.entities.SysUser;
import com.fs.dao.mapper.SysUserMapper;
import net.sf.json.JSONObject;
@Controller
@RequestMapping("/sys/user")
public class UserActionController {

	@RequestMapping("/add")
	void add(String usercd, String usernm, int roleid, int teamid, int status, int bg, HttpServletResponse response){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//Do add
			def result = [:]
			int cnt = sysUserMapper.checkUserCnt(usercd.trim().toLowerCase())
			if(cnt > 0){
				result.put("result","exist")
			}else{
				SysUser su = new SysUser()
				su.setUsercd(usercd.trim().toLowerCase())
				su.setUsernm(usernm)
				su.setRoleid(roleid)
				su.setTeamid(teamid)
				su.setStatus(status)
				su.setBg(bg)
				sysUserMapper.addUser(su)
				result.put("result","用户添加成功!")
			}
			JSONObject json = JSONObject.fromObject(result)
			out.print(json.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	
	@RequestMapping("/update")
	void update(int tid, String usercd, String usernm, int roleid, int teamid, int status, int bg, HttpServletResponse response){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//Do update
			SysUser su = new SysUser()
			su.setTid(tid)
			su.setUsercd(usercd.trim().toLowerCase())
			su.setUsernm(usernm)
			su.setRoleid(roleid)
			su.setTeamid(teamid)
			su.setStatus(status)
			su.setBg(bg)
			sysUserMapper.updateUser(su)
			JSONObject json = JSONObject.fromObject([result:"用户修改成功!"])
			out.print(json.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	
	@RequestMapping("/getAll")
	void getAll(int offset,int limit, HttpServletResponse response){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//Do query
			def qr = sysUserMapper.getAll(offset, limit)
			def rws = []
			qr.each{
				def record = [:]
				record.put("tid", it.getTid());
				record.put("usercd", it.getUsercd());
				record.put("usernm", it.getUsernm());
				record.put("role", it.getRole());
				record.put("team", it.getTeam());
				record.put("status", it.getStatus());
				record.put("bg", it.getBg());
				record.put("action", "<button type = 'button' class = 'btn btn-link btn-xs' onclick = 'edit(this);'><i class='fa fa-pencil'></i>&nbsp;&nbsp;编辑</button>");
				rws << record
			}
			def json = [:]
			json.put("total", sysUserMapper.getUserCnt())
			json.put("rows", rws)
			JSONObject root = JSONObject.fromObject(json)
			out.print(root.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	
	@RequestMapping("/getUser")
	@ResponseBody SysUser getUser(int tid){
		SysUser user = sysUserMapper.getUser(tid)
		return user
	}
	@Autowired
	private SysUserMapper sysUserMapper;
}
