package com.fs.action.controller.catalog
import javax.annotation.Resource
import javax.servlet.http.HttpServletResponse
import org.junit.internal.matchers.Each
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import com.fs.action.controller.beans.CatalogTreeBean
import com.fs.dao.entities.SysCatalog
import com.fs.dao.mapper.SysCatalogMapper
import com.fs.sys.init.CatalogInitialization
import com.sun.corba.se.impl.protocol.GetInterface
import net.sf.json.JSONObject
@Controller
@RequestMapping("/sys/catalog/tree/auth")
class CatalogTreeAuthController {
	
	@RequestMapping("/getAll")
	void getAll(String basePath, HttpServletResponse response){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//Do query
			def qr = sysCatalogMapper.getParentCatalog()
			def nodes = []
			qr.each{
				CatalogTreeBean node = new CatalogTreeBean(id:it.getTid(),
					pId:"0",
					name:it.getName(),
					open:true,
					icon:basePath+"css/zTreeStyle/img/diy/folder_close.gif",
					iconOpen:basePath+"css/zTreeStyle/img/diy/folder_open.gif",
					iconClose:basePath+"css/zTreeStyle/img/diy/folder_close.gif",
					leaf:it.getLeaf());
				addNodes(node, basePath);
				nodes << node
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
	void addNodes(CatalogTreeBean node, String basePath){
		node.setIcon(basePath+"css/zTreeStyle/img/diy/folder_close.gif");
		List<SysCatalog> childNodes = catalog.getCm().get(node.getId());
		if(childNodes != null && childNodes.size() != 0){
			node.setIconOpen(basePath+"css/zTreeStyle/img/diy/folder_open.gif");
			node.setIconClose(basePath+"css/zTreeStyle/img/diy/folder_close.gif");
			List<CatalogTreeBean> cns = new ArrayList<CatalogTreeBean>();
			for(SysCatalog sc : childNodes){
				CatalogTreeBean cn = new CatalogTreeBean(id:sc.getTid(),
					pId:sc.getParentId(),
					name:sc.getName(),
					open:false,
					icon:"",
					leaf:sc.getLeaf());
				cns.add(cn);
				addNodes(cn, basePath);
			}
			node.setChildren(cns);
		}else{
			//if(node.getLeaf() == 1)
				//node.setIcon(basePath+"css/zTreeStyle/img/cube.png");
			return;
		}
	}

	@Autowired
	private SysCatalogMapper sysCatalogMapper;
	@Resource(name="catalog")
	CatalogInitialization catalog
}