package com.fs.action.controller.team;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody
import com.fs.dao.entities.SysTeam;
import com.fs.dao.mapper.SysTeamMapper;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject
@Controller
@RequestMapping("/sys/team")
public class TeamActionController {

	@RequestMapping("/add")
	void add(String teamcd, String teamnm, int bg, HttpServletResponse response){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//Do add
			SysTeam st = new SysTeam(teamcd, teamnm, bg)
			sysTeamMapper.addTeam(st)
			JSONObject json = JSONObject.fromObject([result:"Team添加成功!"])
			out.print(json.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	
	@RequestMapping("/update")
	void update(int tid, String teamcd, String teamnm, int bg, HttpServletResponse response){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//Do update
			SysTeam st = new SysTeam(teamcd, teamnm, bg)
			st.setTid(tid)
			sysTeamMapper.updateTeam(st)
			JSONObject json = JSONObject.fromObject([result:"Team修改成功!"])
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
			def qr = sysTeamMapper.getAll(offset, limit)
			def rws = []
			qr.each{
				def record = [:]
				record.put("tid", it.getTid());
				record.put("bg", it.getBg());
				record.put("teamcd", it.getTeamcd());
				record.put("teamnm", it.getTeamnm());
				record.put("action", "<button type = 'button' class = 'btn btn-link btn-xs' onclick = 'edit(this);'><i class='fa fa-pencil'></i>&nbsp;&nbsp;编辑</button>");
				rws << record
			}
			def json = [:]
			json.put("total", sysTeamMapper.getTeamCnt())
			json.put("rows", rws)
			JSONObject root = JSONObject.fromObject(json)
			out.print(root.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	@RequestMapping("/getTeams")
	void getTeams(int bg, HttpServletResponse response){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//Do query
			def qr = sysTeamMapper.getTeams(bg)
			def rws = []
			qr.each{
				def record = [:]
				record.put("tid", it.getTid());
				record.put("teamnm", it.getTeamnm());
				rws << record
			}
			JSONArray ds = JSONArray.fromObject(rws)
			out.print(ds.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	@RequestMapping("/getTeam")
	@ResponseBody SysTeam getTeam(int tid){
		SysTeam team = sysTeamMapper.getTeam(tid)
		return team
	}
	@Autowired
	private SysTeamMapper sysTeamMapper;
}
