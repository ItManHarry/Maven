package com.fs.dao.beans;
import java.io.Serializable;

public class SysUserBean implements Serializable {

	public SysUserBean(){
		
	}
	
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	public String getUsercd() {
		return usercd;
	}
	public void setUsercd(String usercd) {
		this.usercd = usercd;
	}
	public String getUsernm() {
		return usernm;
	}
	public void setUsernm(String usernm) {
		this.usernm = usernm;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getTeam() {
		return team;
	}
	public void setTeam(String team) {
		this.team = team;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getBg() {
		return bg;
	}
	public void setBg(String bg) {
		this.bg = bg;
	}
	private int tid;	
	private String usercd; 	//用户ID
	private String usernm;	//用户姓名
	private String role;	//角色ID
	private String team;	//组织ID
	private String status;	//系统状态 1:在用 2:停用
	private String bg;		//法人所属
	private static final long serialVersionUID = -3080396054120594534L;
}
