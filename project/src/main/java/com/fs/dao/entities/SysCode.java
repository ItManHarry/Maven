package com.fs.dao.entities;
import java.io.Serializable;
/**
 * 系统下拉基础代码
 * @author Harry
 * @time 2017-06-14
 */
public class SysCode implements Serializable {

	public SysCode(){
		
	}
	
	public SysCode(String code, int cdvl, String cdvw) {
		super();
		this.code = code;
		this.cdvl = cdvl;
		this.cdvw = cdvw;
	}
	
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public int getCdvl() {
		return cdvl;
	}
	public void setCdvl(int cdvl) {
		this.cdvl = cdvl;
	}
	public String getCdvw() {
		return cdvw;
	}
	public void setCdvw(String cdvw) {
		this.cdvw = cdvw;
	}
	
	private int tid;		
	private String code;	//下拉代码
	private int cdvl;		//下拉选项值
	private String cdvw;	//下拉选项显示
	private static final long serialVersionUID = -3525566700384489489L;
}
