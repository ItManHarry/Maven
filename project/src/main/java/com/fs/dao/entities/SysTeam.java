package com.fs.dao.entities;
import java.io.Serializable;
/**
 * 组织信息
 * @author Harry
 * @time 2017-06-14
 */
public class SysTeam implements Serializable {

	public SysTeam(){
		
	}
	
	public SysTeam(String teamcd, String teamnm, int bg) {
		super();
		this.teamcd = teamcd;
		this.teamnm = teamnm;
		this.bg = bg;
	}

	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	public String getTeamcd() {
		return teamcd;
	}
	public void setTeamcd(String teamcd) {
		this.teamcd = teamcd;
	}
	public String getTeamnm() {
		return teamnm;
	}
	public void setTeamnm(String teamnm) {
		this.teamnm = teamnm;
	}
	public int getBg() {
		return bg;
	}
	public void setBg(int bg) {
		this.bg = bg;
	}


	private int tid;
	private String teamcd; 	//组织代码
	private String teamnm;	//组织名称
	private int bg;			//法人所属
	private static final long serialVersionUID = -4844793326408775541L;
}
