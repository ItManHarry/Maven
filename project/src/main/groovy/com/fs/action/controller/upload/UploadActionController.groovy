package com.fs.action.controller.upload
import java.sql.SQLClientInfoException
import javax.annotation.Resource
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import javax.servlet.http.HttpSession
import org.apache.catalina.connector.RequestFacade.GetAttributePrivilegedAction
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile
import org.springframework.web.multipart.commons.CommonsMultipartResolver
import com.sun.org.apache.bcel.internal.generic.FDIV
import net.sf.json.JSONObject
import com.fs.dao.entities.SysDocument
import com.fs.dao.entities.SysDocumentVersion
import com.fs.dao.mapper.SysDocumentMapper
import com.fs.dao.mapper.SysDocumentVersionMapper
import com.fs.util.config.SysPropertiesConfig
@Controller
@RequestMapping("/sys/upload/file")
class UploadActionController {
	
	@RequestMapping("/doUpload")
	void doUpload(@RequestParam("file") MultipartFile[] files, int catalog, String fullPath, HttpServletResponse response, HttpSession session){	
		try {
			response.setContentType("application/json")
			response.setHeader("Pragma", "No-cache")
			response.setHeader("Cache-Control", "no-cache")
			response.setCharacterEncoding("UTF-8")
			PrintWriter out = response.getWriter()
			String userid = session.getAttribute("loginId")
			def date = new java.sql.Date(new Date().getTime())
			String result = ""
			//执行上传
			if(files.size() != 0){
				String subDir = new Date().getTime()+"/"
				String dir = config.getFileUploadPath() + subDir
				File fd = new File(dir)
				if(!fd.exists())
					fd.mkdir()
				files.each{
					def path = dir + it.getOriginalFilename()
					def dbPath = subDir + it.getOriginalFilename()
					it.transferTo(new File(path))
					//保存到数据库-文档信息
					SysDocument sd = new SysDocument()
					sd.setDocName(it.getOriginalFilename())
					sd.setCatalog(catalog)
					sd.setFolderPath(fullPath)
					sd.setSavePath(dbPath)
					sd.setUploadedBy(userid)
					sd.setUploadedDt(date)
					sysDocumentMapper.add(sd)
					//版本信息
					SysDocumentVersion version = new SysDocumentVersion()
					version.setDocId(sd.getTid())
					version.setDocPath(dbPath)
					version.setVersion(1)
					version.setChangedBy(userid)
					version.setChangedDt(date)
					sysDocumentVersionMapper.add(version)
				}
				result = "文件上传成功!上传文件个数:${files.size()}"
			}else{
				result = "没有选择文件!上传文件个数:${files.size()}"
			}
			JSONObject json = JSONObject.fromObject(["result":result])
			out.print(json.toString())
			out.flush()
			out.close()
		} catch (IOException e) {
			e.printStackTrace()
		}
	}
	
	//其他上传方式
	@RequestMapping("/upload")
	String upload(HttpServletRequest request){
		CommonsMultipartResolver cmr = new CommonsMultipartResolver(request.getSession().getServletContext())
		if(cmr.isMultipart(request)){
			String dir = config.getFileUploadPath() + new Date().getTime()+"/"
			File fd = new File(dir)
			if(!fd.exists())
				fd.mkdir()
			MultipartHttpServletRequest mr = (MultipartHttpServletRequest)request
			def files = mr.getFileNames().toList()
			files.each{
				MultipartFile file = mr.getFile(it)
				if(file){
					def path = dir + file.getOriginalFilename()
					file.transferTo(new File(path))
				}
			}
		}
		return "index"
	}
	/**
	 * 采用file.Transto 来保存上传的文件
	 * @param file
	 * @return
	 */
	@RequestMapping("/transto")
	String transto(@RequestParam("file") CommonsMultipartFile file){
		String dir = config.getFileUploadPath() + new Date().getTime()+"/"
		File fd = new File(dir)
		if(!fd.exists())
			fd.mkdir()
		String toPath = dir + file.getOriginalFilename()
		File toFile = new File(toPath)
		if(!toFile.exists())
			toFile.mkdir()
		file.transferTo(toFile)
		return "index"
	}
	
	@Resource(name="sysPropertiesConfig")
	SysPropertiesConfig config
	@Autowired
	SysDocumentMapper sysDocumentMapper
	@Autowired
	SysDocumentVersionMapper sysDocumentVersionMapper
}
