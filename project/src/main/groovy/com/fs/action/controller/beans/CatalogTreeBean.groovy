package com.fs.action.controller.beans
/**
 * 目录树节点bean
 * @author 程国前
 * 20170620
 */
class CatalogTreeBean implements Serializable{

	CatalogTreeBean(){
		
	}
	
	int 	id			//菜单ID
	int 	pId 		//父节点ID
	String 	name		//菜单名称
	boolean open		//是否展开
	String  icon		//图标
	String 	iconOpen	//展开时的图标
	String 	iconClose	//闭合时的图标
	int     leaf		//是否是最终目录(1:否 2:是)
	List<CatalogTreeBean> children//子节点
}
