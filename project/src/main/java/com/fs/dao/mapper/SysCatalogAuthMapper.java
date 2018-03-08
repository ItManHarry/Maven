package com.fs.dao.mapper;
import java.util.List;
import com.fs.dao.entities.SysCatalogAuth;
/**
 * 目录权限操作 DAO INTERFACE
 * @author HARRY
 * @date 2017-06-23
 */
public interface SysCatalogAuthMapper {
	/**
	 * 执行赋予目录权限
	 * @param sca
	 * @return
	 */
	int execute(SysCatalogAuth sca);
	/**
	 * 删除已赋予的目录权限
	 * @param userid
	 * @return
	 */
	int delete(int userid);
	/**
	 * 获取已赋予的目录权限
	 * @param userid
	 * @return
	 */
	List<SysCatalogAuth> getSysCatalogAuth(int userid);
}
