package com.fs.action.controller.server
import java.text.DateFormat
import java.text.SimpleDateFormat
import java.util.Map
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpSession
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import com.fs.dao.entities.ServerInfo
import com.fs.dao.mapper.ServerInfoMapper
@Controller
@RequestMapping("/server/admin")
class ServerActionController {

	//新增服务器信息
	@RequestMapping("/save")
	String save(HttpServletRequest request, Map map){
		//tid为空表示新增,否则表示修改
		String tid = request.getParameter("tid") 
		ServerInfo si = null
		if(tid == '')
			si = new ServerInfo()
		else
			si = serverInfoMapper.getServer(Integer.parseInt(tid))
		si.setMachineName(request.getParameter("machineName"))
		si.setMachineModel(request.getParameter("machineModel"))
		si.setMachineUsage(request.getParameter("machineUsage"))
		si.setMachineAdd(Integer.parseInt(request.getParameter("machineAdd")))
		si.setSerialNumber(request.getParameter("serialNumber"))
		si.setRent(Integer.parseInt(request.getParameter("rent")))
		if(request.getParameter("rentEndDt") != null && !"".equals(request.getParameter("rentEndDt")))
			si.setRentEndDt(new java.sql.Date(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("rentEndDt")).getTime()))		
		si.setOs(Integer.parseInt(request.getParameter("os")))
		si.setIp(request.getParameter("ip"))
		si.setCpuCore(request.getParameter("cpuCore"))
		si.setCpuModel(request.getParameter("cpuModel"))
		si.setMemory(request.getParameter("memory"))
		si.setDisk(request.getParameter("disk"))
		si.setUsageCategory(Integer.parseInt(request.getParameter("usageCategory")))
		si.setMiddleware(request.getParameter("middleware") == null ? 0 : Integer.parseInt(request.getParameter("middleware")))
		si.setEnvirDistinguish(Integer.parseInt(request.getParameter("envirDistinguish")))
		si.setRun(Integer.parseInt(request.getParameter("run")))
		si.setManageBy(Integer.parseInt(request.getParameter("manageBy")))
		if(tid == '')
			serverInfoMapper.addServer(si)
		else
			serverInfoMapper.updateServer(si)
		return "/server/serverList"
	}
	
	@Autowired
	private ServerInfoMapper serverInfoMapper;
}