package com.fs.action.controller.catalog
import javax.annotation.Resource
import javax.servlet.http.HttpServletResponse
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseBody
import com.fs.dao.entities.SysCatalog
import com.fs.dao.mapper.SysCatalogMapper
import com.fs.sys.init.CatalogInitialization
import com.fs.util.config.SysPropertiesConfig
import net.sf.json.JSONObject
@Controller
@RequestMapping("/sys/catalog")
class CatalogActionController {
	@RequestMapping("/add")
	void add(String name,int parentId, int leaf,int status, HttpServletResponse response){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//Do add
			SysCatalog sc = new SysCatalog(name, parentId, leaf, status)
			sysCatalogMapper.addCatalog(sc)
			catalog.reset();
			JSONObject json = JSONObject.fromObject([result:"目录添加成功!"])
			out.print(json.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	@RequestMapping("/update")
	void update(int tid, String name,int parentId, int leaf,int status, HttpServletResponse response){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//Do update
			SysCatalog sc = new SysCatalog(name, parentId, leaf, status)
			sc.setTid(tid)
			sysCatalogMapper.updateCatalog(sc)
			catalog.reset();
			JSONObject json = JSONObject.fromObject([result:"目录修改成功!"])
			out.print(json.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	@RequestMapping("/status")
	void status(int tid, int status, HttpServletResponse response){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//Do update
			SysCatalog sc = sysCatalogMapper.getSysCatalog(tid)
			sc.setStatus(status)
			sysCatalogMapper.updateCatalog(sc)
			catalog.reset();
			JSONObject json = JSONObject.fromObject([result:"OK"])
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
			def qr = sysCatalogMapper.getAll(offset, limit)
			def rws = []
			qr.each{
				def record = [:]
				record.put("tid", it.getTid())
				record.put("ptname", it.getPtname())
				record.put("name", it.getName());
				record.put("status", it.getStatus())
				if(it.getStatus() == '在用') //在用状态下可以锁定/编辑
					record.put("action", "<button type = 'button' class = 'btn btn-link btn-xs' onclick = 'edit(this);'><i class='fa fa-pencil'></i>&nbsp;&nbsp;编辑</button>&nbsp;&nbsp;<button type = 'button' class = 'btn btn-link btn-xs' onclick = 'changeStatus(this,2);'><i class='fa fa-lock'></i>&nbsp;&nbsp;停用</button>");
				else					//停用的情况下只能解锁，解锁后才能编辑
					record.put("action", "<button type = 'button' class = 'btn btn-link btn-xs' onclick = 'edit(this);' disabled><i class='fa fa-pencil'></i>&nbsp;&nbsp;编辑</button>&nbsp;&nbsp;<button type = 'button' class = 'btn btn-link btn-xs' onclick = 'changeStatus(this,1);'><i class='fa fa-unlock-alt'></i>&nbsp;&nbsp;启用</button>");
				rws << record
			}
			def json = [:]
			json.put("total", sysCatalogMapper.getCatalogCnt())
			json.put("rows", rws)
			JSONObject root = JSONObject.fromObject(json)
			out.print(root.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	
	@RequestMapping("/getSysCatalog")
	@ResponseBody SysCatalog getSysCatalog(int tid){
		SysCatalog sysCatalog = sysCatalogMapper.getSysCatalog(tid)
		return sysCatalog
	}
	
	@Autowired
	private SysCatalogMapper sysCatalogMapper;
	@Resource(name="catalog")
	CatalogInitialization catalog
}