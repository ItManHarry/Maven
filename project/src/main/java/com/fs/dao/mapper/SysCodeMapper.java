package com.fs.dao.mapper;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.fs.dao.entities.SysCode;
/**
 * 系统CODE DAO INTERFACE
 * @author HARRY
 * @date 2017-06-14
 */
public interface SysCodeMapper {
	/**
	 * 添加CODE
	 * @param sysCode
	 * @return
	 */
	int addCode(SysCode sysCode);								
	/**
	 * 修改CODE
	 * @param sysCode
	 * @return
	 */
	int updateCode(SysCode sysCode);							
	/**
	 * 根据id获取CODE
	 * @param tid
	 * @return
	 */
	SysCode getCode(int tid);
	/**
	 * 获取code总记录数
	 * @return
	 */
	int getCodeCnt();
	/**
	 * 分页查询所有的CODE
	 * @param offet 起始记录
	 * @param limit	记录条数
	 * @return
	 */
	List<SysCode> getAll(@Param("offet")int offet, @Param("limit")int limit);
	/**
	 * 根据CODE获取所有下拉值
	 * @param code
	 * @return
	 */
	List<SysCode> getValues(@Param("code")String code);		
}
