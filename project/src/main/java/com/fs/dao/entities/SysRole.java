package com.fs.dao.entities;
import java.io.Serializable;
/**
 * 系统角色
 * @author Harry
 * @time 2017-06-14
 */
public class SysRole implements Serializable {

	public SysRole(){
		
	}
	
	public SysRole(String rolecd, String rolenm, int status) {
		super();
		this.rolecd = rolecd;
		this.rolenm = rolenm;
		this.status = status;
	}

	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	public String getRolecd() {
		return rolecd;
	}
	public void setRolecd(String rolecd) {
		this.rolecd = rolecd;
	}
	public String getRolenm() {
		return rolenm;
	}
	public void setRolenm(String rolenm) {
		this.rolenm = rolenm;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	private int tid;
	private String rolecd; 	//组织代码
	private String rolenm;	//组织名称
	private int status;		//法人所属
	private static final long serialVersionUID = -6544774281380850096L;
}
