package com.fs.dao.entities;
import java.io.Serializable;
import java.sql.Date;
/**
 * 服务器信息
 * @author 程国前
 * @time 20170705
 */
public class ServerInfo implements Serializable {

	public ServerInfo(){
		
	}
	
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	public String getMachineName() {
		return machineName;
	}
	public void setMachineName(String machineName) {
		this.machineName = machineName;
	}
	public String getMachineModel() {
		return machineModel;
	}
	public void setMachineModel(String machineModel) {
		this.machineModel = machineModel;
	}
	public String getMachineUsage() {
		return machineUsage;
	}
	public void setMachineUsage(String machineUsage) {
		this.machineUsage = machineUsage;
	}
	public String getSerialNumber() {
		return serialNumber;
	}
	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}
	public int getRent() {
		return rent;
	}
	public void setRent(int rent) {
		this.rent = rent;
	}
	public Date getRentEndDt() {
		return rentEndDt;
	}
	public void setRentEndDt(Date rentEndDt) {
		this.rentEndDt = rentEndDt;
	}
	public int getOs() {
		return os;
	}
	public void setOs(int os) {
		this.os = os;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getCpuModel() {
		return cpuModel;
	}
	public void setCpuModel(String cpuModel) {
		this.cpuModel = cpuModel;
	}
	public String getCpuCore() {
		return cpuCore;
	}
	public void setCpuCore(String cpuCore) {
		this.cpuCore = cpuCore;
	}
	public String getMemory() {
		return memory;
	}
	public void setMemory(String memory) {
		this.memory = memory;
	}
	public int getUsageCategory() {
		return usageCategory;
	}
	public void setUsageCategory(int usageCategory) {
		this.usageCategory = usageCategory;
	}
	public int getMiddleware() {
		return middleware;
	}
	public void setMiddleware(int middleware) {
		this.middleware = middleware;
	}
	public int getEnvirDistinguish() {
		return envirDistinguish;
	}
	public void setEnvirDistinguish(int envirDistinguish) {
		this.envirDistinguish = envirDistinguish;
	}
	public int getMachineAdd() {
		return machineAdd;
	}
	public void setMachineAdd(int machineAdd) {
		this.machineAdd = machineAdd;
	}
	public int getRun() {
		return run;
	}
	public void setRun(int run) {
		this.run = run;
	}
	public int getManageBy() {
		return manageBy;
	}
	public void setManageBy(int manageBy) {
		this.manageBy = manageBy;
	}
	public String getDisk() {
		return disk;
	}

	public void setDisk(String disk) {
		this.disk = disk;
	}
	private int tid;				//表主键
	private String machineName;		//设备名称
	private String machineModel;	//设备型号
	private String machineUsage;	//设备用途
	private String serialNumber;	//序列号
	private int rent;				//是否租用 对应CODE: RENT 1:是 2:否
	private Date rentEndDt;			//租用到期时间
	private int os;					//操作系统 对应CODE OSTP  1：UNIX 2：LINUX 3：WINDOWS 
	private String ip;				//IP地址
	private String cpuModel;		//CPU型号
	private String cpuCore;			//CPU核数
	private String memory;			//内存大小
	private String disk;			//磁盘容量
	private int usageCategory;		//使用类别 对应CODE: MCHUSAGE 1:DB 2:WEB SERVER ...
	private int middleware;			//中间件 对应CODE: MIDDLEWARE 1：WEBLOGIC 2：TOMCAT 3：NGNIX ...
	private int envirDistinguish;	//环境区分 1：正式服务器  2:测试服务
	private int machineAdd;			//所属机房  对应CODE SERADD 1:北京 2:烟台
	private int run;				//运行状态 1:运行 2:停止
	private int manageBy;			//运维团队 关联sys_team表
	private static final long serialVersionUID = -7517083816574696867L;
}