package com.fs.action.controller.sys
import java.util.Map
import javax.annotation.Resource
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpSession

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.RequestMapping

import com.fs.dao.entities.SysUser
import com.fs.dao.mapper.SysUserMapper
import com.fs.sys.init.CatalogInitialization
import com.sun.org.apache.bcel.internal.generic.PUTFIELD
@Controller
@RequestMapping("/sys")
class SysController {
	//跳转至主页	
	@RequestMapping("/home")
	String home(HttpSession session){
		session.setAttribute("navKey","home")
		return "home"
	}
	@RequestMapping("/jump")
	String jump(HttpServletRequest request, HttpSession session, String key,  Map map){
		session.setAttribute("navKey",key)
		session.setAttribute("sysNavKey",key)
		map.put("key", key)
		if(key == "home"){
			return "home"
		}else if(key == "login"){
			session.setAttribute("navKey","home")
			return "/login/login"
		}else{
			//检查是否已登录
			def login = session.getAttribute("loginId")
			if(login){
				int roleId = 0
				if(sysUserMapper.checkUserCnt(login.toString().toLowerCase()) == 0){
					session.setAttribute("userid", 0)
					session.setAttribute("roleId", 0)
				}else{
					SysUser su = sysUserMapper.getUserByCode(login.toString().toLowerCase())
					session.setAttribute("userid", su.getTid())
					roleId = su.getRoleid()
					session.setAttribute("roleId", roleId)
				}
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
				return "/sys/$key"
			}else
				return "/login/login"
		} 				
	}
	@Resource(name="catalog")
	CatalogInitialization catalog
	@Autowired
	private SysUserMapper sysUserMapper;
}
