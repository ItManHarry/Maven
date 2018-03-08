package com.fs.action.controller.server
import java.text.SimpleDateFormat

import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import com.fs.dao.entities.ServerInfo
import com.fs.dao.mapper.ServerInfoMapper
import net.sf.json.JSONObject
@Controller
@RequestMapping("/server/query")
class ServerQueryActionController {

	//查询所有的服务器
	@RequestMapping("/getAll")
	void getAll(int offset, int limit, HttpServletRequest request, HttpServletResponse response){
		String url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/server/serverInfo.do"
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//Do query
			def qr = serverInfoMapper.getAll(offset, limit)
			def rws = []
			qr.each{
				def record = [:]
				record.put("tid", it.getTid());
				record.put("machineName", it.getMachineName());
				record.put("machineModel", it.getMachineModel());
				record.put("machineUsage", it.getMachineUsage());
				record.put("serialNumber", it.getSerialNumber());
				record.put("rent", it.getRent());
				record.put("rentEndDt", it.getRentEndDt()==null?"":new SimpleDateFormat("yyyy-MM-dd").format(it.getRentEndDt()));
				record.put("os", it.getOs());
				record.put("ip", it.getIp());
				record.put("cpuModel", it.getCpuModel());
				record.put("cpuCore", it.getCpuCore());
				record.put("memory", it.getMemory());
				record.put("disk", it.getDisk());
				record.put("usageCategory", it.getUsageCategory());
				record.put("middleware", it.getMiddleware()=='ALL'?"NONE":it.getMiddleware());
				record.put("envirDistinguish", it.getEnvirDistinguish()==1?"正式环境":"测试环境");
				record.put("machineAdd", it.getMachineAdd());
				record.put("run", it.getRun()==1?"<i class = 'fa fa-lightbulb-o fa-lg text-success'></i>":"<i class = 'fa fa-lightbulb-o fa-lg text-danger'></i>");
				record.put("manageBy", it.getManageBy());
				record.put("action", "<a href = '" + url + "?tid=" + it.getTid() + "' class = 'btn btn-link btn-xs'><i class='fa fa-pencil'></i>&nbsp;修改</a>");
				rws << record
			}
			def json = [:]
			json.put("total", serverInfoMapper.getServerCnt())
			json.put("rows", rws)
			JSONObject root = JSONObject.fromObject(json)
			out.print(root.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	
	@Autowired
	private ServerInfoMapper serverInfoMapper;
}