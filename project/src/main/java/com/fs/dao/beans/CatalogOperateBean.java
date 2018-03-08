package com.fs.dao.beans;
import java.io.Serializable;

public class CatalogOperateBean implements Serializable {

	public CatalogOperateBean(){
		
	}
	
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	public String getPtname() {
		return ptname;
	}
	public void setPtname(String ptname) {
		this.ptname = ptname;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	private int tid;
	private String ptname;
	private String name;
	private String status;
	private static final long serialVersionUID = -8123674460282061976L;
}
