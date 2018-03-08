package com.fs.action.controller.document
import java.text.SimpleDateFormat
import javax.annotation.Resource
import javax.servlet.http.HttpServletResponse
import javax.servlet.http.HttpSession
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import com.fs.dao.entities.SysDocument
import com.fs.dao.mapper.SysDocumentMapper
import com.fs.util.config.SysPropertiesConfig
import com.sun.corba.se.impl.resolver.SplitLocalResolverImpl
import net.sf.json.JSONArray
import net.sf.json.JSONObject
@Controller
@RequestMapping("/sys/doc")
class DocumentActionController {
	/**
	 * 获取某个目录下的所有文件
	 * @param catalog  	目录
	 * @param flag  	区分('U':目录下当前登录者上传的文件, 'A':目录下所有上传者上传的文件)
	 * @param response
	 */
	@RequestMapping("/getDocuments")
	void getDocuments(int catalog, String flag, HttpServletResponse response, HttpSession session){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			String userid = session.getAttribute("loginId")
			//Do query
			def qr = null
			if(flag == 'A')
				qr = sysDocumentMapper.getDocumentsByCatalog(catalog)
			if(flag == 'U')
				qr = sysDocumentMapper.getMyDocuments(catalog, userid)
			def rows = []
			qr.each{
				def data = [:]
				data.put("tid", it.getTid())
				data.put("docName", it.getDocName())
				data.put("folderPath", it.getFolderPath())
				data.put("uploadedDt",new SimpleDateFormat("yyyy-MM-dd").format(it.getUploadedDt()))
				rows << data
			}
			JSONArray ds = JSONArray.fromObject(rows)
			out.print(ds.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	@RequestMapping("/getAllDocuments")
	void getAllDocuments(int offset, int limit, String url, int catalog, String docName, HttpServletResponse response){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			if(docName == null)
				docName = ""
			//Do query
			def qr = sysDocumentMapper.getAllDocuments(offset, limit, catalog, docName)
			def rws = []
			qr.each{
				def record = [:]
				record.put("tid", it.getTid());
				record.put("docName", it.getDocName());
				record.put("folderPath", it.getFolderPath());
				record.put("uploadedDt",new SimpleDateFormat("yyyy-MM-dd").format(it.getUploadedDt()));
				record.put("action", "<a href = '"+url+it.getTid()+"' class = 'btn btn-link'><i class='fa fa-download'></i>&nbsp;&nbsp;下载</a>");
				rws << record
			}
			def json = [:]
			json.put("total", sysDocumentMapper.getDocCnt(catalog, docName))
			json.put("rows", rws)
			JSONObject root = JSONObject.fromObject(json)
			out.print(root.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	@RequestMapping("/deleteDocument")
	void deleteDocument(int tid, HttpServletResponse response){
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			//文件磁盘删除
			SysDocument sd = sysDocumentMapper.getDocument(tid)
			String dirPath = config.getFileUploadPath()+sd.getSavePath().split("/")[0]  //文件目录路径
			String filePath = config.getFileUploadPath()+sd.getSavePath()				//文件路径
			//执行文件物理删除
			File file = new File(filePath);
			file.delete()
			//文件夹如果为空,执行删除
			File dir = new File(dirPath)
			if(dir.list().size() == 0)
				dir.deleteDir()
			//执行数据库删除
			sysDocumentMapper.deleteDocument(tid)
			JSONObject ds = JSONObject.fromObject(["result":"文件已删除!"])
			out.print(ds.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	
	@Autowired
	SysDocumentMapper sysDocumentMapper
	@Resource(name="sysPropertiesConfig")
	SysPropertiesConfig config
}
