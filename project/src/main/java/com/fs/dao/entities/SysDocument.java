package com.fs.dao.entities;
import java.io.Serializable;
import java.sql.Date;
/**
 * 系统文件
 * @author Harry
 * @time 2017-06-14
 */
public class SysDocument implements Serializable {

	public SysDocument(){
		
	}
	
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	public String getDocName() {
		return docName;
	}
	public void setDocName(String docName) {
		this.docName = docName;
	}
	public int getCatalog() {
		return catalog;
	}
	public void setCatalog(int catalog) {
		this.catalog = catalog;
	}
	public String getSavePath() {
		return savePath;
	}
	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}
	public String getFolderPath() {
		return folderPath;
	}
	public void setFolderPath(String folderPath) {
		this.folderPath = folderPath;
	}
	public String getUploadedBy() {
		return uploadedBy;
	}
	public void setUploadedBy(String uploadedBy) {
		this.uploadedBy = uploadedBy;
	}
	public Date getUploadedDt() {
		return uploadedDt;
	}
	public void setUploadedDt(Date uploadedDt) {
		this.uploadedDt = uploadedDt;
	}

	private int tid;
	private String docName;		//文档名称
	private int catalog;		//文档目录
	private String savePath;	//文档物理路径
	private String folderPath;	//文档目录路径
	private String uploadedBy;	//上传人员
	private Date uploadedDt;	//上传时间
	private static final long serialVersionUID = -3176092259406220008L;
}
