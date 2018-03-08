package com.fs.dao.mapper;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.fs.dao.entities.SysDocument;
/**
 * 文档操作DAO INTERFACE
 * @author HARRY
 * @time 2017-06-27
 */
public interface SysDocumentMapper {
	/**
	 * 新增文档
	 * @param document
	 * @return
	 */
	int add(SysDocument document);
	/**
	 * 根据ID获取文档
	 * @param tid
	 * @return
	 */
	SysDocument getDocument(int tid);
	/**
	 * 获取文件夹下的所有文件
	 * @param catalog
	 * @return
	 */
	List<SysDocument> getDocumentsByCatalog(int catalog);
	/**
	 * 获取用户上传的所有文件
	 * @param uploadedBy
	 * @return
	 */
	List<SysDocument> getDocumentsByUploader(String uploadedBy);
	/**
	 * 获取用户某个目录下上传的文件
	 * @param catalog
	 * @param uploadedBy
	 * @return
	 */
	List<SysDocument> getMyDocuments(@Param("catalog")int catalog, @Param("uploadedBy")String uploadedBy);
	/**
	 * 分页获取所有文件
	 * @param offet
	 * @param limit
	 * @return
	 */
	List<SysDocument> getAllDocuments(@Param("offet")int offet, @Param("limit")int limit,  @Param("catalog")int catalog, @Param("docName")String docName);
	/**
	 * 获取文档总数
	 * @return
	 */
	int getDocumentCnt();
	/**
	 * 根据查询条件获取文档总数
	 * @return
	 */
	int getDocCnt(@Param("catalog")int catalog, @Param("docName")String docName);
	/**
	 * 根据ID删除文档
	 * @param tid
	 */
	void deleteDocument(int tid);
}
