package com.fs.dao.entities;
import java.io.Serializable;
/**
 * 系统目录
 * @author Harry
 * @time 2017-06-14
 */
public class SysCatalog implements Serializable {

	public SysCatalog(){
		
	}
	
	public SysCatalog(String name, int parentId, int leaf, int status) {
		super();
		this.name = name;
		this.parentId = parentId;
		this.leaf = leaf;
		this.status = status;
	}

	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
	public int getLeaf() {
		return leaf;
	}
	public void setLeaf(int leaf) {
		this.leaf = leaf;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}

	private int tid;
	private String name;	//目录名称
	private int parentId;	//父目录ID
	private int leaf;		//是否最终目录(即无子目录) 1:否 2:是 对应CODE代码:LEAF
	private int status;		//状态 1:在用 2:停用 对应CODE代码:CSTS
	private static final long serialVersionUID = -5879401251196399009L;
}
