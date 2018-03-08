package com.fs.dao.mapper;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.fs.dao.beans.CatalogOperateBean;
import com.fs.dao.entities.SysCatalog;
/**
 * 目录操作 DAO INTERFACE
 * @author HARRY
 * @date 2017-06-20
 */
public interface SysCatalogMapper {
	/**
	 * 新增目录
	 * @param catalog
	 * @return
	 */
	int addCatalog(SysCatalog catalog);
	/**
	 * 修改目录
	 * @param catalog
	 * @return
	 */
	int updateCatalog(SysCatalog catalog);
	/**
	 * 获取目录记录条数
	 * @return
	 */
	int getCatalogCnt();
	/**
	 * 根据ID获取目录
	 * @param tid
	 * @return
	 */
	SysCatalog getSysCatalog(int tid);
	/**
	 * 分页查询所有的目录
	 * @param offet 起始记录
	 * @param limit	记录条数
	 * @return
	 */
	List<CatalogOperateBean> getAll(@Param("offet")int offet, @Param("limit")int limit);
	/**
	 * 获取所有的目录
	 * @return
	 */
	List<SysCatalog> getAllCatalog();
	/**
	 * 获取所有的顶级目录
	 * @param parentId
	 * @return
	 */
	List<SysCatalog> getParentCatalog();
	/**
	 * 根据父目录id获取所有的子目录
	 * @param parentId
	 * @return
	 */
	List<SysCatalog> getChildCatalog(int parentId);
}
