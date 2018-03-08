package com.fs.dao.entities;
import java.io.Serializable;
import java.sql.Date;
/**
 * 文档版本信息
 * @author Harry
 * @time 2017-06-14
 */
public class SysDocumentVersion implements Serializable {

	public SysDocumentVersion(){
		
	}
	
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	public int getDocId() {
		return docId;
	}
	public void setDocId(int docId) {
		this.docId = docId;
	}
	public int getVersion() {
		return version;
	}
	public void setVersion(int version) {
		this.version = version;
	}
	public String getDocPath() {
		return docPath;
	}
	public void setDocPath(String docPath) {
		this.docPath = docPath;
	}
	public String getChangedBy() {
		return changedBy;
	}
	public void setChangedBy(String changedBy) {
		this.changedBy = changedBy;
	}
	public Date getChangedDt() {
		return changedDt;
	}
	public void setChangedDt(Date changedDt) {
		this.changedDt = changedDt;
	}

	private int tid;
	private int docId;			//文档ID
	private int version;		//版本
	private String docPath;		//文件物理路径
	private String changedBy;	//修改人员
	private Date changedDt;		//修改时间
	private static final long serialVersionUID = 7431079186533037630L;
}
