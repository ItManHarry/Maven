package com.fs.dao.mapper;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.fs.dao.beans.ServerInfoBean;
import com.fs.dao.entities.ServerInfo;
/**
 * 服务器信息操作 DAO INTERFACE
 * @author HARRY
 * @date 2017-07-06
 */
public interface ServerInfoMapper {
	/**
	 * 新增服务器信息
	 * @param si
	 * @return
	 */
	int addServer(ServerInfo si);
	/**
	 * 修改服务器信息
	 * @param si
	 * @return
	 */
	int updateServer(ServerInfo si);
	/**
	 * 获取服务器信息
	 * @param tid
	 * @return
	 */
	ServerInfo getServer(int tid);
	/**
	 * 获取所有的服务器信息
	 * @param offet
	 * @param limit
	 * @return
	 */
	List<ServerInfoBean> getAll(@Param("offet")int offet, @Param("limit")int limit);
	/**
	 * 获取服务器记录条数
	 * @return
	 */
	int getServerCnt();
}
