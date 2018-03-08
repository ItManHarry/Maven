package com.fs.action.controller.code
import javax.servlet.http.HttpServletResponse
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseBody
import com.fs.dao.entities.SysCode
import com.fs.dao.mapper.SysCodeMapper
import net.sf.json.JSONObject
import net.sf.json.JSONArray
@Controller
@RequestMapping("/sys/code")
class SysCodeActionController {
	
	@RequestMapping("/add")
	void add(String code,int cdvl, String cdvw, HttpServletResponse response){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//Do add
			SysCode sc = new SysCode(code, cdvl, cdvw)
			sysCodeMapper.addCode(sc)
			JSONObject json = JSONObject.fromObject([result:"CODE添加成功!"])
			out.print(json.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	@RequestMapping("/update")
	void update(int tid, String code,int cdvl, String cdvw, HttpServletResponse response){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//Do update
			SysCode sc = new SysCode(code, cdvl, cdvw)
			sc.setTid(tid)
			sysCodeMapper.updateCode(sc)
			JSONObject json = JSONObject.fromObject([result:"CODE修改成功!"])
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
			def qr = sysCodeMapper.getAll(offset, limit)
			def rws = []
			qr.each{
				def record = [:]
				record.put("tid", it.getTid());
				record.put("code", it.getCode());
				record.put("cdvl", it.getCdvl());
				record.put("cdvw", it.getCdvw());
				record.put("action", "<button type = 'button' class = 'btn btn-link btn-xs' onclick = 'edit(this);'><i class='fa fa-pencil'></i>&nbsp;&nbsp;编辑</button>");
				rws << record
			}
			def json = [:]
			json.put("total", sysCodeMapper.getCodeCnt())
			json.put("rows", rws)
			JSONObject root = JSONObject.fromObject(json)
			out.print(root.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	
	@RequestMapping("/getCode")
	@ResponseBody SysCode getCode(int tid){
		SysCode code = sysCodeMapper.getCode(tid)
		return code
	}
	
	@RequestMapping("/getOps")
	void getOps(String code, String filter, HttpServletResponse response){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//Do query
			def qr = sysCodeMapper.getValues(code)
			def ops = []
			qr.each{
				def record = [:]
				record.put("cdvl", it.getCdvl());
				record.put("cdvw", it.getCdvw());
				ops << record
			}
			//执行过滤
			if(filter != ""){
				ops = ops.findAll{
					filter.indexOf(it.cdvl+"") == -1
				}
			}
			JSONArray ds = JSONArray.fromObject(ops)
			out.print(ds.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}

	@Autowired
	private SysCodeMapper sysCodeMapper;
}
