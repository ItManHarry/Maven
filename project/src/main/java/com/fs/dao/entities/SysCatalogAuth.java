package com.fs.dao.entities;
import java.io.Serializable;
/**
 * 系统目录权限
 * @author Harry
 * @time 2017-06-21
 */
public class SysCatalogAuth implements Serializable {

	public SysCatalogAuth(){
		
	}
	
	public SysCatalogAuth(int userid, int catalog) {
		super();
		this.userid = userid;
		this.catalog = catalog;
	}

	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public int getCatalog() {
		return catalog;
	}

	public void setCatalog(int catalog) {
		this.catalog = catalog;
	}

	private int tid;
	private int userid;		//用户ID
	private int catalog;	//目录ID
	private static final long serialVersionUID = 3532429560082367214L;
}
