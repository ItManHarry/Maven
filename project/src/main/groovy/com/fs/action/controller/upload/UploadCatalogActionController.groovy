package com.fs.action.controller.upload
import javax.annotation.Resource
import javax.servlet.http.HttpServletResponse
import javax.servlet.http.HttpSession
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import com.fs.action.controller.beans.CatalogTreeBean
import com.fs.dao.entities.SysCatalog
import com.fs.dao.entities.SysCatalogAuth
import com.fs.dao.mapper.SysCatalogAuthMapper
import com.fs.dao.mapper.SysCatalogMapper
import com.fs.sys.init.CatalogInitialization
import com.sun.net.ssl.internal.ssl.X509KeyManagerImpl.SizedMap
import net.sf.json.JSONArray
import net.sf.json.JSONObject
@Controller
@RequestMapping("/sys/upload/catalog")
class UploadCatalogActionController {
	
	@RequestMapping("/add")
	void add(String name,int parentId, int leaf,int status, HttpServletResponse response, HttpSession session){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			def authes = []	//目录权限ID
			//新增目录
			SysCatalog sc = new SysCatalog(name, parentId, leaf, status)
			sysCatalogMapper.addCatalog(sc)
			authes << sc.getTid()
			catalog.reset();
			def userid = session.getAttribute("userid")
			//获取已赋的目录权限
			def qr = sysCatalogAuthMapper.getSysCatalogAuth(userid)
			qr.each{
				authes << it.getCatalog()
			}
			//删除已授权的目录权限
			sysCatalogAuthMapper.delete(userid)
			//重新赋予			
			authes.each{
				SysCatalogAuth sca = new SysCatalogAuth(userid, it)
				sysCatalogAuthMapper.execute(sca)
			}
			JSONObject json = JSONObject.fromObject([result:"目录新增成功!"])
			out.print(json.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	
	@RequestMapping("/update")
	void update(int tid, String name,int parentId, int leaf,int status, HttpServletResponse response, HttpSession session){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//修改目录
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

	@RequestMapping("/getAll")
	void getAll(String basePath, HttpServletResponse response, HttpSession session){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//获取已授权的目录权限
			def userid = session.getAttribute("userid")
			def qr = sysCatalogAuthMapper.getSysCatalogAuth(userid)
			def authes = []
			qr.each{
				authes << it.getCatalog()
			}
			//Do query
			qr = sysCatalogMapper.getParentCatalog()
			def nodes = []
			def pid = 0 
			qr.each{
				pid = it.getTid()
				//执行过滤,只添加已授权的目录
				if(authes.any{pid == it}){
					CatalogTreeBean node = new CatalogTreeBean(id:it.getTid(),
						pId:"0",
						name:it.getName(),
						open:true,
						icon:basePath+"css/zTreeStyle/img/diy/folder_close.gif",
						iconOpen:basePath+"css/zTreeStyle/img/diy/folder_open.gif",
						iconClose:basePath+"css/zTreeStyle/img/diy/folder_close.gif",
						leaf:it.getLeaf());
					addNodes(node, basePath,authes)
					nodes << node
				}
			}
			def json = [:]
			json.put("nodes", nodes)
			JSONObject root = JSONObject.fromObject(json)
			out.print(root.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	
	/**
	 * 递归添加子节点
	 * @param node
	 */
	void addNodes(CatalogTreeBean node, String basePath, def authes){
		node.setIcon(basePath+"css/zTreeStyle/img/diy/folder_close.gif");
		List<SysCatalog> childNodes = catalog.getCm().get(node.getId());
		if(childNodes != null && childNodes.size() != 0){
			node.setIconOpen(basePath+"css/zTreeStyle/img/diy/folder_open.gif");
			node.setIconClose(basePath+"css/zTreeStyle/img/diy/folder_close.gif");
			List<CatalogTreeBean> cns = new ArrayList<CatalogTreeBean>();
			for(SysCatalog sc : childNodes){
				//执行过滤,只添加已授权的目录
				if(authes.any{sc.getTid() == it}){
					CatalogTreeBean cn = new CatalogTreeBean(id:sc.getTid(),
						pId:sc.getParentId(),
						name:sc.getName(),
						open:true,
						icon:"",
						leaf:sc.getLeaf());
					cns.add(cn);
					addNodes(cn, basePath,authes);
				}
			}
			node.setChildren(cns);
		}else{
			//if(node.getLeaf() == 1)
				//node.setIcon(basePath+"css/zTreeStyle/img/cube.png");
			return;
		}
	}
	
	@Autowired
	private SysCatalogAuthMapper sysCatalogAuthMapper;
	@Autowired
	private SysCatalogMapper sysCatalogMapper;
	@Resource(name="catalog")
	CatalogInitialization catalog
}
