package com.fs.action.controller.catalog.auth
import javax.servlet.http.HttpServletResponse
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import com.fs.dao.entities.SysCatalogAuth
import com.fs.dao.mapper.SysCatalogAuthMapper
import com.sun.net.ssl.internal.ssl.X509KeyManagerImpl.SizedMap

import net.sf.json.JSONArray
import net.sf.json.JSONObject
@Controller
@RequestMapping("/sys/catalog/auth")
class CatalogAuthActionController {
	
	@RequestMapping("/execute")
	void execute(int userid,String parentId, String catalog, HttpServletResponse response){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//delete all
			sysCatalogAuthMapper.delete(userid)
			//Do authorization			
			catalog.split(",").each{
				SysCatalogAuth sc = new SysCatalogAuth(userid, Integer.parseInt(it))
				sysCatalogAuthMapper.execute(sc)
			}
			JSONObject json = JSONObject.fromObject([result:"目录授权成功!"])
			out.print(json.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}

	@RequestMapping("/getSysCatalogAuth")
	void getSysCatalogAuth(int userid, HttpServletResponse response){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//Do query
			def qr = sysCatalogAuthMapper.getSysCatalogAuth(userid)
			def rws = []
			qr.each{
				rws << it.getCatalog()
			}
			JSONArray ds = JSONArray.fromObject(rws)
			out.print(ds.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	@Autowired
	private SysCatalogAuthMapper sysCatalogAuthMapper;
}
