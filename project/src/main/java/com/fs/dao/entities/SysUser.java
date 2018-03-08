package com.fs.dao.entities;
import java.io.Serializable;
/**
 * 系统用户
 * @author Harry
 * @time 2017-06-14
 */
public class SysUser implements Serializable {

	public SysUser(){
		
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
	public int getRoleid() {
		return roleid;
	}
	public void setRoleid(int roleid) {
		this.roleid = roleid;
	}
	public int getTeamid() {
		return teamid;
	}
	public void setTeamid(int teamid) {
		this.teamid = teamid;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getBg() {
		return bg;
	}
	public void setBg(int bg) {
		this.bg = bg;
	}
	
	private int tid;	
	private String usercd; 	//用户ID
	private String usernm;	//用户姓名
	private int roleid;		//角色ID
	private int teamid;		//组织ID
	private int status;		//系统状态 1:在用 2:停用
	private int bg;			//法人所属
	private static final long serialVersionUID = -5831517463918780957L;
}
