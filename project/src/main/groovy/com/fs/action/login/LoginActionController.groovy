package com.fs.action.login
import java.util.Map
import javax.servlet.http.HttpSession
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import com.fs.dao.entities.SysUser
import com.fs.dao.mapper.SysUserMapper
import DSGAuthPkg.Auth
@Controller
@RequestMapping("/login")
class LoginActionController {

	//执行登录 
	@RequestMapping("/getIn")
	String getIn(HttpSession session, String userId, String password, String key, Map map){
		map.put("key", key)
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
					return "/login/login"
				}
				session.setAttribute("userid", su.getTid())
				roleId = su.getRoleid()
			}	
			session.setAttribute("loginId", userId)
			session.setAttribute("roleId", roleId)
			switch(key){
				case 'upload':
					if(roleId == 0)
						map.put("authed","N")
					else
						map.put("authed","Y")
					break;
				case ['sysCatalog','catalogAuth','sysUser','sysTeam','sysCode']:
					if(roleId == 1 || roleId == 3)
						map.put("authed","Y")
					else
						map.put("authed","N")
					break;
				default:
					break; 
			}
			if(key == 'login')
				return "/home"
			else
				return "/sys/$key"
		}else{
			map.put("errorMsg","登录失败,请确认账号密码是否正确!")
			return "/login/login" 
		}
	}
	
	//执行登出
	@RequestMapping("/getOut")
	String getOut(HttpSession session){
		session.removeAttribute("loginId")
		session.setAttribute("navKey","home")
		return "home"
	}
	
	@Autowired
	private SysUserMapper sysUserMapper;
}
