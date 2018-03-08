package com.fs.dao.mapper;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.fs.dao.beans.SysTeamBean;
import com.fs.dao.entities.SysTeam;
/**
 * Team管理
 * 系统CODE DAO INTERFACE
 * @author HARRY
 * @date 2017-06-14
 */
public interface SysTeamMapper {
	/**
	 * 添加Team
	 * @param sysTeam
	 * @return
	 */
	int addTeam(SysTeam sysTeam);								
	/**
	 * 修改Team
	 * @param sysTeam
	 * @return
	 */
	int updateTeam(SysTeam sysTeam);							
	/**
	 * 根据id获取Team
	 * @param tid
	 * @return
	 */
	SysTeam getTeam(int tid);
	/**
	 * 分页查询所有的Team
	 * @param offet 起始记录
	 * @param limit	记录条数
	 * @return
	 */
	List<SysTeamBean> getAll(@Param("offet")int offet, @Param("limit")int limit);
	/**
	 * 根据bg获取所有的Team
	 * @return
	 */
	List<SysTeam> getTeams(int bg);	
	/**
	 * 获取Team总记录数
	 * @return
	 */
	int getTeamCnt();
}