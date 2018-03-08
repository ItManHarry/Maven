package com.fs.dao.mapper;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.fs.dao.beans.SysUserBean;
import com.fs.dao.entities.SysUser;
/**
 * 系统用户 DAO INTERFACE
 * @author HARRY
 * @date 2017-06-14
 */
public interface SysUserMapper {
	/**
	 * 添加用户
	 * @param sysUser
	 * @return
	 */
	int addUser(SysUser sysUser);								
	/**
	 * 修改用户
	 * @param sysUser
	 * @return
	 */
	int updateUser(SysUser sysUser);							
	/**
	 * 根据id获取用户信息
	 * @param tid
	 * @return
	 */
	SysUser getUser(int tid);
	/**
	 * 根据code获取用户信息
	 * @param usercd
	 * @return
	 */
	SysUser getUserByCode(String usercd);
	/**
	 * 获取用户总记录数
	 * @return
	 */
	int getUserCnt();
	/**
	 * 根据用户代码获取用户总记录数,用以校验用户是否已存在
	 * @return
	 */
	int checkUserCnt(String usercd);
	/**
	 * 分页查询所有的用户
	 * @param offet 起始记录
	 * @param limit	记录条数
	 * @return
	 */
	List<SysUserBean> getAll(@Param("offet")int offet, @Param("limit")int limit);
}