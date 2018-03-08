package com.fs.action.controller.download
import javax.annotation.Resource
import javax.servlet.http.HttpServletRequest
import javax.servlet.http.HttpServletResponse
import org.apache.commons.io.FileUtils
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpHeaders
import org.springframework.http.HttpStatus
import org.springframework.http.MediaType
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import com.fs.dao.entities.SysDocument
import com.fs.dao.mapper.SysDocumentMapper
import com.fs.util.config.SysPropertiesConfig
@Controller
@RequestMapping("/sys/download/file")
class DownloadActionController {

	//ie浏览器支持不好,谷歌支持此下载方式
	@RequestMapping("/single")
	ResponseEntity<byte[]> download(int docId){
		SysDocument sd = sysDocumentMapper.getDocument(docId)
		String path = config.getFileUploadPath() + sd.getSavePath()
		File file = new File(path)
		HttpHeaders headers = new HttpHeaders()
		String fileName = new String(sd.getDocName().getBytes("UTF-8"),"iso-8859-1")//解决中文名称乱码问题
		headers.setContentDispositionFormData("attachment", fileName)
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM)
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),
										  headers, HttpStatus.CREATED)
	}
	
	/**
	 * 文件下载
	 * @Description:
	 * @param docId
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/download")
	String download(@RequestParam("docId")int docId,
			HttpServletRequest request, HttpServletResponse response) {
		SysDocument sd = sysDocumentMapper.getDocument(docId)
		if (sd != null) {
			String path = config.getFileUploadPath() + sd.getSavePath()
			File file = new File(path)
			if (file.exists()) {
				String fileName = new String(sd.getDocName().getBytes("GBK"), "ISO-8859-1") 	//解决中文名称乱码问题
				response.setContentType("application/force-download")							// 设置强制下载不打开
				response.addHeader("Content-Disposition", "attachmentfileName=" + fileName)		// 设置文件名
				byte[] buffer = new byte[1024]
				FileInputStream fis = null
				BufferedInputStream bis = null
				try {
					fis = new FileInputStream(file)
					bis = new BufferedInputStream(fis)
					OutputStream os = response.getOutputStream()
					int i = bis.read(buffer)
					while (i != -1) {
						os.write(buffer, 0, i)
						i = bis.read(buffer)
					}
				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace()
				} finally {
					if (bis != null) {
						try {
							bis.close()
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace()
						}
					}
					if (fis != null) {
						try {
							fis.close()
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace()
						}
					}
				}
			}
		}
		return null
	}
	
	@Resource(name="sysPropertiesConfig")
	SysPropertiesConfig config
	@Autowired
	SysDocumentMapper sysDocumentMapper
}
