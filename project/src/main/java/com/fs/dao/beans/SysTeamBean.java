package com.fs.dao.beans;
import java.io.Serializable;

public class SysTeamBean implements Serializable {

	public SysTeamBean(){
		
	}
	
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	public String getBg() {
		return bg;
	}
	public void setBg(String bg) {
		this.bg = bg;
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
	
	private int tid;
	private String bg;
	private String teamcd;
	private String teamnm;
	private static final long serialVersionUID = 842660212028145650L;
}
