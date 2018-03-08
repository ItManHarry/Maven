package com.fs.action.login
import java.util.Map
import javax.servlet.http.HttpSession
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import com.fs.dao.entities.ServerInfo
import com.fs.dao.entities.SysUser
import com.fs.dao.mapper.ServerInfoMapper
import com.fs.dao.mapper.SysUserMapper
import DSGAuthPkg.Auth
@Controller
@RequestMapping("/server")
class ServerAdminLoginActionController {

	//进入服务器管理登录画面
	@RequestMapping("/login")
	String login(){
		return "login/loginServerAdmin"
	}
	//进入服务器新增画面
	@RequestMapping("/serverInfo")
	String serverInfo(int tid, Map map){
		if(tid != 0){
			ServerInfo si = serverInfoMapper.getServer(tid)	
			map.put("si",si)
		}	
		return "/server/serverInfo"
	}
	//进入服务器清单画面
	@RequestMapping("/toList")
	String toList(){
		return "/server/serverList"
	}
	//执行登录 
	@RequestMapping("/enter")
	String enter(HttpSession session, String userId, String password, Map map){
		Auth auth = new Auth("authsj.corp.doosan.com", "dsg\\"+userId, password)
		boolean r = auth.validateUser(userId, password)
		if(r){
			int roleId = 0
			if(sysUserMapper.checkUserCnt(userId.toLowerCase()) == 0)
				session.setAttribute("userid", 0)
			else{
				SysUser su = sysUserMapper.getUserByCode(userId.toLowerCase())
				if(su.getStatus() == 2){
					map.put("errorMsg","账号已停用!")
					return "/login/loginServerAdmin"
				}
				session.setAttribute("userid", su.getTid())
				roleId = su.getRoleid()
			}	
			session.setAttribute("loginId", userId)
			session.setAttribute("roleId", roleId)
			if(roleId != 3){
				map.put("errorMsg","您不是超级管理员,不具备服务器管理的权限!")
				return "/login/loginServerAdmin"
			}else
				return "/server/serverList"
		}else{
			map.put("errorMsg","登录失败,请确认账号密码是否正确!")
			return "login/loginServerAdmin"
		}
	}
	
	//执行登出
	@RequestMapping("/exit")
	String exit(HttpSession session){
		session.removeAttribute("loginId")
		return "login/loginServerAdmin"
	}
	
	@Autowired
	private SysUserMapper sysUserMapper
	@Autowired
	private ServerInfoMapper serverInfoMapper;
}
