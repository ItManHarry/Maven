--用户表(没有密码栏位,使用公司AD登陆)
create table sys_user(
	tid int primary key auto_increment,
	usercd varchar(20),
	usernm varchar(20),
	roleid int,
	teamid int,
	status int,
	bg int
);
--系统CODE表
create table sys_code(
	tid int primary key auto_increment,
	code varchar(20),	
	cdvl int,
	cdvw varchar(20)
);
--目录表
create table sys_catalog(
	tid int primary key auto_increment,
	name varchar(150),
	parentId int,
	leaf int,
	status int
);
--目录权限表
create table sys_catalog_auth(
	tid int primary key auto_increment,
	userid int,
	catalog int
);
--文档表
create table sys_document(
	tid int primary key auto_increment,
	docName varchar(200),
	catalog int,
	savePath varchar(200),
	folderPath varchar(300),
	uploadedBy varchar(20),
	uploadedDt date
);
--文档版本表
create table sys_document_version(
	tid int primary key auto_increment,
	docId int,
	version int,
	docPath varchar(200),
	changedBy varchar(20),
	changedDt date
);
--Team表
create table sys_team(
	tid int primary key auto_increment,
	teamcd varchar(10),
	teamnm varchar(20),
	bg int
);
--系统角色
create table sys_role(
	tid int primary key auto_increment,
	rolecd varchar(10),
	rolenm varchar(20),
	status int
);
--服务器信息表
create table server_info(
	tid int primary key auto_increment,
	machineName varchar(100),		
	machineModel varchar(100),	
	machineUsage varchar(100),	
	serialNumber varchar(100),	
	rent int,				
	rentEndDt date,
	os int,					
	ip varchar(30),				
	cpuModel varchar(100),		
	cpuCore varchar(20),			
	memory varchar(20),
	disk varchar(20),
	usageCategory int,		
	middleware int,			
	envirDistinguish int,	
	machineAdd int,			
	run int,				
	manageBy int
);