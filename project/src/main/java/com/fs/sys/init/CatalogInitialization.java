package com.fs.sys.init;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.PostConstruct;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import com.fs.dao.entities.SysCatalog;
import com.fs.dao.mapper.SysCatalogMapper;
/**
 * 目录清单初始化
 * @author 程国前
 * 2017-06-20
 */
public class CatalogInitialization implements InitializingBean{
	
	public CatalogInitialization() {    
         
    }    
       
    @PostConstruct    
    public void postConstruct() {    
        
    }  
    
    public void afterPropertiesSet() throws Exception {
		
	}
    /**
	 * 初始化目录节点
	 * @throws Exception
	 */
	public void init() throws Exception{
		List<SysCatalog> catalog = sysCatalogMapper.getAllCatalog();
		for(SysCatalog sc : catalog){
			cm.put(sc.getTid(), sysCatalogMapper.getChildCatalog(sc.getTid()));
		}
	}
	/**
	 * 重置目录节点
	 * @throws Exception
	 */
	public void reset() throws Exception{
		cm.clear();
		List<SysCatalog> catalog = sysCatalogMapper.getAllCatalog();
		for(SysCatalog sc : catalog){
			cm.put(sc.getTid(), sysCatalogMapper.getChildCatalog(sc.getTid()));
		}
	}
	
	public Map<Integer, List<SysCatalog>> getCm() {
		return cm;
	}
	public void setCm(Map<Integer, List<SysCatalog>> cm) {
		this.cm = cm;
	}
	@Autowired
	private SysCatalogMapper sysCatalogMapper;
	private Map<Integer, List<SysCatalog>> cm = new HashMap<Integer, List<SysCatalog>>();
}
