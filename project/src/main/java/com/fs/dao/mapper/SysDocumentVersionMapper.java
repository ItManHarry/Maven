package com.fs.dao.mapper;
import com.fs.dao.entities.SysDocumentVersion;
public interface SysDocumentVersionMapper {
	/**
	 * 新增文档版本
	 * @param version
	 * @return
	 */
	int add(SysDocumentVersion version);
}
